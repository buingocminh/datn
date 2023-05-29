import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/common/string_extension.dart';

class RateModel {
  late final String id;
  late final String userId;
  late final String comment;
  late final DateTime dateTime;
  late int score;

  RateModel.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data();
    id = snapshot.id;
    userId = data['id'];
    comment = data['comment'] ?? "";
    dateTime = DateTime.parse((data['date'] ?? DateTime.now().toString()));
    score = data['score'];
  }

  operator ==(Object other) {
    return other is RateModel && other.id == id;
  }
}
