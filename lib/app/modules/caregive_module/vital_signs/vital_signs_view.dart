import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/vital_signs.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/ui.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'vital_signs_logic.dart';

import 'widgets/vital_signs_card.dart';

class VitalSignsPage extends StatelessWidget {
  final logic = Get.put(VitalSignsLogic());

  static const routeName = '/VitalSignsPage';

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(children: [

          myAppBar2(title: 'Vital Signs',),

          Expanded(child:


          GetBuilder<VitalSignsLogic>(builder: (logic) {
            return


             logic.busy?MyLoadingWidget():


            logic.vitalSigns.isNotEmpty? DynamicListView(
              data: logic.vitalSigns,
              //scrollable: true,
              itemBuilder: (item) =>
                  VitalSignsCard(vitalSigns: item as VitalSigns),


            ):NoDataFound(
              animation: AppAnim.search,
              msg: AppStrings.noDataFound,
            );
          }))


        ],),

        // floatingAction: FloatingActionButton(
        //   backgroundColor: AppColors.primaryColor,
        //   onPressed: () {
        //     Get.bottomSheet(
        //         VitalSignBottomSheet(),
        //         isScrollControlled: true,
        //         backgroundColor: AppColors.white,
        //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
        //             topRight: Radius.circular(10),
        //             topLeft: Radius.circular(10)))
        //
        //     );
        //
        //
        //     //  final LocalNotificationService _localNotification =
        //     //      LocalNotificationService.instance;
        //     // // _localNotification.initializing();
        //     //
        //     // // NotificationService().showNotificationSchedule(1, 'title   hi', 'body  Mr waleed', );
        //     //  _localNotification.showNotificationSchedule(1, 'title   hi', 'body  Mr waleed',dateTime: DateTime.now().add(Duration(minutes: 1)) );
        //
        //   },
        //   child: Icon(Icons.add, color: AppColors.white,),
        // )
    );
  }
}
