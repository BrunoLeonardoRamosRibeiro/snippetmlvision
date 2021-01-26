import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippetmlvision/pages/home/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Text Recognition'),
          actions: [
            FlatButton(
              onPressed: controller.scanText,
              child: Text(
                'Scan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: controller.image != null
              ? Image.file(
                  File(controller.image.value.path),
                  fit: BoxFit.fitWidth,
                )
              : Container(),
        ),
      ),
    );
  }
}
