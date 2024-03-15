
 import 'dart:io';

import 'package:cam_app/img_preview.dart';
import 'package:cam_app/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _cameraController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController= CameraController(cameras[0], ResolutionPreset.max);//here we can set front or back camera option
    _cameraController.initialize().then((value) {
if(!mounted){
  return;
}
setState(() {

});
    }).catchError((Object e){
if(e is CameraException){
  switch (e.code){
    case 'CameraAccessDenied':
      print("acccess was denied");
      break;
    default:print(e.description);
    break;
  }
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          // width: 300,
          child: CameraPreview(_cameraController),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              // height: 100,
              // width: 100,
              // color: Colors.red,
              margin:EdgeInsets.all(20),
              child: ElevatedButton(
              child:Text("Take a pic"),
                onPressed: ()async {
                  if (!_cameraController.value.isInitialized) {
                    return null;
                  }
                  if (_cameraController.value.isTakingPicture) {
                    return null;
                  }try {
                    await _cameraController.setFlashMode(FlashMode.auto);
                    XFile picture = await _cameraController.takePicture();
                    if(picture!= null){
                   final String directory = (await getDownloadsDirectory())!.path;
                      String imagePath = '${directory}/${DateTime.now().millisecondsSinceEpoch}.jpg';
                      print("filePath---${imagePath}");
                      await picture.saveTo(imagePath);
                    }else {
                      print('No image captured.');
                    }
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ImgPreview(picture)));
                  } on CameraException catch (e) {
                    debugPrint("Error occured while taking picture : $e");
                    return null;
                  }
                }  )
            )
          ],
        )
      ],),
    );
  }

}










//==================================================================

 // import 'package:flutter/material.dart';
 // import 'package:camera/camera.dart';
 //
 // class CameraScreen extends StatefulWidget {
 //   @override
 //   _CameraScreenState createState() => _CameraScreenState();
 // }
 //
 // class _CameraScreenState extends State<CameraScreen> {
 //   late CameraController _cameraController;
 //   late List<CameraDescription> cameras;
 //   int _selectedCameraIndex = 0;
 //
 //   @override
 //   void initState() {
 //     super.initState();
 //     // Initialize camera controller
 //     availableCameras().then((availableCameras) {
 //       cameras = availableCameras;
 //       _initCamera(cameras[_selectedCameraIndex]);
 //     });
 //   }
 //
 //   // Initialize camera with given CameraDescription
 //   void _initCamera(CameraDescription cameraDescription) {
 //     _cameraController = CameraController(
 //       cameraDescription,
 //       ResolutionPreset.max,
 //     );
 //     _cameraController.initialize().then((_) {
 //       if (!mounted) return;
 //       setState(() {});
 //     });
 //   }
 //
 //   // Dispose camera controller when not needed
 //   @override
 //   void dispose() {
 //     _cameraController.dispose();
 //     super.dispose();
 //   }
 //
 //   // Method to switch to front camera
 //   void _switchToFrontCamera() {
 //     if (_selectedCameraIndex == 0) {
 //       _selectedCameraIndex = 1;
 //     } else {
 //       _selectedCameraIndex = 0;
 //     }
 //
 //     _cameraController.dispose();
 //     _initCamera(cameras[_selectedCameraIndex]);
 //   }
 //
 //   @override
 //   Widget build(BuildContext context) {
 //     // Show loading indicator if camera controller is not initialized
 //     if (_cameraController.value.isInitialized) {
 //       return Scaffold(
 //         appBar: AppBar(
 //           title: Text('Camera Screen'),
 //         ),
 //         body: Center(
 //           child: CameraPreview(_cameraController),
 //         ),
 //         floatingActionButton: FloatingActionButton(
 //           onPressed: _switchToFrontCamera,
 //           child: Icon(Icons.switch_camera),
 //         ),
 //       );
 //     } else {
 //       return Scaffold(
 //         body: Center(
 //           child: CircularProgressIndicator(),
 //         ),
 //       );
 //     }
 //   }
 // }
 //
 // void main() {
 //   runApp(MaterialApp(
 //     home: CameraScreen(),
 //   ));
 // }



