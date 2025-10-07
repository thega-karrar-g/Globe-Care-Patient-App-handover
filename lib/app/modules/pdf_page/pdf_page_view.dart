import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/global_widgets/shared/my_appbar.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../core/assets_helper/app_images.dart';
import 'pdf_page_logic.dart';

class PdfPage extends StatelessWidget {
  final logic = Get.put(PdfLogic());

  static const routeName = '/pdf';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<PdfLogic>(builder: (logic) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 60.h, left: 30.w, right: 30.w, bottom: 30.h),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: RotatedBox(
                          quarterTurns: Get.locale.toString() == 'ar' ? 2 : 0,
                          child: SvgPicture.asset(
                            AppImages.back,
                            width: iconSize,
                            height: iconSize,
                          ))),


                ],
              ),
            ),
//             Expanded(
//               child: Container(
//                 color: AppColors.white,
//                 padding: EdgeInsets.symmetric(vertical: 0.h),
//                 child: SfPdfViewer.file(
//                     logic.file,
//                     pageSpacing: 0,
//
//                     controller: logic.pdfViewerController,
// onDocumentLoaded: (p){
//                       logic.update();
// },
//
//                     enableDoubleTapZooming: true),
//               ),
//             ),
//
//             Container(
//
//                 padding: EdgeInsets.symmetric(vertical: 20.h),
//                 child: Text('${logic.pdfViewerController.pageNumber} / ${logic
//                     .pdfViewerController.pageCount}'))

          ],
        );
      }),

    );
  }
}
