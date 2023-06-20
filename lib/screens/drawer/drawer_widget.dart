import 'package:cached_network_image/cached_network_image.dart';
import 'package:datn/configs/constants.dart';
import 'package:datn/models/user_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/place_model.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  late int? type = context.read<AppState>().sortedType;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.7,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10) ,
          child: Selector<AppState, UserModel?>(
            selector: (ctx, state) => state.user,
            builder: (ctx, value, _) {
              if(value == null) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                      ),
                      const Text(
                        "Người dùng ẩn danh \n Đăng nhập để sử dụng nhiều tính năng hơn",
                        textAlign: TextAlign.center,
                      ),
                      DrawerButton(
                        const Icon(Icons.login), 
                        "Đăng nhập", 
                        () {
                          Navigator.of(context).pushNamed(SignInScreen.id);
                        }
                      ),

                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      value.name,
                      textAlign: TextAlign.center,
                    ),
                    DrawerButton(
                      const Icon(Icons.logout), 
                      "Đăng xuất", 
                      () {
                        context.read<AppState>().logoutUser();
                      }
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Địa điểm ưa thích của bạn",
                      ),
                    ),
                    Expanded(
                      child: Selector<AppState, List<PlaceModel>>(
                        selector: (ctx, state) => state.favoritePlace,
                        shouldRebuild:(previous, next) => true,
                        builder: (context, value, child) {
                          if(value.isEmpty) {
                            return const Center(
                              child: Text(
                                "Bạn chưa thêm địa điểm ưa thích nào cả",
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: value.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                minVerticalPadding: 0,
                                leading:  ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: CachedNetworkImage(
                                    imageUrl: value[index].previewImg,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                                title: Text(
                                  value[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  value[index].address,
                                ),
                                onTap: () {
                                  context.read<AppState>().sortedType = null;
                                  context.read<AppState>().mapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: value[index].latLong,
                                        zoom: defaultMapZoom
                                      ),
                                    )
                                  );
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                );
              }
            }
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final Widget icon;
  final String content;
  final VoidCallback callback;
  const DrawerButton(
    this.icon,
    this.content,
    this.callback,
    {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => callback(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 0, 15),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: icon,
            ),
            Flexible(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  content,
                  style: TextStyle(                  
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              )),
          ],
        ),
      ),
    );
  }
}
