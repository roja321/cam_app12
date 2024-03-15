import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as path;
import 'package:path_provider/path_provider.dart';
class ImgPreview extends StatefulWidget {
   ImgPreview(this.file ,{super.key});
  XFile file;


   final picker = ImagePicker();

   @override
  State<ImgPreview> createState() => _ImgPreviewState();
}

class _ImgPreviewState extends State<ImgPreview> {
  @override
  Widget build(BuildContext context) {
    File picture=File(widget.file.path);
    print(picture);
    return Scaffold(
      appBar: AppBar(title:Text("Clicked pic")),
      body: Center(
        child: Column(
          children: [
            Container(
                height: 500,
                child: Image.file(picture)),
            ElevatedButton(onPressed: (){
              getImage();
            }, child: Text("Save"))
          ],
        ),

      ),
    );
  }
  late File _image;
  Future<void> getImage() async {
    final pickedFile = File(widget.file.path);  //await picker.pickImage(source: ImageSource.camera);
    print("pickedFile---${pickedFile}");
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print("_image---${_image}");
      });

      // Store the image in app storage
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      final savedImage = await _image.copy('${appDir.path}/$fileName');
      print('Image saved: ${savedImage.path}');
    }
  }
}
