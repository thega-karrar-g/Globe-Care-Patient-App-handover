import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/action_buttons/action_button.dart';
import 'package:globcare/app/utils/string_reverse.dart';

import '../../../../../core/assets_helper/app_images.dart';
import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../data/constants/booking_constants.dart';
import '../../../../../global_widgets/shared/different_dialogs.dart';
import '../../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../../global_widgets/shared/loading.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../../global_widgets/ui.dart';
import '../../../../../routes/app_route_names.dart';
import '../../../../qr_scanner/qr_scanner_logic.dart';
import '../instant_consultation_states_logic.dart';

class SendRequest extends StatelessWidget {
  SendRequest({Key? key}) : super(key: key);

  final FocusNode _focusNode =
      FocusNode(); //1 - declare and initialize variable

 final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.h)),
    borderSide: BorderSide(color: AppColors.registerFiled),
  );
  final double paddingHeight = 25.0.h;
  final labelStyle = TextStyle(
      color: AppColors.subTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 13.sp);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstantConsultationStatesLogic>(builder: (logic) {
      return logic.busy
          ? MyLoadingWidget()
          : DynamicColumn(
              children: [

                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.instantConsultationDescription.tr,
                        style: AppStyles.primaryStyle(fontSize: 15, height: 1.5),
                      ),
                      UiHelper.verticalSpaceMedium,
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.calendar,
                            color: AppColors.primaryColorGreen,
                            width: 20.w,
                            height: 20.h,
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Text(
                            AppStrings.instantConsultationAvailable.tr,
                            style: AppStyles.subTitleStyle(size: 13),
                          )
                        ],
                      ),
                      UiHelper.verticalSpaceSmall,
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.prescrip,
                            color: AppColors.primaryColorGreen,
                            width: 20.w,
                            height: 20.h,
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Text(
                            AppStrings.instantConsultationFeature2.tr,
                            style: AppStyles.subTitleStyle(size: 13),
                          )
                        ],
                      ),


                      // UiHelper.verticalSpaceMedium,
                    ],
                  ),
                ),
                UiHelper.verticalSpaceSmall,
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Column(
                    children: [
                      featureItem(AppStrings.instantConsultationFeature1,color: AppColors.red),
                      // UiHelper.verticalSpaceSmall,
                      // featureItem(AppStrings.instantConsultationFeature3),
                      UiHelper.verticalSpaceSmall,


                      // featureItem(AppStrings.instantConsultationFeature2),
                    ],
                  ),
                ),
                // UiHelper.verticalSpaceMedium,


                UiHelper.verticalSpaceMedium,
                if (logic.currentUser != null)
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text.rich(
                            TextSpan(
                                text: AppStrings.prescriptionWillBeIssued.tr,
                                style: AppStyles.primaryStyle(
                                    bold: false,
                                    fontSize: 15,
                                    color: AppColors.primaryColor),
                                children: [
                                  TextSpan(
                                      text: logic.currentUser!.name,
                                      style: AppStyles.primaryStyle(
                                          bold: true, fontSize: 15))
                                ]),
                          )),
                        ],
                      ),
                      UiHelper.verticalSpaceSmall,
                      Row(
                        children: [
                          Text(AppStrings.prescriptionAnotherPatientHint.tr,style: AppStyles.primaryStyle(color: AppColors.primaryColorGreen),),
                        ],
                      )
                    ],
                  ),
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.h)),
                          child: Row(
                            children: [
                              Text(
                                '${AppStrings.price.tr} :  ${logic.price}  ${AppStrings.currency.tr}',
                                style: AppStyles.whiteStyle(bold: true),
                              ),
                              Spacer(),
                              Text(
                                AppStrings.priceWithoutVAT.tr,
                                style:
                                    AppStyles.whiteStyle(bold: false, size: 12),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                UiHelper.verticalSpaceLarge,
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Column(
                    children: [
                      UiHelper.verticalSpaceMedium,

                      Text(
                        AppStrings.scanCodeMsg.tr,
                        style: AppStyles.primaryStyle(
                            bold: false, fontSize: 13, height: 1.5),
                      ),

                      //    UiHelper.verticalSpaceMedium,

                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              textInputAction: TextInputAction.newline,
                              //  keyboardType: TextInputType.multiline,
                              //   maxLines: null,
                              focusNode: _focusNode,
                              obscureText: true,
                              obscuringCharacter: '*',
                              style: AppStyles.primaryStyle(
                                  color: AppColors.primaryColor, fontSize: 17),
                              controller: QrScannerLogic.qrCtrl,
                              decoration: InputDecoration(
                                labelStyle: AppStyles.primaryStyle(bold: true),
                                filled: true,
                                fillColor: AppColors.primaryColorOpacity,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
                                hintText: AppStrings.enterCode.tr,
                                errorStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                                errorBorder: outlineInputBorder,
                                hintStyle: AppStyles.subTitleStyle(
                                  bold: true,
                                ),
                                border: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                              ),
                            ),
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Text(
                            AppStrings.or.tr,
                            style:
                                AppStyles.primaryStyle(bold: false, fontSize: 15),
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Expanded(
                              flex: 2,
                              child: Ui.primaryButton(
                                  title: AppStrings.scan,
                                  icon: FontAwesomeIcons.qrcode,
                                  fontSize: 13,
                                  iconSize: 18,
                                  paddingV: 10,
                                  radius: 5,
                                  paddingH: 5,
                                  onTab: () async {
                                    await DifferentDialog.showScanQRDialog();
                                    logic.update();
                                  })),
                        ],
                      ),




                      Row(
                        children: [
                          Expanded(child: ActionButton(radius: 5,backgroundColor: AppColors.primaryColorGreen,text: AppStrings.verify.tr,onPressed: (){

logic.checkDiscountCode();

                          },)),
                        ],
                      ),

                      UiHelper.verticalSpaceSmall,

                    ],
                  ),
                ),



                UiHelper.verticalSpaceMedium,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                              text: '${AppStrings.byClick.tr} ',
                              style: AppStyles.subTitleStyle(
                                size: 13,
                              ),
                              children: [
                                TextSpan(
                                    text: AppStrings.termsAndConditions.tr,
                                    style: AppStyles.primaryStyle(
                                        fontSize: 13, bold: true, height: 1.5),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(
                                            AppRouteNames.termsOfService);
                                      })
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Ui.primaryButton(
                          title: AppStrings.sendRequest,
                          fontSize: 15,
                          paddingV: 15,
                          onTab: () {
                            Get.bottomSheet(
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 50.h, horizontal: 30.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text.rich(
                                            TextSpan(
                                                text: AppStrings
                                                    .prescriptionWillBeIssued
                                                    .tr,
                                                style: AppStyles.primaryStyle(
                                                    bold: false,
                                                    fontSize: 15,
                                                    color:
                                                        AppColors.primaryColor),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          logic.currentUser
                                                              !
                                                              .name,
                                                      style: AppStyles
                                                          .primaryStyle(
                                                              bold: true,
                                                              fontSize: 15))
                                                ]),
                                          )),
                                        ],
                                      ),
                                      UiHelper.verticalSpaceLarge,
                                      Text(
                                        AppStrings.sendRequestMsg.tr,
                                        textAlign: TextAlign.center,
                                        style: AppStyles.primaryStyle(
                                            bold: true, fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Ui.primaryButton(
                                                title: AppStrings.sendRequest,
                                                paddingV: 15,
                                                onTab: () {
                                                  logic.sendRequest();
                                                }),
                                          ),

                                          UiHelper.horizontalSpaceMedium,

                                          Expanded(
                                            child: Ui.primaryButton(
                                                title: AppStrings.back,
                                                color:
                                                AppColors.primaryColorGreen,
                                                paddingV: 15,
                                                onTab: () {
                                                  Get.back();
                                                  Future.delayed(
                                                      Duration(
                                                          milliseconds: 10),
                                                          () {
                                                        Get.back();
                                                      });
                                                }),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.h),
                                      topLeft: Radius.circular(10.h))),
                              backgroundColor: AppColors.white,
                            );
                          }),
                    ),
                  ],
                )
              ],
            );
    });
  }

  featureItem(String title,{Color color=AppColors.primaryColorGreen}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.h,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50.h)),
          ),
          UiHelper.horizontalSpaceSmall,
          Expanded(
              child: Text(
            title.tr,
            style: AppStyles.primaryStyle(fontSize: 13,height: 1.5,color: color),
          ))
        ],
      ),
    );
  }
}
