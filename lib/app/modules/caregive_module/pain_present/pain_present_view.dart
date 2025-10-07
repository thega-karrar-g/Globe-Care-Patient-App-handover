import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/pain_present.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/ui.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'pain_present_logic.dart';
import 'widgets/pain_present_card.dart';


class PainPresentPage extends StatelessWidget {
  final logic = Get.put(PainPresentLogic());
  static const routeName = '/PainPresentPage';

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(children: [

          myAppBar2(title: 'Pain Present',),

          Expanded(child: GetBuilder<PainPresentLogic>(builder: (logic) {
            return

              logic.busy? MyLoadingWidget() :


             logic.pains.isNotEmpty? DynamicListView(
             //  scrollable: true,
              data: logic.pains,
              itemBuilder: (item) =>
                  PainPresentCard(painPresent: item as PainPresent),


            ):NoDataFound(
               animation: AppAnim.search,
               msg: AppStrings.noDataFound,
             );
          }))


        ],),

      //   floatingAction: FloatingActionButton(
      //     backgroundColor: AppColors.primaryColor,
      //     onPressed: () {
      //     Get.bottomSheet(
      //           PainPresentBottomSheet(),
      //
      //           isScrollControlled: true,
      //           backgroundColor: AppColors.white,
      //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
      //               topRight: Radius.circular(10),
      //               topLeft: Radius.circular(10)))
      //
      //       );
      //
      // // print(id);
      //     },
      //     child: Icon(Icons.add, color: AppColors.white,),
      //   )
    );
  }
}
