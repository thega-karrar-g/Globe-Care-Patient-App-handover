import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/form_widgets/reactive_text_form.dart';
import '../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../data/api/api_keys.dart';
import '../../../auth/auth_controller.dart';

class AddMemberForm extends StatelessWidget {
  AddMemberForm({Key? key}) : super(key: key);

  static TextEditingController textEditingController = TextEditingController();
  String idNumberKey = 'ssn';
  String ageKey = 'age';
  String passwordKey = 'password';
  String confirmPasswordKey = 'confirm_password';
  String nameKey = 'name';
  String mobileKey = 'mobile';
  String genderKey = 'gender';
  String dobKey = 'dob';

  final double paddingHeight = 15.h;




  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (logic) {
      return SingleChildScrollView(
        child: ReactiveForm(

          formGroup: logic.addMemberForm,
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Ui.titleGreenUnderLine(
                        AppStrings.newMember.tr.capitalize!,
                        fontSize: 28),
                    UiHelper.horizontalSpace(Get.width * .3)
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
                          length: 10),
                      UiHelper.verticalSpaceMedium,
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
                    title: AppStrings.save,
                    marginH: 0,
                    onTab: () {

                      logic.addMember();
                    }),

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
