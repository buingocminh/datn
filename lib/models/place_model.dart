import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  late final String address;
  late final String name;
  late final String previewImg;
  late final int type;
  late final LatLng latLong;
  late final String id;

  PlaceModel.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String,dynamic> data = snapshot.data();
    GeoPoint geoPoint =  (data['latLong'] ?? const GeoPoint(0, 0)) as GeoPoint;
    id = snapshot.id; 
    address = data['address'] ?? ""; 
    name = data['name'] ?? ""; 
    previewImg = data['previewImg'] ?? ""; 
    type = data['type'] ?? ""; 
    latLong = LatLng(geoPoint.latitude, geoPoint.longitude);
  } 

  operator == (Object other) {
    return other is PlaceModel && other.id == id;
  }

  bool isContainKeyWord(String key) {
    return name.toLowerCase().contains(key) || address.toLowerCase().contains(key);
  }
}