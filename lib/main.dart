import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() {
  GlobalBindings().dependencies();
  runApp(App());
  configToast();
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab work',
      theme: ThemeData.light(),
      home: AnimatedSplashScreen(
        nextScreen: MainScreen(),
        splash: 'images/yarki.png',
        duration: 100,
        splashTransition: SplashTransition.fadeTransition,
      ),
      builder: EasyLoading.init(),
      getPages: [
        GetPage(name: MainScreen.id, page: () => MainScreen()),
      ],
    );
  }
}
