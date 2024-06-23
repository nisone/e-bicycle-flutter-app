import 'package:bike_rental/app/views/bricks/form_input.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

import '../controllers/scan_qr_controller.dart';

class ScanQrView extends GetView<ScanQrController> {
  const ScanQrView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan to unlock'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Scan Qr code that you find back of the cycle'),
          ),
          Expanded(
            child: QRCodeDartScanView(
              scanInvertedQRCode: true,
              typeScan:
                  GetPlatform.isWeb ? TypeScan.takePicture : TypeScan.live,
              intervalScan: 3.seconds,
              takePictureButtonBuilder: (context, controller, isLoading) {
                // if typeScan == TypeScan.takePicture you can customize the button.
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: controller.takePictureAndDecode,
                    child: const Text('Scan QR'),
                  ),
                );
              },
              widthPreview: 340,
              heightPreview: 340,
              onCapture: controller.capture,
            ),
          ),
          Center(
            child: Text(
              'Having issue?',
              style: Get.theme.textTheme.labelMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: FormInput(
              inputController: controller.code,
              label: 'Enter code manually',
              hint: 'Enter code manually',
            ),
          )
        ],
      ),
    );
  }
}
