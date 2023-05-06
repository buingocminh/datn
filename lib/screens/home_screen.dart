import 'package:datn/services/storage_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const id = "home_screen";

  @override
  Widget build(BuildContext context) {
    StorageService.getPlaceData();
    return const Placeholder();
  }
}