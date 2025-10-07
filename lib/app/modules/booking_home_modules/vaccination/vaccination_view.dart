import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_fonts.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/nurse_service.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../nurse_services/widgets/service_item.dart';
import 'vaccination_logic.dart';

class VaccinationPage extends StatelessWidget {
  final VaccinationLogic logic = Get.put(VaccinationLogic());

  final GlobalKey globalKey = GlobalKey();

  VaccinationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VaccinationLogic>(builder: (logic) {
      return Ui.myScaffold(
          child: Column(
        children: [
          myAppBar2(title: AppStrings.vaccination),
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
                          child: DynamicListView(
                              key: globalKey,
                              data: logic.items,
                              itemBuilder: (item) => GestureDetector(
                                  onTap: () {
                                    logic.updateItems(item as NurseService);
                                  },
                                  child: ServiceItem(
                                    nurseService: item as NurseService,
                                    selected: logic.checkItem(item),
                                    key: UniqueKey(),
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

  TextStyle customTStyle(
      {double size = 14, isBold = false, Color color = AppColors.black}) {
    return TextStyle(
        color: color.withOpacity(.8),
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontFamily: AppFonts.mainFontFamily);
  }
}
