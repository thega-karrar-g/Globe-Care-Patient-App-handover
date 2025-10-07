import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import 'qr_scanner_logic.dart';

class QrScannerPage extends StatelessWidget {
  final logic = Get.put(QrScannerLogic());

   QrScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              QrScannerLogic.qrCtrl.text.isNotEmpty
                  ? QrScannerLogic.qrCtrl.text
                  : '#######',
              style: AppStyles.primaryStyle(bold: true),
            )),
            UiHelper.horizontalSpaceMedium,
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.close,
                color: AppColors.primaryColor,
                size: 30.h,
              ),
            )
          ],
        ),

        UiHelper.verticalSpaceMedium,
        SizedBox(
            height: Get.height * .4,
            child:
                MobileScanner( onDetect: logic.onDetect)

            // QRView(
            //   key:logic. qrKey,
            //   onQRViewCreated:logic.onQRViewCreated,
            //   overlay: QrScannerOverlayShape(
            //       borderColor: AppColors.primaryColor,
            //       borderRadius: 10.h,
            //       borderLength: 30.w,
            //       borderWidth: 10.w,
            //       cutOutSize: scanArea),
            //   onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            // ),
            ),
        // UiHelper.verticalSpaceLarge,
        //
        // Ui.primaryButton(title: AppStrings.confirm,onTab: (){
        //
        //   Get.back();
        //  // logic.controller!.getCameraInfo();
        //
        // }),
      ],
    );
  }
}
