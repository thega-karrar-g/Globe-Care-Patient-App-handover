import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'verify_code_logic.dart';

class VerifyCodePage extends StatelessWidget {
  VerifyCodePage({Key? key}) : super(key: key);

  final VerifyCodeLogic logic = Get.put(VerifyCodeLogic());

  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  snackBar(String? message) {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  var phoneNum = '770366480';

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: SingleChildScrollView(
      child: Column(
        children: [
          UiHelper.verticalSpace(30),
          Row(
            children: [
              Ui.titleGreenUnderLine(AppStrings.verifyCode.tr.capitalize!,
                  fontSize: 28),
              UiHelper.horizontalSpace(Get.width * .3)
            ],
          ),
          Lottie.asset(AppAnim.waitVerifyCode,
              width: Get.width * .3, height: Get.height * .15),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
            child: RichText(
              text: TextSpan(
                  text: AppStrings.verifyCodeMsg.tr,
                  style: AppStyles.subTitleStyle(size: 18)),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
            child: Text(
              logic.formatter.apply(logic.phoneNum),
              style: AppStyles.primaryStyle(bold: false, fontSize: 23),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Form(
            key: formKey,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: Get.width * .1,
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: AppStyles.whiteStyle(),
                    textStyle: AppStyles.primaryStyle(bold: true, fontSize: 20),

                    length: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    // obscureText: true,
                    //obscuringCharacter: '*',
                    // obscuringWidget: const FlutterLogo(
                    //   size: 24,
                    // ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.slide,
                    validator: (v) {
                      if (v!.length < 3) {
                        return AppStrings.verifyCodeErrorMsg.tr;
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10.h),
                        fieldHeight: Get.width * .12,
                        fieldWidth: Get.width * .12,
                        activeFillColor: Colors.white,
                        inactiveColor: AppColors.subTitleColor,
                        inactiveFillColor: AppColors.white,
                        selectedFillColor: AppColors.primaryColorOpacity,
                        activeColor: AppColors.primaryColor,
                        selectedColor: AppColors.primaryColorGreen),
                    cursorColor: AppColors.white,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: logic.textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      debugPrint(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                )),
          ),
          if (logic.user == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Text(
                AppStrings.verifyCodeNoteMsg.tr,
                textAlign: TextAlign.center,
                style: AppStyles.primaryStyle(height: 1.3),
              ),
            ),
          UiHelper.verticalSpaceMedium,
          Ui.primaryButton(
              title: AppStrings.verify,
              onTab: () {
                // formKey.currentState!.validate();
                logic.verify();
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.doNotReceive.tr,
                style: AppStyles.subTitleStyle(size: 15),
              ),
              TextButton(
                onPressed: () {
                  logic.sendCode();
                },
                child: Text(
                  AppStrings.resend.tr,
                  style: AppStyles.primaryStyleGreen(bold: true, size: 15),
                ),
              )
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    ));
  }
}
