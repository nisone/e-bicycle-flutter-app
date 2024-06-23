import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bike_controller.dart';

class BikeView extends GetView<BikeController> {
  const BikeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BikeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BikeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
