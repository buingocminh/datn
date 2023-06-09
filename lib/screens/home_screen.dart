import 'package:datn/configs/constants.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/map/map_screen.dart';
import 'package:datn/screens/search/search_screen.dart';
import 'package:datn/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _onRequestLocation() async {
    var location = await LocationService.getUserLocation();
    context.read<AppState>().mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: location, zoom: defaultMapZoom)));
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          Selector<AppState, List<PlaceModel>>(
              selector: (ctx, state) => state.listPlace,
              builder: (context, value, _) {
                return MapWidget(
                  listPlace: value,
                );
              }),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ColoredBox(
                        color: Colors.white,
                        child: Hero(
                          tag: "search",
                          child: Material(
                            color: Colors.transparent,
                            child: TextField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.grey,
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                                hintText: "Nhập địa điểm cần tìm",
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                              ),
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                final result = await Navigator.of(context)
                                    .pushNamed(SearchScreen.id);
                                if (result != null && result is LatLng) {
                                  context
                                      .read<AppState>()
                                      .mapController
                                      ?.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: result,
                                                  zoom: defaultMapZoom)));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Selector<AppState,
                          Tuple2<int?, List<Map<String, dynamic>>>>(
                      selector: (ctx, state) =>
                          Tuple2(state.sortedType, state.listPlaceType),
                      builder: (ctx, value, _) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: value.item2.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemBuilder: (ctx, index) {
                            return ChoiceChip(
                              label: Text(
                                value.item2[index]['name'],
                                style: const TextStyle(color: Colors.black),
                              ),
                              selected: value.item1 == value.item2[index]["id"],
                              disabledColor: Colors.white,
                              backgroundColor: Colors.white,
                              selectedColor: Colors.blue.shade100,
                              onSelected: (val) {
                                if (val) {
                                  ctx.read<AppState>().sortedType =
                                      value.item2[index]["id"];
                                } else {
                                  ctx.read<AppState>().sortedType = null;
                                }
                              },
                            );
                          },
                        );
                      }),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Selector<AppState, bool>(
                selector: (ctx, state) => state.userDirection != null,
                builder: (ctx, value, _) {
                  if (!value) return const SizedBox();
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<AppState>().userDirection = null;
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.close),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => _onRequestLocation(),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.my_location),
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      )),
    );
  }
}
