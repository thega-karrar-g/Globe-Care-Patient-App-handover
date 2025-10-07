import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../global_widgets/form_widgets/reactive_text_form.dart';
import '../../../global_widgets/shared/dynamic_column.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import '../../../data/api/api_keys.dart';
import '../auth_controller.dart';

class ReactiveRegisterForm extends StatelessWidget {
  ReactiveRegisterForm({Key? key}) : super(key: key);

  static TextEditingController textEditingController = TextEditingController();

  final double paddingHeight = 15.0.h;


  @override
  Widget build(BuildContext context) {
    var hint = Get.locale.toString() == 'ar' ? ' ********5 ' : '  5********  ';

    return GetBuilder<AuthController>(builder: (logic) {
      // var yes=logic.nationality.answer !=null&&logic.nationality.answer==true;
      // var noChecked=logic.nationality.answer !=null&&logic.nationality.answer==false;

      return SingleChildScrollView(
        child: ReactiveForm(
          formGroup:logic. registerForm,

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Ui.titleGreenUnderLine(
                        AppStrings.createAccount.tr.capitalize!,
                        fontSize: 28),
                    UiHelper.horizontalSpace(Get.width * .3)
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                        child: Text(
                          AppStrings.fillRequiredInformation.tr,
                          style: AppStyles.subTitleStyle(),
                        )),
                    UiHelper.horizontalSpace(120),
                  ],
                ),

                UiHelper.verticalSpaceMedium,
                Visibility(
                  visible: true,
                  child: DynamicColumn(
                    children: [
                      ReactiveTextForm.reactiveRegisterTextField(
                          formControlName: ApiKeys.nameKey,
                          label: AppStrings.fullName,
                          length: 30,
                          isName: true),
                      SizedBox(height: 15.h),
                      ReactiveTextForm.reactiveRegisterTextField(
                          formControlName: ApiKeys.idNumberKey,
                          label: AppStrings.idNo,
                          isSSN: true,
                          length: 10,
                      validationMessage: AppStrings.numberLengthHint.trParams(
                          {
                            'length': '10',
                          }  )
                      ),
                      UiHelper.verticalSpaceMedium,
                      ReactiveTextForm.reactiveRegisterTextField(
                          formControlName: ApiKeys.formMobile,
                          label: AppStrings.phoneNum,
                          isPhone: true,
                          hint: hint,
                          length: 9,

                      validationMessage: AppStrings.numberLengthHint.trParams(
                          {
                            'length': '9',
                          }  )
                      ),
                      UiHelper.verticalSpaceMedium,
                      ReactiveTextForm.reactiveRegisterPasswordTextField(
                          formControlName: ApiKeys.formPassword,
                          label: AppStrings.password.tr,
                          length: 30,
                        logic: logic,

                          validationMessage: AppStrings.numberLengthHint.trParams(
                              {
                                'length': '8',
                              }  )
                      ),
                      UiHelper.verticalSpaceMedium,
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ReactiveTextForm.reactiveRegisterTextField(
                                formControlName: ApiKeys.ageKey,
                                label: AppStrings.age,
                                isNumber: true,
                                length: 3,
                                noStartZero: true),
                          ),
                          UiHelper.horizontalSpaceMedium,
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: Ui.getBoxDecorationLogin(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 12.h),
                              child: Row(
                                children: [
                                  UiHelper.horizontalSpace(10),
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.gender.tr.capitalizeFirst!,
                                        style: AppStyles.primaryStyle(
                                            bold: true, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  UiHelper.horizontalSpace(10),
                                  Row(
                                    children: [
                                      Ui.genderButton(
                                          title: AppStrings.male,
                                          selected: logic.gender == 0,
                                          onTab: () {
                                            logic.updateGender(0);
                                          }),
                                      UiHelper.horizontalSpaceSmall,
                                      Ui.genderButton(
                                          title: AppStrings.female,
                                          selected: logic.gender == 1,
                                          onTab: () {
                                            logic.updateGender(1);
                                          }),
                                      // UiHelper.horizontalSpaceLarge,
                                      // Icon(
                                      //   FontAwesomeIcons.male,
                                      //   color: logic.gender == 0
                                      //       ? AppColors.primaryColor
                                      //       : AppColors.subTitleColor,
                                      // ),
                                      // Icon(
                                      //   FontAwesomeIcons.female,
                                      //   color: logic.gender == 1
                                      //       ? AppColors.primaryColor
                                      //       : AppColors.subTitleColor,
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Ui.primaryButton(
                    title: AppStrings.signUp,
                    marginH: 0,
                    onTab: () {

                      logic.register();

                    }),

                if (BookingConstants.fromPatientData != true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                        },
                        child: Text(
                          AppStrings.haveAccount.tr,
                          style:
                          AppStyles.subTitleStyle(bold: true, size: 15),
                        ),
                      ),
                      UiHelper.horizontalSpace(5),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          // Get.offAllNamed(AppRouteNames.login);

                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                        },
                        child: Text(
                          AppStrings.logIn.tr,
                          style: AppStyles.primaryStyle(bold: true, fontSize: 15),
                        ),
                      ),
                    ],
                  ),

                SizedBox(
                  height: 32,
                ),

                //  SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );
    });
  }
}
