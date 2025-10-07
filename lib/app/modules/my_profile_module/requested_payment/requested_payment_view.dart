import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_list_view/group_list_view.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/ui.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'requested_payment_logic.dart';
import 'widgets/requested_payment_item.dart';

class RequestedPaymentPage extends StatelessWidget {
  final logic = Get.put(RequestedPaymentLogic());

   RequestedPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.requestedPayments),
        Expanded(
          child: GetBuilder<RequestedPaymentLogic>(builder: (logic) {
            return logic.busy
                ? MyLoadingWidget()
                : logic.requests.isNotEmpty
                    ?

            // ListView.builder(
            //             itemCount: logic.requests.length,
            //             itemBuilder: (bc, index) => RequestedPaymentItem(
            //                   requestedPayment: logic.requests[index],
            //                   logic: logic,
            //                 ))

            GroupListView(
              sectionsCount: logic.requestsGroup.length,
              countOfItemInSection: (int section) {
                return logic.requestsGroup[section].requestedPayment.length;
              },
              itemBuilder: (BuildContext context, IndexPath index) {
                return

                  RequestedPaymentItem(
                                      requestedPayment: logic.requestsGroup[index.section].requestedPayment[index.index],

onTab: ()=>logic.onItemTab(logic.requestsGroup[index.section].requestedPayment[index.index]),
                                    )
                ;

              },


              groupHeaderBuilder: (BuildContext context, int section) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: Text(
                   logic. dateConverter(
                       logic.requestsGroup[section].dateTime).tr,
                    style: AppStyles.primaryStyle(bold: false,fontSize: 15),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              sectionSeparatorBuilder: (context, section) => SizedBox(height: 10.h),
            )






                : NoDataFound(
                        animation: AppAnim.noPaymentRequests,
                        msg: AppStrings.noAvailablePaymentRequests,
                      );
          }),
        )
      ],
    ));
  }
}
