import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:intl/intl.dart' as intl;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:path/path.dart' ;
import 'package:toastification/toastification.dart';

import '../core/language_and_localization/app_strings.dart';
import '../data/eunums/enums.dart';
import '../global_widgets/shared/different_dialogs.dart';
import 'connectivity_controller.dart';

mixin HelpersMethod {
  bool noInternetConnection() {
    Get.find<ConnectivityController>().checkWhenStreamIsNull();

    return Get.find<ConnectivityController>().currentConnectivityStatus ==
        ConnectivityStatus.offline;
  }

  hideSoftKeyBoard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    // FocusScope.of(Get.context).unfocus();
  }

  // launchUrlLink(String link) async {
  //   String url = link;
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  onTimeOut() {
    DifferentDialog.hideProgressDialog();
    hideSoftKeyBoard();
    buildFailedSnackBar(
      msg: 'time out connection',
    );
  }

  soonMessage() {
    buildSuccessSnackBar(msg: AppStrings.soon.tr);
  }

  void toastMessage(String message,
      {Color? backgroundColor, Color? textColor}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor ?? Colors.black,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }

  static void getToastMessage(
      {required String message, Color? backgroundColor, Color? textColor}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor ?? Colors.black,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }

  buildSuccessSnackBar({String msg='',String title=AppStrings.successfully,bool centered=false}) {
    hideSoftKeyBoard();

    toastification.show(
      // context: Get.context, // optional if you use ToastificationWrapper,

      title: Text(title.tr,style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),
      description: Padding(
        padding:  EdgeInsets.symmetric(vertical: 5.h),
        child: Text(msg.tr,style: AppStyles.primaryStyle(color: AppColors.white,fontSize: 20,height: 1.5),),
      ),
      autoCloseDuration: const Duration(seconds: 5),
      alignment:centered ? Alignment.center :Alignment.topRight,
      backgroundColor: AppColors.primaryColor,
      showIcon: true,
      type: ToastificationType.success,
      icon: Icon(Icons.check_circle_outline,color: AppColors.white,),
      showProgressBar: false,
      // padding: EdgeInsets.symmetric(v)
    );
    // MotionToast.success(
    //   title:  Text(AppStrings.successfully.tr,style: AppStyles.primaryStyle(color: AppColors.white),),
    //   description:  Text("$msg",style: AppStyles.primaryStyle(color: AppColors.white),),
    //
    // ).show(Get.context!);
    // DifferentDialog.showSnackBar(
    //   message: '$msg',
    //   showIcon: true,
    //   success: true,
    // );
  }

  showYouMayHaveBadInternetConnection() {
    DifferentDialog.hideProgressDialog();
    buildFailedSnackBar(msg: AppStrings.checkInternet.tr.capitalizeFirst!);
  }

  buildFailedSnackBar({String msg = '', int duration = 5,String title='',bool centered=false}) {
    hideSoftKeyBoard();


    // toastification.show(
    //   // context: Get.context, // optional if you use ToastificationWrapper,
    //
    //   title: Text(title.tr,style: AppStyles.primaryStyle(color: AppColors.white,bold: true),),
    //   description: Padding(
    //     padding:  EdgeInsets.symmetric(vertical: 5.h),
    //     child: Text(msg.tr,style: AppStyles.primaryStyle(color: AppColors.white,fontSize: 14,height: 1.5),),
    //   ),
    //   // style: ToastificationStyle.flat,
    //   autoCloseDuration: const Duration(seconds: 5),
    //   alignment:centered ? Alignment.center :Alignment.topRight,
    //
    //   backgroundColor: AppColors.red,
    //   showIcon: true,
    //   type: ToastificationType.warning,
    //   icon: Icon(Icons.clear,color: AppColors.white,),
    //   showProgressBar: false,
    //   // padding: EdgeInsets.symmetric(v)
    // );
    // MotionToast.error(
    //     title:  Text(AppStrings.oops.tr),
    //     position: MotionToastPosition.top,
    //     description:  Text("$msg"
    //         "")
    // ).show(Get.context!);


    DifferentDialog.showSnackBar(
        message: msg ,
        showIcon: true,
        success: false,
        duration: duration);
  }

  static bool isDirectionRTL() {
    return intl.Bidi.isRtlLanguage(
        Localizations.localeOf(Get.context!).languageCode);
  }

  static TextDirection getTextDirection() {
    bool isRtl = intl.Bidi.isRtlLanguage(
        Localizations.localeOf(Get.context!).languageCode);

    return isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  static String formattedDate(DateTime createAt,
      {bool withTime = false, bool showOnlyTime = false}) {
    if (withTime) {
      return intl.DateFormat('dd MMM yyyy hh:mm a').format(createAt);
    }
    if (showOnlyTime) {
      return intl.DateFormat('hh:mm a').format(createAt);
    }
    return intl.DateFormat('dd MMM yyyy').format(createAt);
  }

  // static String parseHtmlString(String htmlString) {
  //   final document = parse(htmlString);
  //   final String parsedString = parse(document.body.text).documentElement.text;
  //
  //   return parsedString;
  // }

  static String getPathExtension(String cloudStoragePth, String filePath) {
    return '$cloudStoragePth${extension(filePath)}';
  }

  static Color getColorBasedOnItsBackgroundColor(Color backgroundColor) {
    if (ThemeData.estimateBrightnessForColor(backgroundColor) ==
        Brightness.dark) {
      return Colors.white;
    }
    return Colors.black;
  }

  ///...

  convertColorToHexDecimal(Color color) {
    return "#${color.value.toRadixString(16).toUpperCase()}";
  }

  static Color getColorFromHex(String hex) {
    if (hex.contains('#')) {
      return Color(int.parse(hex.replaceAll("#", "0xFF")));
    } else {
      return Color(int.parse("0xFF$hex"));
    }
  }

  static BoxFit getBoxFit(String? boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static String? getDiscountPercentage(
      dynamic offerPrice, dynamic originalPrice, BuildContext context) {
    return "${((offerPrice.toDouble() / originalPrice.toDouble()) * 100).toStringAsFixed(0)} % OFF";
  }

  static AlignmentDirectional getAlignmentDirectional(
      String? alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  ///...
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  // DateTime? currentBackPressTime;
  //
  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     Fluttertoast.showToast(
  //         msg: AppStrings.doubleClickToExitApp.tr.capitalizeFirst!);
  //     return Future.value(false);
  //   }
  //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  //   return Future.value(true);
  // }

  ///...

  static int getDifferenceBetweenDates(DateTime dateTime) {
    final currentDay = DateTime.now();

    final date2 = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    int result = date2.difference(currentDay).inDays + 1;

    if (result < 0) {
      return -1;
    } else {
      return result;
    }
  }
}
