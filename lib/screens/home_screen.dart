import 'package:datn/configs/constants.dart';
import 'package:datn/services/file_service.dart';
import 'package:datn/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const id = "home_screen";

  void _onMapCreate(GoogleMapController controller) {
    FileService.getJsonContent("assets/googlemap_config.json").then((value) {
      controller.setMapStyle(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          onMapCreated: _onMapCreate,
          myLocationButtonEnabled: false,
          initialCameraPosition:  CameraPosition(
            target: context.read<AppState>().userLocation,
            zoom: defaultMapZoom,
          ),
        ),
      ),
    ) ;
  }
}