import 'package:datn/configs/constants.dart';
import 'package:datn/models/place_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/detail_location/detail_location_screen.dart';
import 'package:datn/screens/drawer/drawer_widget.dart';
import 'package:datn/screens/map/map_screen.dart';
import 'package:datn/screens/search/search_screen.dart';
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
              margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                        child: ColoredBox(
                          color: Colors.white,
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
                                  ),
                                  hintText: "Nhập địa điểm cần tìm",
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  final result = await Navigator.of(context).pushNamed(SearchScreen.id);
                                  if(result != null && result is LatLng) {
                                      print("Here");
                                      context.read<AppState>().mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: result,zoom: defaultMapZoom)));
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
                    child: Selector<AppState,Tuple2<int?, List<Map<String,dynamic>>>>(
                      selector: (ctx,state) => Tuple2(state.sortedType, state.listPlaceType),
                      builder: (ctx, value, _) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount:  value.item2.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10,);
                          },
                          itemBuilder: (ctx, index) {
                            return ChoiceChip(
                              label: Text(
                                value.item2[index]['name'],
                                style: const TextStyle(
                                  color: Colors.black
                                ),
                              ), 
                              selected: value.item1 == value.item2[index]["id"],
                              disabledColor: Colors.white,
                              backgroundColor: Colors.white,
                              selectedColor: Colors.blue.shade100,
                              onSelected: (val) {
                                if(val) {
                                  ctx.read<AppState>().sortedType = value.item2[index]["id"];
                                  Navigator.pushNamed(context, DetailLocationScreen.id);
                                } else {
                                  ctx.read<AppState>().sortedType = null;
                                }
                              },
                            );
                            // return Text(value[index]['name']);
                          },
                        );
                      }
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    ) ;
  }
}