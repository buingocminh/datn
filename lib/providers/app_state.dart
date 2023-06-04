import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/models/rate_model.dart';
import 'package:datn/services/location_services.dart';
import 'package:datn/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../configs/constants.dart';
import '../models/user_model.dart';

class AppState extends ChangeNotifier {
  LatLng userLocation = const LatLng(0, 0);
  List<PlaceModel> listPlace = [];
  List<Map<String, dynamic>> listPlaceType = [];
  int? _sortedType;
  GoogleMapController? mapController;
  Polyline? _userDirection;
  UserModel? user;
  List<PlaceModel> favoritePlace = [];

  int? get sortedType => _sortedType;
  Polyline? get userDirection => _userDirection;

  AppState() {
    if (FirebaseAuth.instance.currentUser != null) {
      StorageService.getUserData(FirebaseAuth.instance.currentUser?.uid ?? "")
          .then((value) {
             user = value;
             getUserFavoriteData();
          });
    }
  }

  set sortedType(int? value) {
    _sortedType = value;
    if (value == null) {
      StorageService.getPlaceData().then((value) {
        listPlace = value;
        notifyListeners();
      });
    } else {
      StorageService.getPlaceDataByType(value).then((value) {
        listPlace = value;
        notifyListeners();
      });
    }
  }

  set userDirection(Polyline? value) {
    _userDirection = value;
    notifyListeners();
  }

  Future setUserDirection(LatLng place) async {
    userLocation = await LocationService.getUserLocation();
    var result = await LocationService.getDirection(userLocation, place);
    _userDirection = Polyline(
        polylineId: const PolylineId("1"),
        points: result,
        color: Colors.blue.shade300,
        width: 5);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: result.first, zoom: defaultMapZoom)));
    notifyListeners();
  }

  Future init() async {
    final permisstion = await LocationService.getUserPermission();

    if (permisstion) {
      userLocation = await LocationService.getUserLocation();
    }
    listPlace = await StorageService.getPlaceData();
    listPlaceType = await StorageService.getPlaceType();
    notifyListeners();
  }

  Future signUpUser(Map<String, dynamic> data) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: data["email"], password: data["password"]);
      await StorageService.recordUserSignUp(
          data, FirebaseAuth.instance.currentUser?.uid ?? "");
      user = await StorageService.getUserData(
          FirebaseAuth.instance.currentUser?.uid ?? "");
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == "'weak-password'") {
        throw "Mật khẩu quá ngắn";
      }
      if (e.code == 'email-already-in-use') {
        throw "Tài khoản đã tồn tại";
      }
    } catch (e) {
      throw "Không thể đăng ký tài khoản, vui lòng thử lại";
    }
  }

  Future signInUser(Map<String, dynamic> data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data["email"], password: data["password"]);
      user = await StorageService.getUserData(
          FirebaseAuth.instance.currentUser?.uid ?? "");
      getUserFavoriteData();
      notifyListeners();
      inspect(user);
    } catch (e) {
      throw "Tài khoản hoặc mật khẩu không đúng";
    }
  }

  Future logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      user = null;
      favoritePlace = [];
      notifyListeners();
    } catch (e) {
      throw "Không thể đăng xuất, vui lòng thử lại";
    }
  }

  Future getUserFavoriteData() async {
    favoritePlace = await StorageService.getPlaceById(user?.favoritePlaces ?? []);
    notifyListeners();
  }

  Future addUserFavoritePlace(PlaceModel place) async {
    if(!favoritePlace.contains(place)) {
      favoritePlace.add(place);
      user?.favoritePlaces.add(place.id);
      notifyListeners();
      try {
        await StorageService.updateUserData(user);
      } catch(e) {
        favoritePlace.remove(place);
        user?.favoritePlaces.remove(place.id);
        notifyListeners();
      }
    }
  }

  Future removeUserFavoritePlace(PlaceModel place) async {
    if(favoritePlace.contains(place)) {
      favoritePlace.remove(place);
      user?.favoritePlaces.remove(place.id);
      notifyListeners();
      try {
        await StorageService.updateUserData(user);
      } catch(e) {
        favoritePlace.add(place);
        user?.favoritePlaces.add(place.id);
        notifyListeners();
      }
    }
  }

  bool isPlaceFavorite(PlaceModel place) {
    return favoritePlace.contains(place);
  }


  Future<void> recordRating(RateModel data) async {
    try {
      await StorageService.recordRatingItem(data);
    } catch (e) {
      throw "Đánh gia không thành công";
    }
  }

  List<RateModel> convertRatingData(List<DocumentSnapshot<Object?>> documents) {
    var listRatings = <RateModel>[];
    for (var document in documents) {
      var data = document.data() as Map<String, dynamic>;
      Timestamp timestamp = document['date'];

      listRatings.add(
        RateModel(
          id: document.id,
          userId: data['userId'] ?? '',
          comment: data['comment'] ?? '',
          dateTime: timestamp.toDate(),
          score: double.tryParse(data['score'].toString()) ?? 0.0,
          userName: data['nameUser'] ?? '',
        ),
      );
    }
    return listRatings;
  }

  String convertDateTime(DateTime dateTime) {
    if (isSameDay(dateTime, DateTime.now())) {
      return DateFormat('HH:mm').format(dateTime);
    }
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  TotalRateModel countRating(List<RateModel> listRatings) {
    final listStar = TotalRateModel(
      oneStar: 0,
      twoStar: 0,
      threeStar: 0,
      fourStar: 0,
      fiveStar: 0,
    );

    for (final item in listRatings) {
      if (item.score == 1.0) {
        listStar.oneStar++;
        continue;
      }
      if (item.score == 2.0) {
        listStar.twoStar++;
        continue;
      }
      if (item.score == 3.0) {
        listStar.threeStar++;
        continue;
      }
      if (item.score == 4.0) {
        listStar.fourStar++;
        continue;
      }
      listStar.fiveStar++;
    }

    return listStar;
  }

  bool checkUserCommented(List<RateModel> listRatings, String uid) {
    if (uid == '') {
      return false;
    }
    if (listRatings.firstWhereOrNull((element) => element.userId == uid) !=
        null) {
      return true;
    }
    return false;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> getRatingPlace(String idPlace) async {
    try {
      await StorageService.getRatingPlace(idPlace);
    } catch (e) {
      throw "Something wrong";
    }
  }
}
