import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../global_widgets/shared/dynamic_list.dart';
import '../../../../global_widgets/shared/loading.dart';
import '../../../../global_widgets/shared/no_data.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../core/assets_helper/app_anim.dart';
import '../../choose_date_period/widgets/week_item_period.dart';
import 'choose_date_logic.dart';

class ChoosePCRDatePage extends StatelessWidget {
  // final logic = Get.find<BookDoctorLogic>();
  bool ar = Get.locale.toString() == 'ar';
  final ChooseDateLogic logic = Get.put(ChooseDateLogic());

  ChoosePCRDatePage({Key? key}) : super(key: key);
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ui.titleGreenUnderLine(AppStrings.chooseDate),
        GetBuilder<ChooseDateLogic>(builder: (logic) {
          return Column(
            children: [
              UiHelper.verticalSpaceMedium,

              // PriceItem(appUser: logic.currentUser!,controller: logic,isPCR: true,),
              // UiHelper.verticalSpaceLarge,

              SizedBox(
                child: logic.busy
                    ? MyLoadingWidget()
                    : (logic.scheduleList.isNotEmpty)
                        ? DynamicColumn(
                            children: [
                              Row(
                                children: [
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
                                      weekName:
                                          DateFormat('E', Get.locale.toString())
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
                                    key: globalKey,
                                    axis: Axis.horizontal,
                                    data: logic.scheduleList[logic.currentIndex]
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
                                              horizontal: 15.w, vertical: 5.h),
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
                                                  color:
                                                      AppColors.primaryColor)),
                                          child: Text(
                                            time,
                                            style: logic.checkSlot(
                                                    time,
                                                    logic
                                                        .scheduleList[
                                                            logic.currentIndex]
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

                              // Row(
                              //   children: [
                              //     IntrinsicWidth(
                              //       child: Column(
                              //         mainAxisAlignment: MainAxisAlignment.start,
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           Row(
                              //             mainAxisAlignment: MainAxisAlignment.start,
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //             Text(AppStrings.certificateDetails.tr,style: AppStyles.primaryStyle(bold: true,size: 20),)
                              //
                              //           ],),
                              //           Row(children: [
                              //             Expanded(child: Container(
                              //               margin: EdgeInsets.only(top: 5,bottom: 5,),
                              //               height: 5,
                              //               decoration: BoxDecoration(color: AppColors.primaryColorGreen,
                              //                   borderRadius: BorderRadius.circular(5)
                              //               ),
                              //             ))
                              //
                              //           ],)
                              //
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Row(children: [
                              //   Expanded(child: Text(AppStrings.certificateDetailsHint.tr,style: AppStyles.subTitleStyle(bold: false,size: 16),))
                              //
                              // ],),
                              // Ui.primaryButton(title: AppStrings.continueTo,radius: 10,marginH: 0,onTab: (){
                              //   logic.navToPatientData();
                              //
                              // },color: AppColors.primaryColor)
                              //
                            ],
                          )
                        : Center(
                            child: NoDataFound(
                              animation: AppAnim.calenderFull,
                              msg: AppStrings.noAvailableAppointments,
                            ),
                          ),
              ),
            ],
          );
        }),
        UiHelper.verticalSpaceMassive,
      ],
    );
  }
}
