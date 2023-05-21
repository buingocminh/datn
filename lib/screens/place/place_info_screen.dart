import 'package:datn/models/place_model.dart';
import 'package:flutter/material.dart';

class PlaceInfoScreen extends StatelessWidget {
  const PlaceInfoScreen({super.key, required this.model});
  final PlaceModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(model.name),
      ),
      body: Container(),
    );
  }
}