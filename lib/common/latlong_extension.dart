import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLongExtension on LatLng {
  String get  locationString => "$latitude,$longitude"; 
}