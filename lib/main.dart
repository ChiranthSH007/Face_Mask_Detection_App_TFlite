import 'package:camera/camera.dart';
import 'package:face_mask_detection/splash_screen.dart';
import 'package:flutter/material.dart';

// ignore: avoid_init_to_null
List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Mask Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const splash_screen(),
    );
  }
}
