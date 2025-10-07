import 'dart:io';

import 'package:get/get.dart';
import 'package:globcare/app/base_controller/base_controller.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfLogic extends BaseController {

 late File file;

 // PdfViewerController pdfViewerController = PdfViewerController();


 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // pdfViewerController.zoomLevel=10;



    file=File(Get.arguments);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    // pdfViewerController.dispose();
  }

}
