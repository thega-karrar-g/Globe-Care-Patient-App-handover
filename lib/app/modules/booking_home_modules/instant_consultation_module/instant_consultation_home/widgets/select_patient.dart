import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/shared/my_appbar.dart';

import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../data/constants/booking_constants.dart';
import '../../../../../global_widgets/shared/loading.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../../global_widgets/ui.dart';
import '../../../../../core/assets_helper/app_images.dart';
import '../../../../auth/widgets/reactive_login_form.dart';
import '../../../../auth/widgets/reactive_register_form.dart';
import '../../../../my_profile_module/members/widgets/reactive_add_member_form.dart';
import '../../../patient_data/widgets/patient_item.dart';
import '../instant_consultation_home_logic.dart';

class SelectPatient extends StatelessWidget {
  SelectPatient({Key? key}) : super(key: key);
  final ScrollController scrollController=ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstantConsultationHomeLogic>(builder: (logic) {
      if (logic.busy) {
        return MyLoadingWidget();
      } else {
        return Column(
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
                    ],
                  ),
                ),
                UiHelper.verticalSpaceMedium,
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Column(
                    children: [
                      featureItem(AppStrings.instantConsultationFeature1),
                      UiHelper.verticalSpaceSmall,
                      featureItem(AppStrings.instantConsultationFeature2)
                    ],
                  ),
                ),
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Ui.titleGreenUnderLine(AppStrings.selectPatient.tr,
                        bottomPadding: 8),
                  ],
                ),
                if(logic.selectedPatient==null)
                featureItem(AppStrings.pleaseSelectPatientMsg.tr,
                    bold: true, fontSize: 12, showDot: false),

                if (logic.currentUser != null)

                  Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: RawScrollbar(
                          thumbVisibility: logic.members.length >2 ,
                          controller: scrollController,
                          minThumbLength: 150.w,
                          thumbColor: AppColors.primaryColor.withOpacity(.5),
                          radius: Radius.circular(5.h),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            padding: EdgeInsets.only(bottom: 5.h),

                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // UiHelper.horizontalSpaceMedium,
                                Row(
                                  children: logic.members
                                      .map((e) => GestureDetector(
                                          onTap: () {
                                            logic.updateSelectedPatient(e);
                                          },
                                          child: PatientItem(
                                            user: e,
                                            selected: logic.selectedPatient !=
                                                    null &&
                                                logic.selectedPatient!.id == e.id,
                                          )))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      UiHelper.horizontalSpaceSmall,
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: AddMemberForm(),
                                  ),
                                  isScrollControlled: true,
                                  backgroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))))
                              .then((value) {
                            logic.fetch();
                          });
                        },
                        child: Container(
                          // width: 100.w,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          height: 30.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColorGreen,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(ar ? 5.h : 0),
                                bottomRight: Radius.circular(ar ? 5.h : 0),
                                bottomLeft: Radius.circular(ar ? 0 : 5.h),
                                topLeft: Radius.circular(ar ? 0 : 5.h),
                              )),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.white,
                                size: 17.w,
                              ),
                              UiHelper.horizontalSpaceTiny,
                              Text(
                                AppStrings.addNew.tr,
                                textAlign: TextAlign.center,
                                style:
                                    AppStyles.whiteStyle(bold: false, size: 11),
                              ),
                              UiHelper.horizontalSpaceTiny,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (logic.currentUser == null)
                  Column(
                    children: [
                      Ui.primaryButton(
                          title: AppStrings.logIn,
                          //  marginV: 10,
                          onTab: () {
                            BookingConstants.fromPatientData = true;
                            InstantConsultationHomeLogic.fromInstantConsultation = true;

                            Get.bottomSheet(
                                    Padding(
                                      padding: UiHelper.safeAreaPadding,
                                      child: SizedBox(
                                          height: Get.height * .7,
                                          child: ReactiveLoginForm(
                                            title: AppStrings.logIn,
                                          )),
                                    ),
                                    backgroundColor: AppColors.white,
                                    isScrollControlled: true,
                                    enterBottomSheetDuration:
                                        Duration(milliseconds: 750),
                                    exitBottomSheetDuration:
                                        Duration(milliseconds: 750),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.h),
                                            topLeft: Radius.circular(10.h))))
                                .then((value) {
                              logic.update();
                            });
                          }),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                            color: AppColors.subTitleColor,
                          )),
                          UiHelper.horizontalSpaceMedium,
                          Text(
                            AppStrings.or.tr,
                            style: AppStyles.primaryStyle(bold: true),
                          ),
                          UiHelper.horizontalSpaceMedium,
                          Expanded(
                              child: Divider(
                            color: AppColors.subTitleColor,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              BookingConstants.fromPatientData = true;
                              InstantConsultationHomeLogic.fromInstantConsultation = true;


                              Get.bottomSheet(
                                      Padding(
                                        padding: UiHelper.safeAreaPadding,
                                        child: SizedBox(
                                            height: Get.height * .8,
                                            child: ReactiveRegisterForm()),
                                      ),
                                      backgroundColor: AppColors.white,
                                      isScrollControlled: true,
                                      enterBottomSheetDuration:
                                          Duration(milliseconds: 750),
                                      exitBottomSheetDuration:
                                          Duration(milliseconds: 750),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10))))
                                  .then((value) {



                              });

                              //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.h),
                                    border: Border.all(
                                        width: 1,
                                        color: AppColors.primaryColorGreen)),
                                child: Text(
                                  AppStrings.register.tr,
                                  textAlign: TextAlign.right,
                                  style: AppStyles.primaryStyleGreen(
                                      bold: true, size: 15),
                                )),
                          ),

                          UiHelper.horizontalSpaceMedium,

                          //      Container(width:30,color: AppColors.subTitleColor,height: 1,),
                          //     UiHelper.horizontalSpaceMedium,

                          // GestureDetector(
                          //   onTap: () {
                          //     PatientDataLogic.fromPatientData=true;
                          //
                          //     Get.bottomSheet(Padding(
                          //       padding: UiHelper.safeAreaPadding,
                          //       child:   SizedBox(
                          //           height: Get.height*.8,
                          //           child: ReactiveRegisterGuestForm()),
                          //     ),
                          //         backgroundColor: AppColors.white,
                          //         isScrollControlled: true,
                          //         enterBottomSheetDuration: Duration(milliseconds: 750),
                          //         exitBottomSheetDuration: Duration(milliseconds: 750),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                          //         )
                          //
                          //     ).then((value) {
                          //       logic.update();
                          //
                          //     });
                          //
                          //     //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                          //   },
                          //
                          //   child: Container(
                          //
                          //
                          //
                          //       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          //
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(10),
                          //           border: Border.all(width: 1,color: AppColors.primaryColorGreen)
                          //       ),
                          //
                          //       child: Text(AppStrings.continueAsGuest.tr,style: AppStyles.primaryStyleGreen(bold: true,size: 15),)),
                          // ),
                        ],
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: Ui.primaryButton(
                            title: '${AppStrings.show.tr} ${AppStrings.previousPrescriptions.tr}',
                            color: AppColors.primaryColorGreen,
                            paddingV: 10,
                            paddingH: 5,
                            radius: 5,
                            fontSize: 12,
                            onTab: () {
                              //logic.sendRequest();

                              logic.navToPreviousPrescriptions();
                            }),
                      ),
                      UiHelper.horizontalSpaceMedium,
                      Expanded(
                        child: Ui.primaryButton(
                            title: AppStrings.bookConsultation,
                            paddingH: 10,
                            icon: Icons.arrow_forward,
                            iconSize: 18,
                            fontSize: 12,
                            radius: 5,
                            paddingV: 10,
                            onTab: () {
                              //logic.sendRequest();

                              logic.selectPatientClick();
                            }),
                      ),
                    ],
                  )
              ],
            );
      }
    });
  }

  featureItem(String title,
      {double fontSize = 11, bool bold = false, bool showDot = true}) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: showDot ? 10.w : 0, vertical: 5.h),
      child: Row(
        children: [
          if (showDot)
            Container(
              width: 10.w,
              height: 10.h,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: AppColors.primaryColorGreen,
                  borderRadius: BorderRadius.circular(50.h)),
            ),
          if (showDot) UiHelper.horizontalSpaceSmall,
          Expanded(
              child: Text(
            title.tr,
            style:
                AppStyles.primaryStyle(fontSize: fontSize, bold: bold, height: 1.5),
          ))
        ],
      ),
    );
  }
}
