import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippetmlvision/pages/components/image_widget.dart';
import 'package:snippetmlvision/pages/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = '';
  PickedFile _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Text Recognition'),
          actions: [
            FlatButton(
              onPressed: ()=> replaceCaracters('65700-000'),
              child: Text(
                'Scan',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          child: Icon(Icons.add_a_photo),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: _image != null
              ? Image.file(
            File(_image.path),
            fit: BoxFit.fitWidth,
          )
              : Container(),
        ));
  }

  // ignore: missing_return
  String transformToPlainText(String text){
    List<String> coded = ["-", ".", "/"]; 
    List<String> decoded = ["", "", ""];
    Map<String, String> map = new Map.fromIterables(coded, decoded);
    final result = map.entries
        .fold(text, (prev, e) => prev.replaceAll(e.key, e.value));
    print(result);
  }


  Future <void> mandar() async{
    String phone = '+5599982746175';
    String urlEncode = Uri.encodeFull('http://maps.google.com/maps?q=-4.2280,-44.7975');
    await launch("sms:${phone}?body=É apenas um teste: ${urlEncode}");
  }

  Future scanText() async {
    showDialog(
        context: context,
        child: Center(
          child: CircularProgressIndicator(),
        ));
    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer textRecognizer =
    FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
    await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + '\n';
      }
    }

    print(_text);

    Navigator.of(context).pop();
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => Details(_text)));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }



}





// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       init: HomeController(),
//       builder: (controller) => Scaffold(
//         appBar: AppBar(
//           title: Text('Text Recognition'),
//           actions: [
//             FlatButton(
//               onPressed: controller.scanText,
//               child: Text(
//                 'Scan',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: controller.getImage,
//           child: Icon(Icons.add_a_photo),
//         ),
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           child: Visibility(
//             visible: controller.image.isBlank,
//             replacement: Container(
//               child: Center(
//                 child: Text('Ainda não carregou path'),
//               ),
//             ),
//             child: ImageWidget(),
//           ),
//         ),
//       ),
//     );
//   }
// }
