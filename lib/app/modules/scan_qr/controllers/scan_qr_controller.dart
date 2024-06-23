import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class ScanQrController extends GetxController {
  final TextEditingController code = TextEditingController();

  void capture(Result result) {
    code.text = result.text;
  }
}
