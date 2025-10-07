import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/refund_request_model.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'refund_cancel_request_controller.dart';
import 'widgets/refund_request_item.dart';

class RefundCancelRequestPage extends StatelessWidget {
  final controller = Get.put(RefundCancelRequestController());

   RefundCancelRequestPage({super.key});
  static const routeName="/RefundCancelRequestPage";

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(

        child: Column(children: [

          myAppBar2(title: AppStrings.refundCancelRequests,),

          UiHelper.verticalSpaceMedium,


          Expanded(child: GetBuilder<RefundCancelRequestController>(builder: (controller) {
            return controller.busy ?UiHelper.spinKitProgressIndicator(): DynamicListView(data:controller.refundRequests,itemBuilder: (item){
              return RefundRequestItem(refundRequestModel: item as RefundRequestModel,);
            },);
          }))


        ],)

    );
  }

}
