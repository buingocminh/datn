import 'package:datn/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppState extends ChangeNotifier {

  LatLng userLocation = const LatLng(0, 0);

  Future init() async {
    if(await LocationService.getUserPermission()) {
      userLocation = await LocationService.getUserLocation();
    }
  }
}