import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_fonts.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../nurse_services/widgets/service_item.dart';
import 'physiotherapist_logic.dart';

class PhysiotherapistPage extends StatelessWidget {
  final PhysiotherapistLogic logic = Get.put(PhysiotherapistLogic());

  bool ar = Get.locale.toString() == 'ar';

  PhysiotherapistPage({Key? key}) : super(key: key);
  var currency = Get.locale.toString() == 'ar' ? 'ر.س' : 'SR';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhysiotherapistLogic>(builder: (logic) {
      return Ui.myScaffold(
          child: Column(
        children: [
          myAppBarServices(
              title: AppStrings.physiotherapistServices, code: 'PHY'),
          if (logic.busy)
            Center(child: MyLoadingWidget())
          else
            Expanded(
              child: logic.items.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Expanded(
                          child: ListView.builder(
                              itemCount: logic.items.length,
                              itemBuilder: (bc, index) => GestureDetector(
                                  onTap: () {
                                    logic.updateItems(logic.items[index]);
                                  },
                                  child: ServiceItem(
                                    nurseService: logic.items[index],
                                    selected:
                                        logic.checkItem(logic.items[index]),
                                  ))),
                        ),
                        Ui.primaryButton(
                            title: AppStrings.continueText,
                            color: logic.selectedItems.isNotEmpty
                                ? AppColors.primaryColor
                                : AppColors.extraGrey,
                            onTab: () {
                              logic.navToTimeSlots();
                            })
                      ],
                    )
                  : NoDataFound(),
            ),
        ],
      ));
    });
  }

  TextStyle customTStyle({double size = 14, isBold = false}) {
    return TextStyle(
        color: AppColors.black.withOpacity(.8),
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontFamily: AppFonts.mainFontFamily);
  }

  Widget exp() {
    return Expanded(
      child: ListView.builder(
          itemCount: logic.depts.length,
          itemBuilder: (bc, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ExpandablePanel(
                  controller: logic.controllers[index],
                  collapsed: Container(),
                  expanded: Container(),
//                           Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     margin: EdgeInsets.symmetric(horizontal: 5),
//                                     height: 250,
//                                   ),
//                                 ],
//                               ),
//                               Positioned(
//                                 bottom: 20,
//                                 child: SizedBox(
//                                   width: Get.width * .85,
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           margin: EdgeInsets.symmetric(
//                                               horizontal: 10),
//                                           height: 250,
//                                           //    width: 100,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               border: Border.all(
//                                                   width: 1.5,
//                                                   color: AppColors
//                                                       .primaryColorGreen)),
//
//                                           child: ListView.builder(
//                                               itemCount:
//                                                   logic.sessions.length,
//                                               padding: EdgeInsets.only(top: 30),
//                                               itemBuilder: (bc, innerIndex) =>
//                                                   GestureDetector(
//
//                                                     onTap: (){
//                                                       logic.updateSessions(logic.sessions[innerIndex]);
//                                                     },
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                           color: AppColors
//                                                               .primaryColorOpacity),
//                                                       margin:
//                                                           EdgeInsets.symmetric(
//                                                               vertical: 10,
//                                                               horizontal: 20),
//                                                       padding:
//                                                           EdgeInsets.symmetric(
//                                                               vertical: 15,
//                                                               horizontal: 0),
//                                                       child: Row(
//                                                         children: [
//
//                                                           UiHelper.horizontalSpaceMedium,
//
//                                                           Container(
//                                                             width: 15,
//                                                             height: 15,
//                                                             decoration: BoxDecoration(
//                                                               shape: BoxShape.circle,
//                                                               border: Border.all(width: 1.5,color: logic.selectedSession==logic.sessions[innerIndex]?AppColors.primaryColorGreen:AppColors.subTitleColor)
//                                                               ,color: logic.selectedSession==logic.sessions[innerIndex]?AppColors.primaryColorGreen:AppColors.primaryColorOpacity
//
//                                                             ),
//                                                           ),
//                                                           UiHelper.horizontalSpaceSmall,
//
//
//                                                           Expanded(
//                                                             child: Text(
//                                                                 logic.sessions[innerIndex].name,style: AppStyles.primaryStyle(bold: true,size: 13),),
//                                                           ),
//                                                           Container(
//                                                             padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
// decoration: BoxDecoration(
//   color: AppColors.primaryColorGreen,
//   borderRadius: BorderRadius.only(
//
//       topLeft: Radius.circular( ar?0: 5),
//
//   bottomLeft: Radius.circular(ar?0:5),
//   bottomRight: Radius.circular(ar?5:0),
//   topRight: Radius.circular(ar?5:0)
//   )
//
//
//
// ),
//
//     child: Text(logic.sessions[innerIndex].price+'  '+AppStrings.currency.tr,style: AppStyles.whiteStyle(bold: true,size: 13),),
//
//                                                           )
//
//
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   )),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
                  header: GestureDetector(
                    onTap: () {
                      logic.updateDept(logic.depts[index], index: index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColorOpacity,
                          borderRadius: BorderRadius.circular(15)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    UiHelper.horizontalSpaceMedium,
                                    Text(
                                      logic.depts[index].name,
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
                                        logic.depts[index].description,
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
                          Ui.hSpace10,
                          Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      logic.depts[index] == logic.selectedDept
                                          ? AppColors.primaryColorGreen
                                          : AppColors.primaryColorOpacity,
                                  border: Border.all(
                                      width: 2,
                                      color: logic.depts[index] ==
                                              logic.selectedDept
                                          ? AppColors.primaryColorGreen
                                          : AppColors.subTitleColor)),
                              child: Icon(
                                Icons.check,
                                size: 20,
                                color: logic.depts[index] == logic.selectedDept
                                    ? AppColors.white
                                    : AppColors.subTitleColor,
                              )),
                          Ui.hSpace10,
                        ],
                      ),
                    ),
                  ),
                  theme: ExpandableThemeData(
                    hasIcon: false,
                  ),
                ),
              )),
    );
  }
}
