import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../data/models/patient.dart';
import '../../../../../global_widgets/form_widgets/reactive_text_form.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../../global_widgets/ui.dart';
import '../fill_data_logic.dart';

class FormItem extends StatelessWidget {
  FormItem({Key? key, required this.patient, required this.logic})
      : super(key: key);
  final Patient patient;

  final FillDataLogic logic;

  final nameKey = 'name';
  final passportKey = 'passport';
  final ssnKey = 'ssn';
  final double paddingHeight = 25.0.h;
  final labelStyle = TextStyle(
      color: AppColors.subTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 13.sp);
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.h)),
    borderSide: BorderSide(color: AppColors.subTitleColor),
  );

  final TextStyle style =
      (TextStyle(color: AppColors.white));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiHelper.verticalSpaceMedium,
        Row(
          children: [
            Ui.greenLine(),
            UiHelper.horizontalSpaceSmall,
            Container(
              width: 25.w,
              height: 25.h,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                patient.id.toString(),
                style: AppStyles.whiteStyle(),
              ),
            )
          ],
        ),
        UiHelper.verticalSpaceMedium,
        Row(
          children: [
            GestureDetector(
              onTap: () {
                logic.updatePatient(patient);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.h),
                    border: Border.all(
                        color: patient.hasCertificate
                            ? AppColors.primaryColor
                            : AppColors.subTitleColor),
                    color: patient.hasCertificate
                        ? AppColors.primaryColor
                        : AppColors.white),
                child: Icon(
                  Icons.check,
                  size: 20.w,
                  color: patient.hasCertificate
                      ? AppColors.white
                      : AppColors.white,
                ),
              ),
            ),
            UiHelper.horizontalSpaceMedium,
            Text(
              AppStrings.withCertificate.tr,
              style: patient.hasCertificate
                  ? AppStyles.primaryStyle(bold: true)
                  : AppStyles.subTitleStyle(),
            )
          ],
        ),
        UiHelper.verticalSpaceMedium,
        ReactiveForm(
          formGroup: patient.form,
          child: Column(
            children: [
              ReactiveTextForm.reactiveTextField(
                  formControlName: nameKey,
                  validationMessage: AppStrings.fillRequiredInformation.tr,
                  isName: true,
                  lable: AppStrings.fullName.tr,
                  iconData: Icons.lock,
                  lableStyle: labelStyle,
                  fillColor: AppColors.white,
                  outlineInputBorder: outlineInputBorder),
              ReactiveTextForm.reactiveTextField(
                  formControlName: ssnKey,
                  validationMessage: AppStrings.fillRequiredInformation.tr,
                  fillColor: AppColors.white,
                  isSSN: true,
                  isNumber: true,
                  isPhone: true,
                  lable: AppStrings.idNo.tr,
                  iconData: Icons.lock,
                  lableStyle: labelStyle,
                  outlineInputBorder: outlineInputBorder),
              if (patient.hasCertificate)
                ReactiveTextForm.reactiveTextField(
                  formControlName: passportKey,
                  validationMessage: AppStrings.passwordHint.tr,
                  fillColor: AppColors.white,
                  length: 15,
                  lable: AppStrings.passport.tr,
                  iconData: Icons.lock,
                  lableStyle: labelStyle,
                  isAlphanumeric: true,
                  outlineInputBorder: outlineInputBorder,
                ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ],
    );
  }
}
