import 'package:datn/models/place_model.dart';
import 'package:datn/services/location_services.dart';
import 'package:datn/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppState extends ChangeNotifier {

  LatLng userLocation = const LatLng(0, 0);
  List<PlaceModel> listPlace = [];
  List<Map<String,dynamic>> listPlaceType = [];
  int? _sortedType;
  GoogleMapController? mapController;


  int? get sortedType => _sortedType;


  set sortedType(int? value) {
    _sortedType = value;
    if(value == null) {
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

  Future init() async {
    
    final permisstion = await LocationService.getUserPermission();

    if(permisstion) {
      userLocation = await LocationService.getUserLocation();
    }
    listPlace = await StorageService.getPlaceData();
    listPlaceType = await StorageService.getPlaceType();
    notifyListeners();
  }
}