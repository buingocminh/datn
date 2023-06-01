import 'package:cloud_firestore/cloud_firestore.dart';

class RateModel {
  late final String id;
  late final String userId;
  late final String userName;
  late final String comment;
  late final DateTime dateTime;
  late double score;

  RateModel(
      {required this.id,
      required this.userId,
      required this.comment,
      required this.dateTime,
      required this.score,
      required this.userName});

  RateModel.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data();
    id = snapshot.id;
    userId = data['id'];
    comment = data['comment'] ?? "";
    dateTime = DateTime.parse((data['date'] ?? DateTime.now().toString()));
    score = data['score'];
    userName = data['userName'] ?? '';
  }

  operator ==(Object other) {
    return other is RateModel && other.id == id;
  }
}

class TotalRateModel {
  int oneStar;
  int twoStar;
  int threeStar;
  int fourStar;
  int fiveStar;

  int get total => oneStar + twoStar + threeStar + fourStar + fiveStar;
  double get oneStarPercent => oneStar / total;
  double get twoStarPercent => twoStar / total;
  double get threeStarPercent => threeStar / total;
  double get fourStarPercent => fourStar / total;
  double get fiveStarPercent => fiveStar / total;
  double get totalStarPercent =>
      (5 * fiveStar +
          4 * fourStar +
          3 * threeStar +
          2 * twoStar +
          1 * oneStar) /
      total;

  TotalRateModel({
    required this.oneStar,
    required this.twoStar,
    required this.threeStar,
    required this.fourStar,
    required this.fiveStar,
  });
}
