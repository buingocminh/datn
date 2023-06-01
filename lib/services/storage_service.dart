import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/configs/constants.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/models/rate_model.dart';
import 'package:datn/services/log_service.dart';

import '../models/user_model.dart';

class StorageService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static Future<List<PlaceModel>> getPlaceData() async {
    List<PlaceModel> list = [];
    final datas = await _instance
        .collection(baseDoccumentStorage)
        .doc(placeDoccumentName)
        .collection("data")
        .get();
    for (var data in datas.docs) {
      list.add(PlaceModel.fromSnapShot(data));
    }
    return list;
  }

  static Future<List<Map<String, dynamic>>> getPlaceType() async {
    List<Map<String, dynamic>> list = [];
    final datas = await _instance
        .collection(baseDoccumentStorage)
        .doc(placeTypeDoccumentName)
        .collection("data")
        .get();
    for (var data in datas.docs) {
      if (data.exists) {
        Map<String, dynamic> placeType = {"id": int.tryParse(data.id)};
        placeType.addAll(data.data());
        list.add(placeType);
      }
    }
    return list;
  }

  static Future<List<PlaceModel>> getPlaceDataByType(int type) async {
    List<PlaceModel> list = [];
    final datas = await _instance
        .collection(baseDoccumentStorage)
        .doc(placeDoccumentName)
        .collection("data")
        .where("type", isEqualTo: type)
        .get();
    for (var data in datas.docs) {
      list.add(PlaceModel.fromSnapShot(data));
    }
    Logger.log(list);
    return list;
  }

   

  static Future<List<PlaceModel>> searchPlaceByKeyWord(String? key) async {
    List<PlaceModel> list = await getPlaceData();
    if (key == null) return [];
    return list
        .where((element) => element.isContainKeyWord(key.toLowerCase()))
        .toList();
  }

  static Future recordUserSignUp(Map<String, dynamic> data, String id) async {
    await _instance
        .collection(baseDoccumentStorage)
        .doc(userDoccumentName)
        .collection("data")
        .doc(id)
        .set({"id": id, "name": data["name"], "email": data['email']});
  }

  static Future recordRatingItem(RateModel data) async {
    await _instance
        .collection(baseDoccumentStorage)
        .doc(placeDoccumentName)
        .collection('data')
        .doc(data.id)
        .collection('rate')
        .doc()
        .set({
      "nameUser": data.userName,
      "uid": data.userId,
      "comment": data.comment,
      "date": Timestamp.fromDate(data.dateTime),
      "score": data.score,
    });
  }

   static Future<List<RateModel>> getRatingPlace(String  idPlace) async {
    List<RateModel> list = [];
    final datas = await _instance
        .collection(baseDoccumentStorage)
        .doc(placeDoccumentName)
        .collection("data")
        .doc(idPlace)
        .collection('rate')
        .get();
    for (var data in datas.docs) {
      list.add(RateModel.fromSnapShot(data));
    }
    Logger.log(list);
    return list;
  }


  static Future<UserModel> getUserData(String id) async {
    var result = await _instance
        .collection(baseDoccumentStorage)
        .doc(userDoccumentName)
        .collection("data")
        .doc(id)
        .get();
    if (result.exists) {
      var data = result.data() ?? {};
      return UserModel(
          id: data["id"] ?? "",
          name: data['name'] ?? "",
          email: data["email"] ?? "");
    }
    throw "Tài khoản hoặc mật khẩu không đúng";
  }

  // static Future<List<PlaceModel>> searchPlaceByKeyWord(String? key) async {
  //   print("searching with $key");
  //   List<PlaceModel> list = [];
  //   final datas = await _instance.
  //     collection(baseDoccumentStorage)
  //       .doc(placeDoccumentName)
  //         .collection("data")
  //           .where("name",isGreaterThanOrEqualTo: key?.toLowerCase())
  //           .where("name", isLessThan: (key ?? "") + z).get().then(
  //             (nameSnapShot) async {
  //               return await _instance.
  //                 collection(baseDoccumentStorage)
  //                   .doc(placeDoccumentName)
  //                     .collection("data")
  //                       .where("address",isGreaterThanOrEqualTo: key).get().then(
  //                         (addressSnapShot) {
  //                           var result =  nameSnapShot.docs;
  //                           result.removeWhere((element) => addressSnapShot.docs.contains(element));
  //                           result.addAll(addressSnapShot.docs);
  //                           return result;
  //                         }
  //                       );
  //             }
  //           );
  //   for(var data in datas) {
  //     list.add(PlaceModel.fromSnapShot(data));
  //   }

  //   Logger.log(list);
  //   return list;
  // }
}
