import 'package:datn/configs/constants.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/drawer/drawer_widget.dart';
import 'package:datn/screens/map/map_screen.dart';
import 'package:datn/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      key: _key,
      drawer: const DrawerWidget(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Selector<AppState, List<PlaceModel>>(
              selector: (ctx,state) => state.listPlace,
              builder: (context, value, _) {
                return MapWidget(
                  listPlace: value,
                );
              }
            ),
             Container(
              width:MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () =>  _key.currentState!.openDrawer(),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.menu
                      ),
                    ),
                  ),
                  Expanded(
                    child: Hero(
                      tag: "search",
                      child: Material(
                        color: Colors.transparent,
                        child: TextField(
                          readOnly: true,
                          decoration:  const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            fillColor: Colors.grey,
                            prefixIcon: Icon(
                              Icons.search,
                              // color: Colors.white,
                            ),
                            hintText: "Nhập địa điểm cần tìm",
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            final result = await Navigator.of(context).pushNamed(SearchScreen.id);
                            if(result != null && result is LatLng) {
                                context.read<AppState>().mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: result,zoom: defaultMapZoom)));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    ) ;
  }
}