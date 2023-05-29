import 'dart:developer';

import 'package:datn/models/place_model.dart';
import 'package:datn/services/location_services.dart';
import 'package:datn/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  int? get sortedType => _sortedType;
  Polyline? get userDirection => _userDirection;

  AppState() {
    if (FirebaseAuth.instance.currentUser != null) {
      StorageService.getUserData(FirebaseAuth.instance.currentUser?.uid ?? "")
          .then((value) => user = value);
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

  Future setUserDirection(LatLng place) async {
    userLocation = await LocationService.getUserLocation();
    var result = await LocationService.getDirection(userLocation, place);
    _userDirection = Polyline(
        polylineId: const PolylineId("1"),
        points: result,
        color: Colors.blue.shade300,
        width: 5);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: userLocation, zoom: defaultMapZoom)));
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
      notifyListeners();
    } catch (e) {
      throw "Không thể đăng xuất, vui lòng thử lại";
    }
  }

  Future<void> recordRating(Map<String, dynamic> data) async {
    try {
      await StorageService.recordRatingItem(data, data['placeId']);
    } catch (e) {
      throw "Đánh gia không thành công";
    }
  }
}
