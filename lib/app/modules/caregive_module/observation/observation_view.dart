import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/observation.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../global_widgets/ui.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'observation_logic.dart';
import 'widgets/observation_card.dart';

class ObservationPage extends StatelessWidget {
  final logic = Get.put(ObservationLogic());
  static const routeName = '/ObservationPage';

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(children: [

          myAppBar2(title: AppStrings.observation,),

          Expanded(child:


          GetBuilder<ObservationLogic>(builder: (logic) {
            return

             logic.busy? MyLoadingWidget(): logic.observations.isNotEmpty? DynamicListView(
              data: logic.observations,
              itemBuilder: (item) =>
                  ObservationCard(observation: item as Observation),


            ):NoDataFound(
               animation: AppAnim.search,
               msg: AppStrings.noDataFound,
             );
          }))


        ],),

        // floatingAction: FloatingActionButton(
        //   backgroundColor: AppColors.primaryColor,
        //   onPressed: () {
        //     Get.toNamed(AddObservationPage.routeName);
        //   },
        //   child: Icon(Icons.add, color: AppColors.white,),
        // )
    );
  }
}
