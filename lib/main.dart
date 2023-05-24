import 'package:datn/providers/app_state.dart';
import 'package:datn/screens/detail_location/detail_location_screen.dart';
import 'package:datn/screens/auth/sign_in_screen.dart';
import 'package:datn/screens/home_screen.dart';
import 'package:datn/screens/search/search_screen.dart';
import 'package:datn/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'screens/auth/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AppState())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GlobalLoaderOverlay(
        overlayWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        useDefaultLoading: false,
        child: MaterialApp(
          title: 'DATN',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id: (_) => const SplashScreen(),
            HomeScreen.id: (_) => const HomeScreen(),
            SearchScreen.id: (_) => const SearchScreen(),
            SignInScreen.id: (_) => const SignInScreen(),
            SignUpScreen.id: (_) => const SignUpScreen(),
            DetailLocationScreen.id: (_) => const DetailLocationScreen(),
          },
        ),
      ),
    );
  }
}
