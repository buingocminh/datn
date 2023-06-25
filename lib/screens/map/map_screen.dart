import 'package:datn/models/place_model.dart';
import 'package:datn/screens/detail_location/detail_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state.dart';
import '../../services/file_service.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key, required this.listPlace});
  final List<PlaceModel> listPlace;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _controller;
  final Set<Marker> _markerList = {};

  void _onMapCreate(GoogleMapController controller) {
    _controller = controller;
    context.read<AppState>().mapController = controller;
    FileService.getJsonContent("assets/googlemap_config.json").then((value) {
      controller.setMapStyle(value);
    });
    initLocationData();
  }

  Future initLocationData() async {
    _markerList.clear();
    for (var place in widget.listPlace) {
      await _markerList.addLabelMarker(
        LabelMarker(
          label: place.name,
          markerId: MarkerId(place.id),
          textStyle: const TextStyle(
            fontSize: 27,
          ),
          position: place.latLong,
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailLocationScreen(
                    model: place,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initLocationData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AppState, Polyline?>(
        selector: (ctx, state) => state.userDirection,
        builder: (ctx, list, _) {
          return GoogleMap(
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            onMapCreated: _onMapCreate,
            myLocationButtonEnabled: false,
            markers: _markerList,
            polylines: list == null ? {} : {list},
            initialCameraPosition: CameraPosition(
              target: context.read<AppState>().userLocation,
              zoom: 17,
            ),
          );
        });
  }
}
