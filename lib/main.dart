import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart'; // <-- Added for kIsWeb
import 'package:flutter/material.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/screens/no_internet.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future<bool> checkInternetConnectivity() async {
    if (kIsWeb) {
      // Web does not support dart:io (used in InternetConnectionChecker)
      return true; // Assume connected for web or handle differently if needed
    }

    return await InternetConnectionChecker().hasConnection;
  }

  Widget determineNextScreen(bool isConnected) {
    if (isConnected) {
      return HomePage();
    } else {
      return NoInternetScreen();
    }
  }

  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: checkInternetConnectivity(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isConnected = snapshot.data!;
            return AnimatedSplashScreen(
              duration: 3000,
              splash: Image.asset(
                'assets/images/inclusify.png',
              ),
              nextScreen: determineNextScreen(isConnected),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.white,
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      routes: {
        homeRoute: (context) => HomePage(),
        noInternetRoute: (context) => NoInternetScreen(),
      },
    ),
  );
}
