import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/configs/constants.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/services/log_service.dart';

class StorageService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static Future<List<PlaceModel>> getPlaceData() async {
    List<PlaceModel> list = [];
    final datas = await _instance.collection(baseDoccumentStorage).doc(placeDoccumentName).collection("data").get();
    for(var data in datas.docs) {
      list.add(PlaceModel.fromSnapShot(data));
    }
    return list;
  }
}