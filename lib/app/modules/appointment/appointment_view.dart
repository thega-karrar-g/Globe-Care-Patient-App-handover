import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../global_widgets/shared/loading.dart';
import '../../global_widgets/shared/my_appbar.dart';
import '../../global_widgets/shared/tab_item.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import '../../global_widgets/ui.dart';
import 'appointment_controller.dart';
import 'widgets/appointment_list.dart';

class AppointmentPage extends StatelessWidget {
  @override
  final controller = Get.put(AppointmentController());

  AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: GetBuilder<AppointmentController>(builder: (controller) {
      return Column(
        children: [
          myAppBar2(title: controller.arg.name, showAll: true),

          UiHelper.verticalSpaceSmall,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
                color: AppColors.primaryColorOpacity,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  AppointmentController.user!.name,
                  style: AppStyles.primaryStyle(
                      color: AppColors.primaryColor, fontSize: 16, bold: true),
                )),
              ],
            ),
          ),

          UiHelper.verticalSpaceMedium,
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Container(
          //     // height: 60,
          //     padding: EdgeInsets.symmetric(horizontal: 0),
          //     child: Row(
          //       children: [
          //         //  UiHelper.horizontalSpaceMedium,
          //         TabItem(
          //             name: AppStrings.confirmed,
          //             fontSize: 16,
          //             selected: controller.appointmentStatus ==
          //                 AppointmentStatus.confirmed,
          //             onTab: () {
          //               controller.updateAppointmentStatus(
          //                   AppointmentStatus.confirmed);
          //             }),
          //
          //         // UiHelper.horizontalSpaceMedium,
          //         TabItem(
          //             name: AppStrings.completed,
          //             fontSize: 16,
          //             selected: controller.appointmentStatus ==
          //                 AppointmentStatus.completed,
          //             onTab: () {
          //               controller.updateAppointmentStatus(
          //                   AppointmentStatus.completed);
          //             }),
          //         //    UiHelper.horizontalSpaceMedium,
          //
          //         TabItem(
          //             name: AppStrings.scheduled,
          //             fontSize: 16,
          //             selected: controller.appointmentStatus ==
          //                 AppointmentStatus.underReview,
          //             onTab: () {
          //               controller.updateAppointmentStatus(
          //                   AppointmentStatus.underReview);
          //             }),
          //
          //         TabItem(
          //             name: AppStrings.canceled,
          //             fontSize: 16,
          //             selected: controller.appointmentStatus ==
          //                 AppointmentStatus.canceled,
          //             onTab: () {
          //               controller.updateAppointmentStatus(
          //                   AppointmentStatus.canceled);
          //             }),
          //       ],
          //     ),
          //   ),
          // ),

          //    myAppBar(title: AppStrings.appointment.tr.capitalize!),
          Expanded(
              child: (!controller.busy)
                  ? RefreshIndicator(
                      onRefresh: () => controller.getAppointments(),
                      child: PageView(
                        //  physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,

                        children: [
                          AppointmentList(
                            homeService: controller.arg,
                            appointments: controller.appointmentGroup,
                          ),
                          // AppointmentList(
                          //   homeService: controller.arg,
                          //   appointments: controller.appointmentGroup,
                          // ),
                          // AppointmentList(
                          //   homeService: controller.arg,
                          //   appointments: controller.appointmentGroup,
                          // ),
                          // AppointmentList(
                          //   homeService: controller.arg,
                          //   appointments: controller.appointmentGroup,
                          // ),
                        ],
                        onPageChanged: (int index) {
                          switch (index) {
                            case 0:
                              {
                                controller.updateAppointmentStatus(
                                    AppointmentStatus.confirmed);
                              }
                              break;
                            case 1:
                              {
                                controller.updateAppointmentStatus(
                                    AppointmentStatus.completed);
                              }
                              break;
                            case 2:
                              {
                                controller.updateAppointmentStatus(
                                    AppointmentStatus.underReview);
                              }
                              break;
                            case 3:
                              {
                                controller.updateAppointmentStatus(
                                    AppointmentStatus.canceled);
                              }
                              break;
                          }

                          // controller.changePageIndex(index);
                          // controller.   pageController.animateToPage(index,
                          //     duration: duration,
                          //     curve: Curves.easeOutQuad);
                          // print('index:$index');
                        },
                      ),
                    )
                  : Center(child: MyLoadingWidget())),
        ],
      );
    }));
  }
}
