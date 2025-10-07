import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:globcare/app/core/assets_helper/app_images.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../global_widgets/shared/dynamic_column.dart';
import '../../global_widgets/shared/loading.dart';
import '../../global_widgets/shared/my_appbar.dart';
import '../../global_widgets/shared/no_data.dart';
import '../../global_widgets/shared/tab_item.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import '../../global_widgets/ui.dart';
import '../../core/assets_helper/app_anim.dart';
import '../appointment_requests_module/appointment_request_types/appointment_request_types_page.dart';
import '../booking_home_modules/patient_data/widgets/patient_item.dart';
import 'appointment_types_logic.dart';
import 'widgets/appointment_type_item.dart';

class AppointmentTypesPage extends StatelessWidget {
  AppointmentTypesPage({Key? key}) : super(key: key);
  final controller = Get.put(AppointmentTypesLogic());

  final ScrollController scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    var withBack = true;

    if (Get.arguments != null) {
      withBack = false;
    }

    return Ui.myScaffold(
      child: GetBuilder<AppointmentTypesLogic>(builder: (logic) {
        return Column(
          children: [
            myAppBar3(
                title: AppStrings.appointmentsAndRequests, withBack: withBack, h: 20),
            UiHelper.verticalSpaceSmall,
            UiHelper.verticalSpaceLarge,

            // Row(
            //   children: [
            //     //  UiHelper.horizontalSpaceMedium,
            //     Expanded(
            //       child: TabItem(
            //           name: AppStrings.appointments,
            //           fontSize: 16,
            //           selected: controller.isAppointment,
            //           onTab: () {
            //             controller.changeIsAppointment(true);
            //           }),
            //     ),
            //
            //     UiHelper.horizontalSpaceMedium,
            //     Expanded(
            //       child: TabItem(
            //           name: AppStrings.requestsContracts,
            //           fontSize: 16,
            //           selected: !controller.isAppointment,
            //           onTab: () {
            //             controller.changeIsAppointment(false);
            //           }),
            //     ),                //    UiHelper.horizontalSpaceMedium,
            //
            //
            //   ],
            // ),
            //
            // UiHelper.verticalSpaceLarge,
            Row(
              children: [
                Ui.titleGreenUnderLine(AppStrings.selectPatient.tr,
                    bottomPadding: 8),
              ],
            ),

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
                      minThumbLength: 150.w,

                      controller: scrollController,
        thumbColor: AppColors.primaryColor.withOpacity(.5),
        radius: Radius.circular(5.h),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(bottom: 5.h),
                        controller: scrollController,
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
                                        selected: logic.selectedPatient != null &&
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
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.bottomSheet(Padding(
                  //       padding: const EdgeInsets.all(30.0),
                  //       child: AddMemberForm(),
                  //     ),
                  //         isScrollControlled: true,
                  //
                  //         backgroundColor: AppColors.white,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(10),
                  //                 topRight: Radius.circular(10))
                  //         )
                  //     ).then((value) {
                  //       print('***************************   after ');
                  //       logic.fetch();
                  //     });
                  //   },
                  //   child: Container(
                  //     // width: 100.w,
                  //     padding: EdgeInsets.symmetric(horizontal: 5.w),
                  //     height: 30.h,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: AppColors.primaryColorGreen,
                  //         borderRadius: BorderRadius.only(
                  //           topRight: Radius.circular(ar ? 5.h : 0),
                  //           bottomRight: Radius.circular(ar ? 5.h : 0),
                  //
                  //           bottomLeft: Radius.circular(ar ? 0 : 5.h),
                  //           topLeft: Radius.circular(ar ? 0 : 5.h),
                  //
                  //
                  //         )
                  //     ),
                  //
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //
                  //         Icon(Icons.add, color: AppColors.white, size: 17.w,),
                  //         UiHelper.horizontalSpaceTiny,
                  //         Text(AppStrings.addNew.tr, textAlign: TextAlign.center,
                  //           style: AppStyles.whiteStyle(bold: false, size: 11),),
                  //
                  //         UiHelper.horizontalSpaceTiny,
                  //
                  //       ],
                  //     ),
                  //
                  //   ),
                  // )
                  // ,
                ],
              ),
            ),



            UiHelper.verticalSpaceLarge,


            Expanded(
                child: logic.busy
                    ? MyLoadingWidget()
                    : SingleChildScrollView(
                      child: RefreshIndicator(
                          onRefresh: () => logic.getCount(),
                          child:
                          Column(
                            children: [
                              GFAccordion(
                                // title:AppStrings.appointments.tr,
                                // content: e['description'],
                                titleChild: Row(children: [

                                  SvgPicture.asset(AppImages.appointmentCategory,color: AppColors.primaryColor,width: 50.w,height: 50.h,),
                                  UiHelper.horizontalSpaceMedium,
                                  Text(AppStrings.appointments.tr,style: AppStyles.primaryStyle(bold: true,fontSize: 15),)

                                ],),

                                contentChild: SizedBox(
                                  child: logic.appointmentTypes.isNotEmpty
                                      ?




                                  Column(
                                    children: logic.appointmentTypes
                                        .map((e) => AppointmentTypeItem(
                                      homeService: e,
                                      onTab:()=> logic.onAppointmentTypeTab(e),
                                    ))
                                        .toList(),
                                  )
                                      : Column(
                                    children: const [
                                      NoDataFound(
                                        animation: AppAnim.noAppointmentFound,
                                        msg: AppStrings.noAvailableBookings,
                                      ),
                                    ],
                                  ),
                                ),
                                collapsedIcon: Icon(Icons.keyboard_arrow_left),
                                expandedIcon: Icon(Icons.keyboard_arrow_up),
                                expandedTitleBackgroundColor: AppColors.primaryColorOpacity,
                                collapsedTitleBackgroundColor: AppColors.primaryColorOpacity,
                                margin: EdgeInsets.zero,

                                titlePadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
                                titleBorderRadius: BorderRadius.circular(10.r),
                                textStyle: AppStyles.primaryStyle(color: AppColors.primaryColor,bold: true,fontSize: 15),





                                // contentPadding: EdgeInsets.zero,


                                // titleBorder: Border(bottom: BorderSide(color: AppColors.primaryColor.withOpacity(.2))),

                              ),

                              UiHelper.verticalSpaceMedium,

                              GFAccordion(
                              //  title:AppStrings.requestsContracts.tr,
                                // content: e['description'],
                                contentChild: SizedBox(
                                  child:




                                  AppointmentRequestTypesPage()

                                ),
                                collapsedIcon: Icon(Icons.keyboard_arrow_left),
                                expandedIcon: Icon(Icons.keyboard_arrow_up),
                                expandedTitleBackgroundColor: AppColors.primaryColorOpacity,
                                collapsedTitleBackgroundColor: AppColors.primaryColorOpacity,
                                margin: EdgeInsets.zero,
                                titleChild: Row(children: [

                                  SvgPicture.asset(AppImages.contractCategory,color: AppColors.primaryColor,width: 50.w,height: 50.h),
                                  UiHelper.horizontalSpaceMedium,
                                  Text(AppStrings.requestsContracts.tr,style: AppStyles.primaryStyle(bold: true,fontSize: 15),)

                                ],),

                                titlePadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
                                titleBorderRadius: BorderRadius.circular(10.r),
                                textStyle: AppStyles.primaryStyle(color: AppColors.primaryColor,bold: true,fontSize: 14),





                                // contentPadding: EdgeInsets.zero,


                                // titleBorder: Border(bottom: BorderSide(color: AppColors.primaryColor.withOpacity(.2))),

                              ),
                            ],
                          )


                        ),
                    ))
          ],
        );
      }),
    );
  }
}
