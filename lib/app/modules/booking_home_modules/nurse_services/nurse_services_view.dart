import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_fonts.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/nurse_service.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/globcare_search.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'nurse_services_logic.dart';
import 'widgets/service_item.dart';

class NurseServicesPage extends StatelessWidget {
  final NurseServicesLogic logic = Get.put(NurseServicesLogic());

  final GlobalKey globalKey = GlobalKey();

  NurseServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NurseServicesLogic>(builder: (logic) {
      return Ui.myScaffold(
          child: Column(
        children: [
          myAppBarServices(title:logic.homeService.code=='HHC'? AppStrings.nurseService:logic.homeService.name, code: 'N'),
          if (logic.busy)
            Center(child: MyLoadingWidget())
          else
            Expanded(
              child: logic.items.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobcareSearch(
                          controller: logic,
                        ),
                        UiHelper.verticalSpaceSmall,


                        Expanded(child: SingleChildScrollView(child: Wrap(

                          children: [


                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      priceHint.tr,
                                      style: AppStyles.primaryStyle(
                                        color: AppColors.primaryColorGreen,
                                      ),
                                    )),
                              ],
                            ),
                            UiHelper.verticalSpaceMedium,

                            if(['Car','SM'].contains(logic.homeService.code))
                              Column(children: [

                                UiHelper.verticalSpaceSmall,
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              logic.homeService.code=='Car'?  AppStrings.caregiverServiceDescription.tr :AppStrings.sleepMedicineServiceDescription.tr,
                                              style: AppStyles.primaryStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 13,bold: true
                                              ),
                                            ),
                                            if(logic.homeService.code=='Car')
                                              Text(AppStrings.caregiverFeaturesMsg.tr,
                                                style: AppStyles.primaryStyle(
                                                    color: AppColors.primaryColorGreen,
                                                    fontSize: 14,bold: true
                                                ),
                                              ).paddingSymmetric(vertical: 5.h),
                                          ],
                                        )),
                                  ],
                                ),
                                UiHelper.verticalSpaceMedium,

                              ],),

                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,

                                itemCount: logic.searchList.length,
                                itemBuilder: (bc,index) {

                                  NurseService item=logic.searchList[index];

                                  return  GestureDetector(
                                    onTap: () {
                                      logic.updateItems(item);
                                    },
                                    child: ServiceItem(
                                      nurseService: item ,
                                      selected: logic.checkItem(item),
                                    ));}
                            ),


                          ],
                        ))),


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

  TextStyle customTStyle(
      {double size = 14, isBold = false, Color color = AppColors.black}) {
    return TextStyle(
        color: color.withOpacity(.8),
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontFamily: AppFonts.mainFontFamily);
  }


  String get  priceHint {


    switch(logic.homeService.code){


      case "Car": return AppStrings.priceWithoutVATAndTransportingFee;
      case "SM": return AppStrings.priceWithoutVAT;

      default: return AppStrings.priceWithoutVATAndHVP;

    }


  }

}
