import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../global_widgets/shared/my_appbar.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import 'fill_data_logic.dart';
import 'widgets/form_item.dart';

class FillDataPage extends StatelessWidget {
  final FillDataLogic logic = Get.put(FillDataLogic());

  FillDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.fillData),
        Expanded(
          child: GetBuilder<FillDataLogic>(builder: (logic) {
            return ListView.builder(
                itemCount: logic.patients.length,
                itemBuilder: (bc, index) => FormItem(
                      patient: logic.patients[index],
                      logic: logic,
                      key: UniqueKey(),
                    ));
          }),
        ),
        UiHelper.verticalSpaceMedium,
        Ui.primaryButton(
            title: AppStrings.continueTo,
            onTab: () {
              logic.navToNext();

              // DifferentDialog.showCompleteDataDialog();
              //   Get.toNamed(AppRouteNames.patientData);
            })
      ],
    ));
  }
}
