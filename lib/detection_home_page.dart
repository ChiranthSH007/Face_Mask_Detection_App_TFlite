import 'package:camera/camera.dart';
import 'package:face_mask_detection/main.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class detection_home_page extends StatefulWidget {
  const detection_home_page({Key? key}) : super(key: key);

  @override
  State<detection_home_page> createState() => _detection_home_pageState();
}

class _detection_home_pageState extends State<detection_home_page> {
  late CameraImage imgCamera;
  late CameraController cameraController;
  bool isWoriking = false;
  String result = "";
  int cam = 1;

  initCamera() {
    cameraController = CameraController(cameras![cam], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStram) {
          if (!isWoriking) {
            isWoriking = true;
            imgCamera = imageFromStram;
            runModelOnFrame();
          }
        });
      });
    });
  }

  runModelOnFrame() async {
    var recog = await Tflite.runModelOnFrame(
        bytesList: imgCamera.planes.map((e) {
          return e.bytes;
        }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true);
    result = "";
    recog?.forEach((element) {
      result += element["label"] + "\n";
    });
    setState(() {
      result;
    });
    isWoriking = false;
  }

  @override
  void initState() {
    loadModel();

    super.initState();
    initCamera();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "lib/assets/model.tflite",
      labels: "lib/assets/labels.txt",
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
            title: Text(
          result,
          style: const TextStyle(color: Colors.black),
        )),
        body: Column(
          children: [
            Positioned(
              top: 0,
              left: 0,
              width: size.width,
              height: size.height,
              child: (!cameraController.value.isInitialized)
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController.value.aspectRatio,
                      child: CameraPreview(cameraController),
                    ),
            ),
            Text(result),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        cam = 1;
                        initCamera();
                      });
                    },
                    child: const Text("Front Camera")),
                TextButton(
                    onPressed: () {
                      setState(() {
                        cam = 0;
                        initCamera();
                      });
                    },
                    child: const Text("Back Camera")),
              ],
            )
          ],
        ),
      )),
    );
  }
}
