import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/dynamic_column.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/shared/tab_item.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'widgets/week_item_period.dart';
import '../doctors/widgets/doctor_item.dart';
import 'doctor_schedule_logic.dart';
import 'widgets/doctor_details.dart';

class DoctorSchedulePage extends StatelessWidget {
  final DoctorScheduleLogic logic = Get.put(DoctorScheduleLogic());

  GlobalKey globalKey = GlobalKey();

  DoctorSchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: SingleChildScrollView(
      child: Column(
        children: [
          myAppBar2(title: AppStrings.doctorDetails),
          //  UiHelper.verticalSpaceMedium,

          // Row(children: [
          //   Expanded(child: Text(AppStrings.doctorInfo.tr,style: AppStyles.primaryStyle(size: 16,bold: true),)),
          //
          // ],),
          // UiHelper.verticalSpaceSmall,

          DoctorItemList(
            doctor: logic.doctor,
          ),

          UiHelper.verticalSpaceLarge,

          GetBuilder<DoctorScheduleLogic>(builder: (logic) {
            return Column(
              children: [
                SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: TabItem(
                            name: AppStrings.availableAppointments,
                            selected: logic.infoIndex == 0,
                            onTab: () {
                              logic.changeInfoIndex(0);
                            }),
                      ),

                      UiHelper.horizontalSpaceSmall,

                      Expanded(
                        child: TabItem(
                            name: AppStrings.moreDetails,
                            selected: logic.infoIndex == 1,
                            onTab: () {
                              logic.changeInfoIndex(1);
                            }),
                      ),
                    ],
                  ),
                ),
                UiHelper.verticalSpaceMedium,
                Visibility(
                  visible: logic.infoIndex == 0,
                  child: logic.busy
                      ? MyLoadingWidget()
                      : (logic.scheduleList.isNotEmpty)
                          ? DynamicColumn(
                              children: [
                                Row(
                                  children: [
                                    UiHelper.horizontalSpaceSmall,
                                    Text(
                                      DateFormat('MMMM', Get.locale.toString())
                                          .format(logic.selectedDay),
                                      style: AppStyles.primaryStyle(
                                          bold: true, fontSize: 18),
                                    ),
                                    UiHelper.horizontalSpaceSmall,
                                    Text(
                                      DateFormat('yyyy')
                                          .format(logic.selectedDay),
                                      style: AppStyles.subTitleStyle(
                                          bold: true, size: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 100.h,
                                  child: ListView.builder(
                                    itemCount: logic.scheduleList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (bc, index) => SizedBox(
                                      height: 200.h,
                                      child: WeekItemPeriod(
                                        weekName: DateFormat(
                                                'E', Get.locale.toString())
                                            .format(
                                          logic.scheduleList[index].date,
                                        ),
                                        weekNo:
                                            '${logic.scheduleList[index].date.day}',
                                        onTab: () {
                                          logic.changeDay(index);
                                        },
                                        selected:
                                            logic.scheduleList[index].date ==
                                                logic.selectedDay,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                  child: DynamicListView(

                                      // key: globalKey,
                                      axis: Axis.horizontal,
                                      data: logic
                                          .scheduleList[logic.currentIndex]
                                          .times!,
                                      itemBuilder: (item) {
                                        var time = item as String;
                                        return GestureDetector(
                                          onTap: () {
                                            logic.changeSlot(time);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 5.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.h),
                                                color: logic.checkSlot(
                                                        time,
                                                        logic
                                                            .scheduleList[logic
                                                                .currentIndex]
                                                            .date)
                                                    ? AppColors.primaryColor
                                                    : AppColors.white,
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: Text(
                                              time,
                                              style: logic.checkSlot(
                                                      time,
                                                      logic
                                                          .scheduleList[logic
                                                              .currentIndex]
                                                          .date)
                                                  ? AppStyles.whiteStyle(
                                                      bold: true)
                                                  : AppStyles.subTitleStyle(
                                                      bold: true),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                UiHelper.verticalSpaceSmall,
                                Ui.primaryButton(
                                    title: AppStrings.bookNow,
                                    marginH: 0,
                                    onTab: () {
                                      logic.navToPatientData();
                                    },
                                    color: AppColors.primaryColor)
                              ],
                            )
                          : Center(
                              child: NoDataFound(
                                animation: AppAnim.calenderFull,
                                msg: AppStrings.noAvailableAppointments,
                              ),
                            ),
                ),
                Visibility(
                    visible: logic.infoIndex == 1,
                    child: DoctorDetails(
                      doctor: logic.doctor,
                    )),
              ],
            );
          }),
        ],
      ),
    ));
  }
}
