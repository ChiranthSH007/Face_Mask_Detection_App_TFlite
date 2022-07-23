import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:face_mask_detection/detection_home_page.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      title: const Text(
        "Face Mask Detection",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: const Text("Loading..."),
      navigator: const detection_home_page(),
      durationInSeconds: 5,
      logo: Image.network(
          'https://static.thenounproject.com/png/1280817-200.png'),
    );
  }
}
