import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/theme_helper/app_colors.dart';
import '../core/theme_helper/app_styles.dart';
import '../modules/drawer_module/drawer_widget/main_drawer_widget.dart';
import '../core/assets_helper/app_images.dart';
import 'shared/ui_helpers.dart';

class Ui {
  static myScaffold({required Widget child, Widget? floatingAction}) =>
      Scaffold(
        drawer: MainDrawerWidget(),
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        drawerDragStartBehavior: DragStartBehavior.start,
        body: SafeArea(minimum: UiHelper.safeAreaPadding, child: child),
        floatingActionButton: floatingAction,
      );

  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: AppColors.primaryColorOpacity),
  );


  static  titlePrimary(String title,{double bottomPadding=15,double fontSize=14,double fontHeight=1.3,double topPadding=16}){


    return
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiHelper.verticalSpace(topPadding),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title.tr,style: AppStyles.primaryStyle(bold: true,fontSize: fontSize,height: fontHeight),),
                  ],
                ),
                UiHelper.verticalSpaceTiny,


              ],
            ),
          ),
        ],
      );


  }


  static BoxDecoration getBoxDecorationLogin(
      {Color color = Colors.white,
      double radius = 15,
      Border? border,
      Gradient? gradient}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius.h),
        border: Border.all(color: AppColors.subTitleColor, width: 1.5.w));
  }

  static BoxDecoration getBoxDecorationPrescription(
      {Color color = Colors.white,
      double radius = 10,
      Border? border,
      Gradient? gradient}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            AppColors.gradientStartPre,
            AppColors.gradientEndPre,
          ],
        ));
  }

  static BoxDecoration getBoxDecorationTextForm(
      {Color color = Colors.white,
      double radius = 10,
      Border? border,
      Gradient? gradient}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            AppColors.gradientStart,
            AppColors.gradientEnd,
          ],
        ));
  }

  static BoxDecoration getBoxDecoration(
      {Color color = Colors.white,
      double radius = 10,
      Border? border,
      Gradient? gradient}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      boxShadow: [
        BoxShadow(
          color: Get.theme.splashColor.withOpacity(0.5),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
      border:
          border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static BoxDecoration getBoxDecoration2(
      {Color? color, double? radius, Border? border, Gradient? gradient}) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
            color: Get.theme.splashColor.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 5)),
      ],
    );
  }

  static BoxDecoration getBoxDecoration4(
      {Color? color, double? radius, Border? border, Gradient? gradient}) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
            color: Get.theme.splashColor.withOpacity(0.5),
            blurRadius: 15,
            offset: Offset(0, 5)),
      ],
    );
  }

  static BoxDecoration getBoxDecoration3(
      {Color? color, double? radius, Border? border, Gradient? gradient}) {
    return BoxDecoration(
      color: Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(
            color: Get.theme.focusColor.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 5)),
      ],
    );
  }

  static svgIcon(String icon) {
    return SvgPicture.asset(
      icon,
      width: 15,
      height: 15,
      color: Get.isDarkMode ? AppColors.accentColor : Get.theme.hintColor,
    );
  }

  static circularImg(
      {@required url,
      double size = 60,
      double padding = 0,
      errorImg = AppImages.placeHolder,
      double margin = 10,
      double radius = 100,
      String cacheKey = ''}) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: AppColors.white,
            border: Border.all(
                color: AppColors.subTitleColor2.withOpacity(.3), width: 2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius.h),
          child: CachedNetworkImage(
             // key: UniqueKey(),
              height: size.h,
              width: size.w,
              fit: BoxFit.cover,
              //cacheKey:cacheKey ,
              imageUrl: url,
              placeholder: (context, url) => Image.asset(
                    AppImages.loadingSlides,
                    fit: BoxFit.cover,
                    height: size.h,
                    width: size.w,
                  ),
              errorWidget: (context, url, error) => Image.asset(
                    errorImg,
                    fit: BoxFit.cover,
                    height: size.h,
                    width: size.w,
                  )),
        ),
      ),
    );
  }

  static circularImgAsset(
      {@required url,
      double size = 60,
      errorImg = AppImages.placeHolder,
      double margin = 10,
      double radius = 100,
      String cacheKey = ''}) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          //color: AppColors.white,border: Border.all(color: AppColors.subTitleColor2.withOpacity(.3),width: 2)
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(radius.h),
            child: Image.asset(
              url,
              fit: BoxFit.cover,
              height: size.h,
              width: size.w,
            )),
      ),
    );
  }

  static circularImgRadius(
      {@required url,
      double size = 60,
      errorImg = AppImages.placeHolder,
      double margin = 10,
      double rTR = 15,
      double rTL = 15,
      double rBR = 15,
      double rBL = 15,
      double h = 100,
      double w = 100}) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(rTR),
          topLeft: Radius.circular(rTL),
          bottomRight: Radius.circular(rBR),
          bottomLeft: Radius.circular(rBL),
        ),
        child: CachedNetworkImage(
            height: size == 0 ? h : size,
            width: size == 0 ? w : size,
            fit: BoxFit.fill,
            imageUrl: url,
            placeholder: (context, url) => Image.asset(
                  AppImages.loadingSlides,
                  fit: BoxFit.cover,
                  height: size == 0 ? h : size,
                  width: size == 0 ? w : size,
                ),
            errorWidget: (context, url, error) => Image.asset(
                  errorImg,
                  fit: BoxFit.cover,
                  height: size == 0 ? h : size,
                  width: size == 0 ? w : size,
                )),
      ),
    );
  }

  static circularImgRadiusBase64(
      {String? url = '',
      double size = 60,
      errorImg = AppImages.placeHolder,
      double margin = 10,
      double rTR = 15,
      double rTL = 15,
      double rBR = 15,
      double rBL = 15,
      double h = 100,
      double w = 100}) {
    try {
      if (url!.isNotEmpty) {
// You can check if data is normal base64 - should return true

// Will returns your image as Uint8List

        var bytesImage = Base64Decoder().convert(base64.normalize(url));
//var  _bytesImage = Base64Decoder().convert(url);
//var image=base64.normalize(_bytesImage);

        return Container(
          margin: EdgeInsets.all(margin),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(rTR),
              topLeft: Radius.circular(rTL),
              bottomRight: Radius.circular(rBR),
              bottomLeft: Radius.circular(rBL),
            ),
            child: Image.memory(
              bytesImage,
              width: size == 0 ? w : size,
              height: size == 0 ? h : size,
            ),
          ),
        );
      } else {
        return circularImg(url: errorImg, margin: margin);
      }
    } catch (e) {
      return circularImg(url: errorImg, margin: margin);
    }
  }

  static Widget image(String thumbnail, {double size = 60}) {
    String placeholder =
        "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";
    if (thumbnail.isEmpty) {
      thumbnail = placeholder;
    } else {
      if (thumbnail.length % 4 > 0) {
        //  thumbnail += '=' * (4 - thumbnail .length % 4) ;// as suggested by Albert221
      }
    }
    final byteImage = Base64Decoder().convert(thumbnail);
    Widget image = Image.memory(
      byteImage,
      width: size,
      height: size,
    );
    return image;
  }

  static titleGreenUnderLine(String title,
      {double bottomPadding = 15,
      double fontSize = 14,
      double fontHeight = 1.3}) {
    return Row(
      children: [
        IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.tr,
                style: AppStyles.primaryStyle(
                    bold: true, fontSize: fontSize, height: fontHeight),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5.h),
                      height: 5.h,
                      //  width: Get.width*.3,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColorGreen,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: bottomPadding.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget primaryButton(
      {String title = '',
      VoidCallback? onTab,
      double fontSize = 18,
      double iconSize = 35,
      bool hasIcon = false,
      bool capitalize = true,
      IconData? icon,
      double marginH = 0,
      double paddingH = 20,
      double paddingV = 20,
      double marginV = 20,
      double radius = 10,

      Color color = AppColors.primaryColor}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginV, horizontal: marginH),
      child: GestureDetector(
        onTap: () => onTab!(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: paddingV.h, horizontal: paddingH.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius.h),
                    color: color),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text( capitalize? title.tr.capitalize!: title.tr,
                          textAlign: TextAlign.center,
                          style: AppStyles.primaryStyle(
                              color: AppColors.white,
                              bold: true,
                              fontSize: fontSize,
                              height: 1.5)),
                    ),
                    if (icon != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Icon(
                          icon,
                          color: AppColors.white,
                          size: iconSize.w,
                        ),
                      ),
                    if (hasIcon)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.white,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget primaryButtonOutlined({
    String title = '',
    VoidCallback? onTab,
    double fontSize = 18,
    double iconSize = 35,
    bool hasIcon = false,
    IconData? icon,
    double marginH = 0,
    double paddingH = 20,
    double paddingV = 20,
    double marginV = 20,
    double radius = 10,
    Color color = AppColors.primaryColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginV, horizontal: marginH),
      child: GestureDetector(
        onTap: () => onTab!(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: paddingV.h, horizontal: paddingH.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius.h),
                    color: color,
                    border: Border.all(color: AppColors.primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title.tr.capitalizeFirst!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize.sp),
                    ),
                    if (icon != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: Icon(
                          icon,
                          color: AppColors.white,
                          size: iconSize.w,
                        ),
                      ),
                    if (hasIcon)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.white,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget primaryButton2(
      {String title = '',
      double fontSize = 15,
      VoidCallback? onTab,
      bool icon = false,
      double marginH = 0,
      double marginV = 0,
      double radius = 10,
      Color color = AppColors.primaryColorGreen}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginV.h, horizontal: marginH.w),
      child: GestureDetector(
        onTap: () => onTab!(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius.h),
                    color: color),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon)
                      Container(
                        width: 40.w,
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          title.tr.capitalize!,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize.sp),
                        ),
                      ),
                    ),
                    if (icon)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.white,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget primaryTextButton(
      {String title = '',
      VoidCallback? onTab,
      double fontSize = 18,
      double marginH = 0,
      double paddingH = 20,
      double marginV = 20,
      Color textColor = AppColors.primaryColorGreen}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginV.h, horizontal: marginH.w),
      child: GestureDetector(
        onTap: () => onTab!(),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title.tr.capitalizeFirst!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const vSpace10 = SizedBox(
    height: 10,
  );
  static const hSpace10 = SizedBox(
    width: 10,
  );

  static final labelStyle = TextStyle(
      color: AppColors.subTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 13,
      height: 1.5);

  static expandedText(
      {String txt = '',
      TextStyle style =
          const TextStyle(color: AppColors.primaryColor, fontSize: 12)}) {
    return Row(
      children: [
        Expanded(
            child: Text(
          txt,
          style: style,
        ))
      ],
    );
  }

  static greenLine({double opacity = 1.0}) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 5,
          width: Get.width * .2,
          decoration: BoxDecoration(
              color: AppColors.primaryColorGreen.withOpacity(opacity),
              borderRadius: BorderRadius.circular(20)),
        ),
      ],
    );
  }

  static genderButton(
      {String title = '', bool selected = false, Function? onTab}) {
    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryColor
                : AppColors.primaryColor.withOpacity(.03),
            borderRadius: BorderRadius.circular(10.h)),
        child: Text(
          title.tr,
          style: selected
              ? AppStyles.whiteStyle(bold: true, size: 13)
              : AppStyles.primaryStyle(fontSize: 13, opacity: .8),
        ),
      ),
    );
  }
}
