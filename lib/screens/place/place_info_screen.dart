import 'package:datn/models/place_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceInfoScreen extends StatelessWidget {
  const PlaceInfoScreen({super.key, required this.model});
  final PlaceModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(model.name),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(onPressed: () {
            context.read<AppState>().setUserDirection(model.latLong);
            Navigator.of(context).pop();
          }, 
          child: Text("press")),
        ),
      ),
    );
  }
}