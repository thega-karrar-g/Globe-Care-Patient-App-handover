import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../global_widgets/form_widgets/reactive_text_form.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import '../../../data/api/api_keys.dart';
import '../auth_controller.dart';

class ReactiveLoginForm extends StatelessWidget {
  ReactiveLoginForm({Key? key, required this.title}) : super(key: key);

  final String title;




  @override
  Widget build(BuildContext context) {
    var questionMark = Get.locale.toString() == 'ar' ? ' ؟ ' : ' ? ';

    return GetBuilder<AuthController>(builder: (logic) {
      return ReactiveForm(
        formGroup: logic.loginForm,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (BookingConstants.fromPatientData != true)
                UiHelper.verticalSpace(Get.height * .05),

              Row(
                children: [
                  Ui.titleGreenUnderLine(title, fontSize: 33, fontHeight: 1.5)
                ],
              ),

              Row(
                children: [
                  Text(
                    AppStrings.loginMsg.tr,
                    style: AppStyles.subTitleStyle(),
                  ),
                ],
              ),
              //   UiHelper.verticalSpace(Get.height*.05),

              UiHelper.verticalSpaceMedium,
              ReactiveTextForm.reactiveRegisterTextField(
                  formControlName: ApiKeys.smsUserName.toLowerCase(),
                  label: AppStrings.idNo,
                  isSSN: true,
                  length: 10,
                  onTab: () {
                    var remember = logic.rememberBox.read(ApiKeys.remember);
                    if (remember == true) {
                    logic.  loginForm.control(ApiKeys.smsUserName.toLowerCase()).value =
                          logic.rememberBox
                              .read(ApiKeys.smsUserName.toLowerCase())
                              .toString();
                    logic.loginForm  .control(ApiKeys.formPassword.toLowerCase()).value =
                          logic.rememberBox
                              .read(ApiKeys.formPassword.toLowerCase())
                              .toString();

                      logic.loginForm.markAsTouched();
                    }
                  },

                  validationMessage: AppStrings.numberLengthHint.trParams(
                      {
                        'length': '10',
                      }  )

              ),

              SizedBox(height: 15.h),
              ReactiveTextForm.reactiveRegisterPasswordTextField(
                formControlName: ApiKeys.formPassword,
                logic: logic,
                label: AppStrings.password,

                  validationMessage: AppStrings.numberLengthHint.trParams(
                      {
                        'length': '4',
                      }  )
              ),
              UiHelper.verticalSpaceMedium,
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRouteNames.forgetPassword);
                },
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      AppStrings.forgetPassword.tr + questionMark,
                      style: AppStyles.primaryStyle(bold: true),
                    ),
                    UiHelper.horizontalSpaceSmall,
                  ],
                ),
              ),

              Ui.primaryButton(
                  title: AppStrings.logIn.tr.capitalizeFirst.toString(),
                  onTab: () {

                    logic.loginPatient();

                  }),

              SizedBox(
                height: 10.h,
              ),

              //   SizedBox(height: 60),
            ],
          ),
        )
      );
    });
  }
}
