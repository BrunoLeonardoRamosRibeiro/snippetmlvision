import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snippetmlvision/pages/home/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder:(controller) => Scaffold(
        appBar: AppBar(
          title: Text('Reconhecimento de Caracteres'),
        ),
        body: Container(),
      ),
    );
  }
}
