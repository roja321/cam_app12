import 'dart:io';

import 'package:cam_app/local_pkg/images_picker/lib/images_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';


class ImgPickerView extends StatefulWidget {
  const ImgPickerView({super.key});

  @override
  State<ImgPickerView> createState() => _ImgPickerViewState();
}

class _ImgPickerViewState extends State<ImgPickerView> {
  bool textScaning=false;
  XFile? imageFile;
  String scannedText='';
  var fileName='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image picker"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(!textScaning && imageFile == null)
            Container(constraints: BoxConstraints(maxHeight: 500,),
              height: 200,
              color: Colors.grey,
            ),
            // if(textScaning) const CircularProgressIndicator(),
            if(imageFile != null ) Image.file(File(imageFile!.path)),
            Container(
              // height: 300,
              child: ElevatedButton(onPressed: (){
                getImg();
              }, child: Text("Pic Img")),
            ),
            Container(
              child: ElevatedButton(
                onPressed: _pickFile,
                child: Text('Pick File f'),
              ),
            ),
            Container(height: 50,
                child: Text(fileName)),

          ],
        ),

      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        List<PlatformFile> files = result.files;
            for (PlatformFile file in files) {
          setState(() {
            fileName=file.name;
          });
        }
      } else {}
    } catch (e) {
      print('Error picking file: $e');
    }
  }


  void getImg()async{
    try{
final pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
if(pickedImg != null){
  // textScaning = true;
  imageFile=pickedImg;
  setState(() {
    // getRecognizedText(pickedImg);
  });
}
    }catch(e){
// textScaning=false;
// imageFile=null;
setState(() {

});
scannedText ="Error occured";
    }
  }


//   void getRecognizedText(XFile image)async{
//     final inputImage = InputImage.fromFilePath(image.path);
//     final textDetector = GoogleMlKit.vision.textDetector();
//     RecognisedText recognizedText = await textDetector.processImage(inputImage);
//     await textDetector.close();
//     scannedText = "";
//     for(TextBlock block in recognizedText.blocks){
//       for(TextLine line in block.lines){
// scannedText = scannedText + line.text + "\n";
//       }
//
//     }
//     textScaning = false;
//     setState(() {
//
//     });
//   }


}
