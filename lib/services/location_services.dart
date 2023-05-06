import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static Future<bool> getUserPermission() async {
    LocationPermission  permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    
    if (permission == LocationPermission.deniedForever) { 
      return false;
    }
    return true; 
  }

  static Future<LatLng> getUserLocation() async {
    Position position =  await Geolocator.getCurrentPosition();
    return LatLng(position.latitude , position.longitude);
  }
}