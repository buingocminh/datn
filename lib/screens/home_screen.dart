import 'package:datn/models/place_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/drawer/drawer_widget.dart';
import 'package:datn/screens/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const id = "home_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Selector<AppState, List<PlaceModel>>(
          selector: (ctx,state) => state.listPlace,
          builder: (context, value, _) {
            return MapWidget(
              listPlace: value,
            );
          }
        )
      ),
    ) ;
  }
}