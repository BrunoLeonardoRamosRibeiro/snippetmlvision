import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeController extends GetxController{

  RxString text = RxString("");

  Rx<PickedFile> image = Rx<PickedFile>();
  Rx<ImagePicker> picker = Rx<ImagePicker>();

  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    isLoading.value = true;
    print('File--> ${image.isBlank} ');
    print(image == null);
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
    print('File Read --> ${image.isBlank} ');
    isLoading.value = false;
  }


  Future scanText() async {

    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    if (image != null) {
      final FirebaseVisionImage visionImage =
      FirebaseVisionImage.fromFile(File(image.value.path));
      final TextRecognizer textRecognizer =
      FirebaseVision.instance.textRecognizer();
      final VisionText visionText =
      await textRecognizer.processImage(visionImage);

      for (TextBlock block in visionText.blocks) {
        for (TextLine line in block.lines) {
          text.value += line.text + '\n';
        }
      }

      print(text.value);
    }

    /*Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Details(_text)));*/
  }

  Future getImage() async {
    PickedFile pickedFile = await picker.value.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image.value = pickedFile;
    } else {
      print('No image selected');
    }
  }

}