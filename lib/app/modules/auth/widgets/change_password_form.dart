import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/form_widgets/reactive_text_form.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../data/api/api_keys.dart';
import '../auth_controller.dart';

class ChangePasswordForm extends StatelessWidget {
  ChangePasswordForm({Key? key,required this.controller}) : super(key: key);
  final AuthController controller;

  final double paddingHeight = 25.0.h;
  final labelStyle = TextStyle(
      color: AppColors.subTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 13.sp);
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.h)),
    borderSide: BorderSide(color: AppColors.subTitleColor),
  );


  final TextStyle style =
  (TextStyle(color: AppColors.white));

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: controller.changePasswordForm,
      child: Column(
        children: [
          ReactiveTextForm.reactiveTextFieldAuth(
              formControlName: ApiKeys.formPassword,
              preventSpace: true,
              validationMessage: AppStrings.passwordHint.tr,
              isPassword: true,
              lable: AppStrings.currentPassword.tr,
              iconData: Icons.lock,
              lableStyle: labelStyle,
              fillColor: AppColors.white,
              outlineInputBorder: outlineInputBorder),
          UiHelper.verticalSpaceMedium,
          ReactiveTextForm.reactiveTextFieldAuth(
              formControlName: ApiKeys.formNewPassword,
              preventSpace: true,
              validationMessage: AppStrings.passwordHint.tr,
              isPassword: true,
              fillColor: AppColors.white,
              lable: AppStrings.newPassword.tr,
              iconData: Icons.lock,
              lableStyle: labelStyle,
              outlineInputBorder: outlineInputBorder),
          UiHelper.verticalSpaceLarge,
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    AppStrings.cancel.tr,
                    style: AppStyles.subTitleStyle(bold: true, size: 20),
                  ),
                ),
              ),
              Expanded(
                child: Ui.primaryButton(
                    title: AppStrings.save,
                    radius: 10,
                    paddingV: 10,
                    marginH: 0,
                    hasIcon: false,
                    onTab: () {

                      controller.changePassword();

                    }),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
