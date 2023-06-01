import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/common/string_extension.dart';
import 'package:datn/models/rate_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  late final String address;
  late final String name;
  late final String previewImg;
  late final int type;
  late final LatLng latLong;
  late final String id;
  List? listPreviewImg;
  int? totalReviews;
  List<RateModel>? placeRatings;

  PlaceModel.fromSnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data();
    GeoPoint geoPoint = (data['latLong'] ?? const GeoPoint(0, 0)) as GeoPoint;
    id = snapshot.id;
    address = data['address'] ?? "";
    name = data['name'] ?? "";
    previewImg = data['previewImg'] ?? "";
    type = data['type'] ?? "";
    latLong = LatLng(geoPoint.latitude, geoPoint.longitude);
    listPreviewImg = data['imageList'] ?? [];
  }

  operator ==(Object other) {
    return other is PlaceModel && other.id == id;
  }

  bool isContainKeyWord(String key) {
    if (key.length > 1) {
      return name
              .toLowerCase()
              .replaceAllDiacritics
              .contains(key.replaceAllDiacritics) ||
          address
              .toLowerCase()
              .replaceAllDiacritics
              .contains(key.replaceAllDiacritics);
    } else {
      return name.toLowerCase().contains(key) ||
          address.toLowerCase().contains(key);
    }
  }
}
