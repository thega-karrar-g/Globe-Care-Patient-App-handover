import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class UiHelper {
  UiHelper._();

  static final safeAreaPadding =
      EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w);
  static final safeAreaFloatingActionPadding =
      EdgeInsets.only(left: 30.w, right: 50.w);
  static final safeAreaPaddingHome =
      EdgeInsets.only(top: 30.h, left: 30.w, right: 30.w);
  static final gridViewPadding = EdgeInsets.only(top: 30.h, bottom: 50.h);
  static final doctorGridViewPadding = EdgeInsets.only(top: 0, bottom: 0);

  static final SizedBox horizontalSpaceTiny = SizedBox(width: 4.0.w);
  static final SizedBox horizontalSpaceSmall = SizedBox(width: 8.0.w);
  static final SizedBox horizontalSpaceMedium = SizedBox(width: 16.0.w);
  static final SizedBox horizontalSpaceLarge = SizedBox(width: 24.0.w);
  static final SizedBox horizontalSpaceMassive = SizedBox(width: 32.0.w);

  static final SizedBox verticalSpaceTiny = SizedBox(height: 4.0.h);
  static final SizedBox verticalSpaceSmall = SizedBox(height: 8.0.h);
  static final SizedBox verticalSpaceMedium = SizedBox(height: 16.0.h);
  static final SizedBox verticalSpaceLarge = SizedBox(height: 24.0.h);
  static final SizedBox verticalSpaceMassive = SizedBox(height: 32.0.h);

  static SizedBox verticalSpace(double height) => SizedBox(height: height.h);

  static SizedBox horizontalSpace(double width) => SizedBox(width: width.w);

  static bool get isArabic => Get.locale!.languageCode.contains("ar");

  static Divider columnDivider(
      {Color? color, double? height, double? indent, double? endIndent}) {
    return Divider(
      color: color ?? Get.theme.dividerColor,
      height: height,
      indent: indent,
      endIndent: endIndent,
    );
  }

  static const VerticalDivider rowDivider = VerticalDivider();
  static const SizedBox shrinkSizedBox = SizedBox.shrink();

  static Widget spinKitProgressIndicator({double size = 50.0, Color? color}) {
    return SpinKitSpinningLines(
      color: color ?? Get.theme.primaryColor,
      size: size,
      // lineWidth: 4.5,
    );
  }

  // Widget spacedDivider = Column(
  //   children: const <Widget>[
  //     verticalSpaceMedium,
  //     const Divider(color: Colors.blueGrey, height: 5.0),
  //     verticalSpaceMedium,
  //   ],
  // );

  static LinearProgressIndicator linearProgressIndicator =
      LinearProgressIndicator(
    backgroundColor: Colors.grey[300],
    valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
  );

// double screenHeightFraction(BuildContext context,
//         {int dividedBy = 1, double offsetBy = 0}) =>
//     (SizeConfig.screenHeight - offsetBy) / dividedBy;
//
// double screenWidthFraction(BuildContext context,
//         {int dividedBy = 1, double offsetBy = 0}) =>
//     (SizeConfig.screenWidth - offsetBy) / dividedBy;
}
