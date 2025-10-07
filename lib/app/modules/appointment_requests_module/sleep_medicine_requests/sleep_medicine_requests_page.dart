import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/sleep_medicine_model.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'sleep_medicine_requests_controller.dart';
import 'widgets/sleep_medicine_request_item.dart';

class SleepMedicineRequestsPage extends StatelessWidget {
  final controller = Get.put(SleepMedicineRequestsController());

  static const routeName="/SleepMedicineRequestsPage";
  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(

        child: Column(children: [

          myAppBar2(title: AppStrings.sleepMedicineRequests,),

          UiHelper.verticalSpaceMedium,


          Expanded(child: GetBuilder<SleepMedicineRequestsController>(builder: (controller) {
            return controller.busy ?UiHelper.spinKitProgressIndicator(): DynamicListView(data:controller.sleepMedicineRequests,itemBuilder: (item){
              return SleepMedicineRequestItem(sleepMedicineModel: item as SleepMedicineModel,);
            },);
          }))


        ],)

    );
  }
}
