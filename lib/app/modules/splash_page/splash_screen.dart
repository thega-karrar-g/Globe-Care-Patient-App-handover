import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/assets_helper/app_images.dart';
import 'spalsh_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (model) => Scaffold(
          body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.splashVideo,
                height: Get.height,
                fit: BoxFit.fitHeight,
              ),

              //     Container(
              //     margin: EdgeInsets.only(top: Get.height*.13),
              //  // height: 100,
              //  // width: 100,
              //   child: model. show?  Stack(
              //     children: [
              //       Positioned.fill(child:
              //       Align(
              //           alignment: Alignment.center,
              //           child:
              //           FadeIn(
              //
              //               duration: Duration(milliseconds: 0),
              //               curve: Curves.elasticOut,
              //
              //               child:
              //               Image.asset(AppImages.logoOnly,)
              //           )
              //       )
              //       ),
              //
              //       SfRadialGauge(
              //         //   backgroundColor: AppColors.white.withOpacity(1),
              //         animationDuration: 1000,
              //
              //         enableLoadingAnimation: true,
              //
              //         axes:<RadialAxis>[RadialAxis(
              //
              //           useRangeColorForAxis: true,
              //
              //           pointers: <GaugePointer>[
              //
              //
              //             RangePointer(
              //               value: 100,
              //               animationDuration: 1000,
              //               cornerStyle: CornerStyle.bothFlat,
              //               width: 1,
              //               // color: AppColors.white.withOpacity(0),
              //               color: AppColors.white.withOpacity(1),
              //
              //               sizeUnit: GaugeSizeUnit.factor,
              //               enableAnimation: true,
              //               animationType: AnimationType.linear,
              //               onValueChanging: (v){
              //
              //                 print(v.value);
              //               },
              //               onValueChanged: (d){
              //
              //               },
              //
              //               onValueChangeStart: (d){
              //
              //
              //               },
              //               onValueChangeEnd: (d){
              //
              //               },
              //             )
              //             ,
              //             // MarkerPointer(
              //             //   value: 65,
              //             //   markerWidth: 18,
              //             //   markerHeight: 18,
              //             //   markerType: MarkerType.circle,
              //             //
              //             // ),
              //           ],
              //
              //
              //           radiusFactor: .6,
              //           startAngle: 350,
              //           endAngle: 350,
              //           isInversed: true,
              //           showLabels: false,
              //           showTicks: false,
              //           axisLineStyle: AxisLineStyle(
              //             thickness: 0,
              //             color: AppColors.white.withOpacity(0.7),
              //
              //             // color: AppColors.primaryColorGreenOld,
              //             thicknessUnit: GaugeSizeUnit.factor,
              //           ),
              //         )],
              //
              //       ),
              //
              //     ],
              //   )
              //       : Center(
              //       child: Row(
              //         children: [
              //           Spacer(),
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               FadeIn(
              //
              //                   duration: Duration(milliseconds: 500),
              //                   curve: Curves.elasticOut,
              //
              //                   child:
              //                   Image.asset(AppImages.logoOnly,)
              //               )
              //
              //             ],
              //           ),
              //
              //           Spacer()
              //         ],
              //       )
              //   ),
              // ),
              //    SizedBox(height: 20),

//         Text(AppStrings.appTitle.tr,style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,height: 1,color: AppColors.filedBg))
// ,

              // Container(height: Get.height*.2,),

              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width / 3),
              //   child: Image.asset(
              //     AppImages.logoPng,
              //     fit: BoxFit.cover,
              //     alignment: Alignment.center,
              //     // height: MediaQuery.of(context).size.height / 4,
              //     // width: MediaQuery.of(context).size.width / 3,
              //   ),
              // ),
              // // SvgPicture.asset(
              // //   AppImages.logoSvg,
              // //   fit: BoxFit.cover,
              // //   alignment: Alignment.center,
              // //   height: MediaQuery.of(context).size.height / 4,
              // //   width: MediaQuery.of(context).size.width / 3,
              // // ),
              // UiHelper.verticalSpaceLarge,
              // Text(
              //   AppStrings.appTitle.tr.capitalizeFirst!,
              //   style: Get.textTheme.headline6!
              //       .copyWith(color: Get.textTheme.subtitle1!.color),
              // ),
              // UiHelper.verticalSpaceLarge,
              // Text(
              //   'Powered By Smart Mind Sys',
              //   style: Get.textTheme.subtitle1,
              // ),
              // UiHelper.verticalSpaceLarge,
              //
              // UiHelper.spinKitProgressIndicator(
              //   size: 50,
              //   color: Theme.of(context).cardColor,
              // )
            ]),
      )),
    );
  }
}
