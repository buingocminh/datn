import 'dart:convert';
import 'dart:developer';

import 'package:datn/configs/constants.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../common/latlong_extension.dart';
import 'package:http/http.dart' as http;

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
    try {
      Position position =  await Geolocator.getCurrentPosition();
      return LatLng(position.latitude , position.longitude);
    } catch (e) {
      // var position = await Location().getLocation();
      return LatLng(20.92132771735378,105.85317765128764 );
    }

      // return LatLng(latitude, longitude)
  }

  static Future<List<LatLng>> getDirection(LatLng place, LatLng drop) async {
    List<LatLng> list = [];
    // print(place.)
    print("https://rsapi.goong.io/Direction?origin=${place.locationString}&destination=${drop.locationString}&vehicle=car&api_key=$goongApikey");
    var response = await http.get(
      Uri.parse("https://rsapi.goong.io/Direction?origin=${place.locationString}&destination=${drop.locationString}&vehicle=car&api_key=$goongApikey"),
      // headers: {
        
      // }
    );
    var body = json.decode(response.body);
    var pointLatlong = PolylinePoints().decodePolyline(body['routes'][0]['overview_polyline']['points']);
    for(var point in pointLatlong) {
      list.add(LatLng(point.latitude, point.longitude));
    } 
    return list;
  }
}