import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initApp() {
    Future.wait([
      context.read<AppState>().init(),
      Future.delayed(const Duration(milliseconds: 500))
    ]).then((value) {
      print("OK");
      Navigator.of(context).pushReplacementNamed(HomeScreen.id);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}