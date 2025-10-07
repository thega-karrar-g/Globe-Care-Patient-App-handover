import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/caregiver_contract_model.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../utils/download_controller.dart';
import 'caregiver_contract_requests_controller.dart';
import 'widgets/caregiver_contract_request_item.dart';

class CaregiverContractRequestsPage extends StatelessWidget {
  final controller = Get.put(CaregiverContractRequestsController());
  final download = Get.put(DownloadController());

   CaregiverContractRequestsPage({super.key});
  static const routeName="/CaregiverContractRequestsPage";
  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(

        child: Column(children: [

          myAppBar2(title: AppStrings.caregiverContractsRequests,),

          UiHelper.verticalSpaceMedium,


          Expanded(child: GetBuilder<CaregiverContractRequestsController>(builder: (controller) {
            return controller.busy ?UiHelper.spinKitProgressIndicator(): DynamicListView(data:controller.caregiverContractRequests,itemBuilder: (item){
              return CaregiverContractRequestItem(caregiverContract: item as CaregiverContractModel,);
            },);
          }))


        ],)

    );
  }
}
