import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../global_widgets/shared/dynamic_column.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'contactus_logic.dart';

class ContactusPage extends StatelessWidget {
  final ContactusLogic logic = Get.put(ContactusLogic());

  var requiredFields = ' '
      '${AppStrings.phoneNum.tr} *\n'
      '${AppStrings.password.tr} *\n'
      ''
      '';

  final double paddingHeight = 15.0.h;

  ContactusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.contactUs),
        Expanded(child: SingleChildScrollView(
          child: GetBuilder<ContactusLogic>(builder: (logic) {
            return Column(
              children: [
                Stack(
                  children: [
                    ReactiveForm(
                      formGroup: logic.form,
                      child: Center(
                        child: DynamicColumn(
                          children: [
                            UiHelper.verticalSpace(Get.height * .05),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      logic.openCall();
                                    },
                                    child: SvgPicture.asset(AppImages.telephone,
                                        width: Get.width * .2, height: 50.h)),
                                UiHelper.horizontalSpaceMedium,
                                GestureDetector(
                                    onTap: () {
                                      logic.openEmail();
                                    },
                                    child: SvgPicture.asset(
                                        AppImages.emailContact,
                                        width: Get.width * .2,
                                        height: 50.h)),
                                UiHelper.horizontalSpaceMedium,
                                GestureDetector(
                                    onTap: () {
                                      logic.openWhatsapp();
                                    },
                                    child: SvgPicture.asset(AppImages.whatsapp,
                                        width: Get.width * .2, height: 50.h)),
                                UiHelper.horizontalSpaceMedium,
                                GestureDetector(
                                    onTap: () {
                                      logic.openFacebook();
                                    },
                                    child: SvgPicture.asset(AppImages.facebook,
                                        width: Get.width * .2, height: 50.h)),
                                UiHelper.horizontalSpaceMedium,
                                GestureDetector(
                                    onTap: () {
                                      logic.openInstagram();
                                    },
                                    child: SvgPicture.asset(AppImages.instagram,
                                        width: Get.width * .2, height: 50.h)),
                                UiHelper.horizontalSpaceMedium,
                                GestureDetector(
                                    onTap: () {
                                      logic.openTwitter();
                                    },
                                    child: SvgPicture.asset(AppImages.twitter,
                                        width: Get.width * .2, height: 50.h)),
                              ],
                            ),
                            UiHelper.verticalSpace(Get.height * .05),
                            Container(
                              // height: 80,
                              decoration: Ui.getBoxDecorationLogin(),
                              child: ReactiveTextField<String>(
                                formControlName: logic.emailKey,
                                // validationMessages: (control) => {
                                //   ValidationMessage.required:
                                //       AppStrings.email.tr +
                                //           ' ' +
                                //           AppStrings.mustNotEmpty.tr,
                                // },
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: AppStyles.primaryStyleGreen(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,

                                  labelText:
                                      AppStrings.email.tr.capitalizeFirst,
                                  labelStyle: AppStyles.subTitleStyle(),
                                  // filled: true,

                                  //  fillColor: AppColors.filedBg ,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: paddingHeight),
                                  hintText: AppStrings.phoneNum.tr,
                                  errorStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  // prefixIcon: Icon(Icons.call,
                                  //
                                  //     color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      // height: 80,
                                      decoration: Ui.getBoxDecorationLogin(),
                                      child: ReactiveTextField<String>(
                                        formControlName: logic.phoneKey,
                                        // validationMessages: (control) => {
                                        //   ValidationMessage.required:
                                        //       AppStrings.phoneNum.tr +
                                        //           ' ' +
                                        //           AppStrings.mustNotEmpty.tr,
                                        // },
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        style: AppStyles.primaryStyleGreen(),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,

                                          labelText: AppStrings.phoneNum.tr,
                                          labelStyle: AppStyles.subTitleStyle(),
                                          // filled: true,

                                          //  fillColor: AppColors.filedBg ,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12.w,
                                              vertical: paddingHeight),
                                          hintText: AppStrings.phoneNum.tr,
                                          errorStyle: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.7)),
                                          hintStyle: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.7)),
                                          // prefixIcon: Icon(Icons.call,
                                          //
                                          //     color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              // height: 80,
                              decoration: Ui.getBoxDecorationLogin(),
                              child: ReactiveTextField<String>(
                                formControlName: logic.commentKey,
                                // validationMessages: (control) => {
                                //   ValidationMessage.required:
                                //       AppStrings.comment.tr +
                                //           ' ' +
                                //           AppStrings.mustNotEmpty.tr,
                                // },
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                style: AppStyles.primaryStyleGreen(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,

                                  labelText:
                                      AppStrings.comment.tr.capitalizeFirst,
                                  labelStyle: AppStyles.subTitleStyle(),
                                  // filled: true,

                                  //  fillColor: AppColors.filedBg ,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: paddingHeight),
                                  hintText: AppStrings.phoneNum.tr,
                                  errorStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.7)),
                                  // prefixIcon: Icon(Icons.call,
                                  //
                                  //     color: Colors.white),
                                ),
                              ),
                            ),
                            Ui.primaryButton(
                                title: AppStrings.send,
                                onTab: () {
                                  logic.send();
                                }),
                            SizedBox(height: 50.h),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(),
                    if (logic.busy)
                      Positioned.fill(
                          // top: Get.height*.1,

                          //   right: Get.width*.5,
                          child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [DifferentDialog.loadingDialog()],
                        ),
                      ))
                  ],
                ),
              ],
            );
          }),
        ))
      ],
    ));
  }
}
