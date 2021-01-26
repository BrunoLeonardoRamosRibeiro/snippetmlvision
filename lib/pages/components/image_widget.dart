import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippetmlvision/pages/home/controllers/home_controller.dart';

class ImageWidget extends StatelessWidget {

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Image.file(
        File(homeController.image.value.path),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
