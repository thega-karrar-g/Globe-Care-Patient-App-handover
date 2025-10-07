import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerLogic extends GetxController {
  static TextEditingController qrCtrl = TextEditingController();

  onDetect(BarcodeCapture barcode) {
    if (barcode.barcodes.isEmpty) {
      debugPrint('Failed to scan Barcode');
    } else {
      final String code = barcode.barcodes.first.rawValue ?? "";
      qrCtrl.text = code;

      debugPrint('Barcode found! $code');
      update();
      Future.delayed(
          Duration(
            milliseconds: 500,
          ), () {
        Navigator.pop(Get.context!);
      });
    }
  }
}
