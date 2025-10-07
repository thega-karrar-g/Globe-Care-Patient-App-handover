import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../global_widgets/shared/dynamic_column.dart';
import '../../global_widgets/shared/loading.dart';
import '../../global_widgets/shared/my_appbar.dart';
import '../../global_widgets/shared/no_data.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import '../../global_widgets/ui.dart';
import '../../core/assets_helper/app_anim.dart';
import 'appointment_member_types_logic.dart';
import 'widgets/appointment_type_item.dart';

class AppointmentMemberTypesPage extends StatelessWidget {
  AppointmentMemberTypesPage({Key? key}) : super(key: key);
  final controller = Get.put(AppointmentMemberTypesLogic());

  @override
  Widget build(BuildContext context) {

    return Ui.myScaffold(
      child: Column(
        children: [
          myAppBar2(title: AppStrings.appointmentList, withBack: true, h: 20),
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
                  controller.user.name,
                  style: AppStyles.primaryStyle(
                      color: AppColors.primaryColor, fontSize: 16, bold: true),
                )),
              ],
            ),
          ),
          UiHelper.verticalSpaceMedium,
          GetBuilder<AppointmentMemberTypesLogic>(builder: (logic) {
            return logic.busy
                ? MyLoadingWidget()
                : Expanded(
                    child: RefreshIndicator(
                    onRefresh: () => logic.getCount(),
                    child: logic.appointmentTypes.isNotEmpty
                        ? DynamicColumn(
                            children: logic.appointmentTypes
                                .map((e) => AppointmentTypeItem(
                                      homeService: e,
                              onTab:()=> logic.onAppointmentTypeTab(e),

                            ))
                                .toList(),
                          )
                        : Column(
                            children: [
                              UiHelper.verticalSpace(Get.height * .2),
                              NoDataFound(
                                animation: AppAnim.noAppointmentFound,
                                msg: AppStrings.noAvailableBookings,
                              ),
                            ],
                          ),
                  ));
          })
        ],
      ),
    );
  }
}
