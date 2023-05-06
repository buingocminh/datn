import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/configs/constants.dart';
import 'package:datn/services/log_service.dart';

class StorageService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static void getPlaceData() async {
    final data = await _instance.collection(baseDoccumentStorage).doc(placeDoccumentName).collection("data").get();
    Logger.log(data.docs[0].data());
  }
}