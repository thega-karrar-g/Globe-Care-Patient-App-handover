import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../global_widgets/audio/record_widget.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../auth/widgets/reactive_login_form.dart';
import '../../auth/widgets/reactive_register_form.dart';
import '../../my_profile_module/members/widgets/reactive_add_member_form.dart';
import '../choose_date_period/choose_date_period_view.dart';
import '../pcr/choose_date/choose_date_view.dart';
import 'patient_data_logic.dart';
import 'widgets/caregiver_contract_details.dart';
import 'widgets/file_item.dart';
import 'widgets/notes_widget.dart';
import 'widgets/patient_item.dart';
import 'widgets/select_attatchment.dart';
import '../choose_date_period/widgets/select_branch.dart';
import 'widgets/select_nationality.dart';
import 'widgets/select_patient_widget.dart';

class PatientDataPage extends StatelessWidget {
  final PatientDataLogic logic = Get.put(PatientDataLogic());

  PatientDataPage({Key? key}) : super(key: key);
  final FocusNode focusNode =
      FocusNode(); //1 - declare and initialize variable



  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(child: GetBuilder<PatientDataLogic>(builder: (logic) {
      return Column(
        children: [
          myAppBar2(title: logic.showCaregiverContractDetails ?AppStrings.contractData.tr: AppStrings.bookingData.tr),
          logic.busy
              ? MyLoadingWidget()
              : Expanded(
                  child: GestureDetector(
                    onTap: () {
                      focusNode.unfocus();
                    },
                    child: Container(
                      //  margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        // border: Border.all(color: AppColors.primaryColor.withOpacity(.1))
                      ),

                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(AppStrings.explainHealthProblem.tr,style:AppStyles.primaryStyle(bold: true,size: 14),),
                            //
                            // SizedBox(height: 10,),
                            //
                            // Text(AppStrings.tellDoctorSufferFromDiseases.tr,
                            //   style: AppStyles.subTitleStyle(),
                            // ),

                            //    UiHelper.verticalSpaceLarge,


                            /// select nationality  widget







                            if(logic.isSend)
                              SelectNationality(logic:logic),


                            /// select patent widget


                            SelectPatientWidget(logic:logic),


                            if ( logic.isDateTimeHidden)
                              Container()

                            else
                              ChooseDatePeriodPage(
                                globalKey: logic.periodsKey,
                              ),



                            UiHelper.verticalSpaceLarge,




                            if(!logic.isCaregiverOrSleep)
                            NotesWidget(focusNode: focusNode,),

                            // if(BookingVars.showFiles)
                            if(!logic.isCaregiverOrSleep)

                              SelectAttachment(logic:logic),


                            if(logic.showCaregiverContractDetails)
                            CaregiverContractDetails(),


                            if (logic.currentUser == null)
                              Column(
                                children: [
                                  Ui.primaryButton(
                                      title: AppStrings.logIn,
                                      //  marginV: 10,
                                      onTab: () {
                                        BookingConstants.fromPatientData = true;

                                        Get.bottomSheet(
                                                Padding(
                                                  padding:
                                                      UiHelper.safeAreaPadding,
                                                  child: SizedBox(
                                                      height: Get.height * .7,
                                                      child: ReactiveLoginForm(
                                                        title: AppStrings.logIn,
                                                      )),
                                                ),
                                                backgroundColor:
                                                    AppColors.white,
                                                isScrollControlled: true,
                                                enterBottomSheetDuration:
                                                    Duration(milliseconds: 750),
                                                exitBottomSheetDuration:
                                                    Duration(milliseconds: 750),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft: Radius
                                                                .circular(10))))
                                            .then((value) {
                                        //  logic.fetch();
                                        });

                                      }),
                                  SizedBox(
                                    height: 8,
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
                                        style:
                                            AppStyles.primaryStyle(bold: true),
                                      ),
                                      UiHelper.horizontalSpaceMedium,
                                      Expanded(
                                          child: Divider(
                                        color: AppColors.subTitleColor,
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          BookingConstants.fromPatientData = true;



                                          Get.bottomSheet(
                                                  Padding(
                                                    padding: UiHelper
                                                        .safeAreaPadding,
                                                    child: SizedBox(
                                                        height: Get.height * .8,
                                                        child:
                                                            ReactiveRegisterForm()),
                                                  ),
                                                  backgroundColor:
                                                      AppColors.white,
                                                  isScrollControlled: true,
                                                  enterBottomSheetDuration:
                                                      Duration(
                                                          milliseconds: 750),
                                                  exitBottomSheetDuration:
                                                      Duration(
                                                          milliseconds: 750),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10))))
                                              .then((value) {

                                                logic.logger.i('result is :$value');


                                         //   logic.fetch();
                                          });

                                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors
                                                        .primaryColorGreen)),
                                            child: Text(
                                              AppStrings.register.tr,
                                              textAlign: TextAlign.right,
                                              style:
                                                  AppStyles.primaryStyleGreen(
                                                      bold: true, size: 15),
                                            )),
                                      ),

                                      UiHelper.horizontalSpaceMedium,

                                      //      Container(width:30,color: AppColors.subTitleColor,height: 1,),
                                      //     UiHelper.horizontalSpaceMedium,

                                      // GestureDetector(
                                      //   onTap: () {
                                      //     BookingVars.fromPatientData=true;
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
                              Ui.primaryButton(
                                  title: AppStrings.continueTo.tr,
                                  color: AppColors.primaryColor,
                                  marginH: 0,
                                  onTab: () {
                                    logic.navToNext();

//print(logic.currentUser);
                                  }),

                            UiHelper.verticalSpaceMassive
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
    }));
  }

  greenLine() {
    return Container(
      height: 5,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColorGreen),
    );
  }

  titleGreenUnderLine(String title, {double bottomMargin = 15}) {
    return IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            style: AppStyles.primaryStyle(bold: true, fontSize: 14),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 5,
                  //  width: Get.width*.3,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorGreen,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: bottomMargin,
          ),
        ],
      ),
    );
  }
}
