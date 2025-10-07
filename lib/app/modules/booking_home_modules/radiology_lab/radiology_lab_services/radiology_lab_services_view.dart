import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/eunums/enums.dart';
import '../../../../data/models/dept.dart';
import '../../../../data/models/nurse_service.dart';
import '../../../../global_widgets/shared/dynamic_list.dart';
import '../../../../global_widgets/shared/globcare_search.dart';
import '../../../../global_widgets/shared/loading.dart';
import '../../../../global_widgets/shared/my_appbar.dart';
import '../../../../global_widgets/shared/tab_item.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../nurse_services/widgets/service_item.dart';
import '../../patient_data/patient_data_logic.dart';
import '../../pcr/pcr_services/widgets/pcr_item.dart';
import 'radiology_lab_services_logic.dart';

class RadiologyLabServicesPage extends StatelessWidget {
  final logic = Get.put(RadiologyLabServicesLogic());
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: GetBuilder<RadiologyLabServicesLogic>(builder: (controller) {
      return Column(
        children: [
          myAppBarServices(
              title: logic.homeService.name,
              showAll: true,
              code: logic.homeService.code),

          //  UiHelper.verticalSpaceLarge,
          if (logic.homeService.code == 'L')
            SizedBox(
              height: 50.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TabItem(
                    name: AppStrings.individualTest,
                    onTab: () {
                      logic.updateIndex(0);
                      logic.update();
                    },
                    selected: logic.index == 0,
                  ),
                  UiHelper.horizontalSpaceMedium,
                  TabItem(
                    name: AppStrings.labPackages,
                    onTab: () {
                      logic.updateIndex(1);
                      logic.update();
                    },
                    selected: logic.index == 1,
                  ),
                  UiHelper.horizontalSpaceMedium,
                ],
              ),
            ),

          if (logic.homeService.code != 'PCR')
            GlobcareSearch(
              controller: logic,
            ),
          UiHelper.verticalSpaceSmall,
          Row(
            children: [
              Expanded(
                  child: Text(
                AppStrings.priceWithoutVATAndHVP.tr,
                style: AppStyles.primaryStyle(
                  color: AppColors.primaryColorGreen,
                ),
              )),
            ],
          ),
          UiHelper.verticalSpaceMedium,

          Expanded(
              child: (!controller.busy)
                  ? DynamicListView(
                    //  key: globalKey,
                      data: logic.searchList,
                      itemBuilder: (item) => logic.homeService.code == 'PCR'
                          ? PCRItem(
                              logic: logic,
                              pcrModel: item as NurseService,
                            )
                          : GestureDetector(
                              onTap: () {
                                logic.updateItems(item as NurseService);
                              },
                              child: GestureDetector(
                                  onTap: () {
                                    // logic.navToTimeSlots(item as NurseService);
                                    logic.updateItems(item as NurseService);
                                    PatientDataLogic.chooseDateType =
                                        ChooseDateType.other;
                                  },
                                  child: ServiceItem(
                                      nurseService: item as NurseService,
                                      selected: logic.checkItem(item)))))
                  : Center(child: MyLoadingWidget())),

          if (logic.homeService.code != 'PCR')
            Ui.primaryButton(
                title: AppStrings.continueText,
                color: logic.selectedItems.isNotEmpty
                    ? AppColors.primaryColor
                    : AppColors.extraGrey,
                onTab: () {
                  logic.navToTimeSlots();
                })
        ],
      );
    }));
  }

  Widget title(Dept dept) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.primaryColorOpacity,
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    UiHelper.horizontalSpaceMedium,
                    Text(
                      dept.name.tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Ui.vSpace10,
                Row(
                  children: [
                    UiHelper.horizontalSpaceMedium,
                    Expanded(
                      child: Text(
                        dept.description.tr,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    UiHelper.horizontalSpaceMedium,
                  ],
                ),
              ],
            ),
          ),
          // Ui.hSpace10,
          // Container(
          //     padding: EdgeInsets.all(3),
          //     decoration: BoxDecoration(
          //         borderRadius:
          //         BorderRadius.circular(8),
          //         color: logic.depts[index] ==
          //             logic.selectedDept
          //             ? AppColors.primaryColorGreen
          //             : AppColors.primaryColorOpacity,
          //         border: Border.all(
          //             width: 2,
          //             color: logic.depts[index] ==
          //                 logic.selectedDept
          //                 ? AppColors.primaryColorGreen
          //                 : AppColors.subTitleColor)),
          // ),
          // Ui.hSpace10,
        ],
      ),
    );
  }
}
