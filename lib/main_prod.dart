import 'package:bike_rental/app/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'global.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Global.baseUrl = 'https://prod.url';

  Get.put(AppController());

  runApp(const MyApp());
}
