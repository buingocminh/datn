import 'package:datn/models/user_model.dart';
import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
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
                      //TODO add logic here
                      // Expanded()
                    ],
                  ),
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
