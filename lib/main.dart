
import 'package:cam_app/camera_view.dart';
import 'package:cam_app/sharedPreference.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'img_picker.dart';

late List<CameraDescription> cameras;

Future<void> main() async{
WidgetsFlutterBinding.ensureInitialized();
cameras=await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      ImgPickerView()
      // SharedPreference()
      // CameraView()
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

}

