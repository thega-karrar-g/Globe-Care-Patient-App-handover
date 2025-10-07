import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/form_widgets/reactive_text_form.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../routes/app_route_names.dart';
import '../edit_profile_logic.dart';

class EditProfileForm extends StatelessWidget {
  EditProfileForm({
    Key? key,
  }) : super(key: key);
  final controller = Get.put(EditProfileLogic());

  final String fullNameKey = 'name';
  final String emailKey = 'email';
  final String ssnKey = 'ssn';

  final double paddingHeight = 25.0;
  final labelStyle = TextStyle(
      color: AppColors.black54, fontWeight: FontWeight.bold, fontSize: 13);
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
    borderSide: BorderSide(color: AppColors.registerFiled),
  );

  FormGroup buildForm() => fb.group(<String, Object>{
        fullNameKey: FormControl<String>(
          value: controller.currentUser!.name,
          validators: [
            Validators.required,
          ],
        ),

        emailKey: FormControl<String>(
          value: controller.currentUser!.email,
          validators: [
            Validators.required,
          ],
        ),

        ssnKey: FormControl<String>(
          value: controller.currentUser!.ssn,
          validators: [Validators.required, Validators.number()],
        ),
        // 'dob': FormControl<DateTime>(),
      });

  final TextStyle style =
      (TextStyle(color: AppColors.white));

  @override
  Widget build(BuildContext context) {
//controller.resultLocation=controller.currentUser!.location;
    return GetBuilder<EditProfileLogic>(builder: (logic) {
      var duration = Duration(milliseconds: 200);

      return ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            children: [
              ReactiveTextForm.reactiveTextFieldProfile(
                  formControlName: fullNameKey,
                  validationMessage: '',
                  lable: AppStrings.fullName.tr,
                  lableStyle: labelStyle,
                  outlineInputBorder: outlineInputBorder),
              ReactiveTextForm.reactiveTextFieldProfile(
                  formControlName: emailKey,
                  validationMessage: 'The  Email must not be empty',
                  lable: AppStrings.email.tr,
                  iconData: Icons.email,
                  lableStyle: labelStyle,
                  outlineInputBorder: outlineInputBorder),
              ReactiveTextForm.reactiveTextFieldProfile(
                  formControlName: ssnKey,
                  validationMessage: 'The  SSN must not be empty',
                  lable: AppStrings.idNo.tr,
                  iconData: Icons.email,
                  lableStyle: labelStyle,
                  outlineInputBorder: outlineInputBorder,
                  isNumber: true),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              Row(
                                children: [
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Text(
                                        AppStrings.dob.tr,
                                        style: AppStyles.subTitleStyle(),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              //  Spacer(),
                            ],
                          )),
                      UiHelper.horizontalSpaceMedium,
                      Expanded(
                        flex: 11,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  SizedBox(
                                    height: 180.h,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.w),
                                          child: DatePickerWidget(
                                            looping: false,
                                            // default is not looping
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime.now(),
//              initialDate: DateTime.now(),// DateTime(1994),
                                            dateFormat:
                                                // "MM-dd(E)",
                                                "dd/MMMM/yyyy",
                                            //     locale: DatePicker.localeFromString('he'),
                                            onChange: (DateTime newDate, _) {
                                              logic.updateDateTime(newDate);

                                              // setState(() {
                                              //   _selectedDate = newDate;
                                              // });
                                            },
                                            pickerTheme: DateTimePickerTheme(
                                              itemTextStyle:
                                                  AppStyles.primaryStyle(
                                                      fontSize: 16),
                                              dividerColor:
                                                  AppColors.subTitleColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.h),
                                          topRight: Radius.circular(10.h))),
                                  backgroundColor: AppColors.white,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 5.h),
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat('yyyy-M-d').format(logic.dob!),
                                      style: AppStyles.primaryStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 2.h,
                              width: Get.width,
                              //margin: EdgeInsets.symmetric(horizontal: 20),
                              color: AppColors.primaryColorGreen,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Ui.titleGreenUnderLine(AppStrings.gender),
                    ],
                  ),
                  Row(
                    children: [
                      genderButton(
                          title: AppStrings.male,
                          selected: logic.gender == 0,
                          onTab: () {
                            logic.updateGender(0);
                          }),
                      UiHelper.horizontalSpaceMedium,
                      genderButton(
                          title: AppStrings.female,
                          selected: logic.gender == 1,
                          onTab: () {
                            logic.updateGender(1);
                          }),
                      UiHelper.horizontalSpaceMassive,
                      Icon(
                        FontAwesomeIcons.male,
                        size: 23.w,
                        color: logic.gender == 0
                            ? AppColors.primaryColor
                            : AppColors.subTitleColor,
                      ),
                      Icon(
                        FontAwesomeIcons.female,
                        size: 23.w,
                        color: logic.gender == 1
                            ? AppColors.primaryColor
                            : AppColors.subTitleColor,
                      ),
                    ],
                  )
                ],
              ),
              Ui.primaryButton(
                  title: AppStrings.save,
                  marginH: 0,
                  onTab: () async {
                    Map<String, dynamic> formData = {
                      'sex': logic.gender == 0 ? 'Male' : 'Female',
                      'dob': DateFormat('yyyy-MM-dd').format(logic.dob!)
                    };
                    formData.addAll(form.value);
                     await logic.updateProfile(formData);
                  }),
            ],
          );
        },
      );
    });
  }

  editItem(
      {String title = '',
      IconData iconData = Icons.call,
      String to = AppRouteNames.editPassword}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(to);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.registerFiled),
        child: Row(
          children: [
            Icon(
              iconData,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              title.tr,
              style:(TextStyle(color: AppColors.primaryColor)),
            )),
            Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor, shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: AppColors.registerFiled,
                )),
          ],
        ),
      ),
    );
  }

  genderButton({String title = '', bool selected = false, Function? onTab}) {
    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryColor
                : AppColors.primaryColorOpacity,
            borderRadius: BorderRadius.circular(10.w)),
        child: Text(
          title.tr,
          style: selected
              ? AppStyles.whiteStyle(bold: true, size: 15)
              : AppStyles.primaryStyle(fontSize: 15, opacity: .8),
        ),
      ),
    );
  }
}
