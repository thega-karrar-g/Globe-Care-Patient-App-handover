import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'choose_date_period_logic.dart';
import 'widgets/select_branch.dart';
import 'widgets/week_item_period.dart';

class ChooseDatePeriodPage extends StatelessWidget {
  ChooseDatePeriodPage({Key? key, this.globalKey}) : super(key: key);

  GlobalKey? globalKey = GlobalKey();
  final ChooseDatePeriodLogic logic = Get.put(ChooseDatePeriodLogic());

  // final logic = Get.find<BookDoctorLogic>();

  // math.Random random = math.Random();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // myAppBar2(title: AppStrings.chooseDate),

        GetBuilder<ChooseDatePeriodLogic>(builder: (controller) {
          return controller.busy
              ? MyLoadingWidget()
              : Column(
                  children: [
                    UiHelper.verticalSpaceMedium,


                    if(BookingConstants.service.name !=AppStrings.homeVisitDoctor  && !logic.isCaregiverOrSleep)
                      SelectBranch(logic: logic,).paddingOnly(bottom: 8.h),



                    if (controller.route ==
                        AppRouteNames.physiotherapistServices)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UiHelper.verticalSpaceMedium,
                          Ui.titleGreenUnderLine(AppStrings.doctorGender),
                          Row(
                            children: [
                              genderButton(
                                  title: AppStrings.male,
                                  selected: controller.genderIndex == 0,
                                  onTab: () {
                                    controller.updateGender(0);
                                  }),
                              UiHelper.horizontalSpaceMedium,
                              genderButton(
                                  title: AppStrings.female,
                                  selected: controller.genderIndex == 1,
                                  onTab: () {
                                    controller.updateGender(1);
                                  }),
                              UiHelper.horizontalSpaceMassive,
                              Icon(
                                FontAwesomeIcons.male,
                                color: controller.genderIndex == 0
                                    ? AppColors.primaryColor
                                    : AppColors.subTitleColor,
                              ),
                              Icon(
                                FontAwesomeIcons.female,
                                color: controller.genderIndex == 1
                                    ? AppColors.primaryColor
                                    : AppColors.subTitleColor,
                              ),
                            ],
                          )
                        ],
                      ).paddingOnly(bottom: 16.h),
                    // UiHelper.verticalSpaceMedium,
                    Ui.titleGreenUnderLine(AppStrings.chooseDate.tr,
                        bottomPadding: 0),
                    UiHelper.verticalSpaceMedium,
                    if (controller.periodItems.isNotEmpty)
                      Container(
                        color: AppColors.white,
                        child: Column(
                          children: [
                            // PriceItem(appUser: controller.currentUser!,controller: controller,),
                            // UiHelper.verticalSpaceLarge,

                            Row(
                              children: [
                                Text(
                                  DateFormat('MMMM', Get.locale.toString())
                                      .format(controller.selectedDay),
                                  style: AppStyles.primaryStyle(
                                      bold: true, fontSize: 18),
                                ),
                                UiHelper.horizontalSpaceSmall,
                                Text(
                                  DateFormat('yyyy')
                                      .format(controller.selectedDay),
                                  style: AppStyles.subTitleStyle(
                                      bold: true, size: 15),
                                ),
                              ],
                            ),

                            //   UiHelper.verticalSpaceMedium,

                            SizedBox(
                              height: 100.h,
                              child: ListView.builder(
                                itemCount: controller.periodItems.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (bc, index) => WeekItemPeriod(
                                  weekName:
                                      DateFormat('E', Get.locale.toString())
                                          .format(
                                    controller.periodItems[index].date,
                                  ),
                                  weekNo:
                                      '${controller.periodItems[index].date.day}',
                                  onTab: () {
                                    controller.changeDay(index);
                                  },
                                  selected:
                                      controller.periodItems[index].date ==
                                          controller.selectedDay,
                                ),
                              ),
                            ),
                            //  UiHelper.verticalSpaceMedium,

                            if (controller.dayPeriods.isNotEmpty)
                              SizedBox(
                                height: 50.h,
                                child: DynamicListView(
                                    key: null,
                                    // key: GlobalObjectKey('key${random.nextInt(100000)}') ,
                                    axis: Axis.horizontal,
                                    data: controller.dayPeriods,
                                    itemBuilder: (item) => GestureDetector(
                                          onTap: () {
                                            controller.selectPeriod(
                                                p: item as String);
                                          },
                                          child: Container(
                                            key: GlobalKey(),
                                            alignment: Alignment.topCenter,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.w),
                                                color: item ==
                                                        ChooseDatePeriodLogic
                                                            .selectedPeriod
                                                    ? AppColors.primaryColor
                                                    : AppColors.white,
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: Text(
                                              '${item
                                                      .toString()
                                                      .toLowerCase()
                                                      .tr
                                                      .capitalizeFirst}\n${ controller.periodTime(item
                                                  .toString()
                                                  .toLowerCase())}'
                                                 ,
                                              textAlign: TextAlign.center,
                                              style: item.toString() ==
                                                      ChooseDatePeriodLogic
                                                          .selectedPeriod
                                                  ? AppStyles.whiteStyle(
                                                      bold: true,
                                                      height: 1.5,
                                                      size: 12)
                                                  : AppStyles.primaryStyle(
                                                      bold: true,
                                                      height: 1.5,
                                                      fontSize: 12,
                                                      opacity: .8),
                                            ),
                                          ),
                                        )),
                              ),

                            // if(controller.dayPeriods.isNotEmpty)
                            //
                            // Ui.primaryButton(title: AppStrings.continueTo,marginH: 0,onTab: (){
                            //
                            //   controller.navToPatientData();
                            // })
                          ],
                        ),
                      )
                    else
                      NoDataFound(
                        animation: AppAnim.calenderFull,
                        msg: AppStrings.noAvailableAppointments,
                      ),
                  ],
                );
        }),

        UiHelper.verticalSpaceLarge,
      ],
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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryColor
                : AppColors.primaryColorOpacity,
            borderRadius: BorderRadius.circular(10)),
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
