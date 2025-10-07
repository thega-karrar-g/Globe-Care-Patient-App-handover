import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/prescribed_medicine.dart';
import '../../../global_widgets/shared/dynamic_list.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'prescribed_medicine_logic.dart';
import 'widgets/prescribed_medicine_card.dart';

class PrescribedMedicinePage extends StatelessWidget {
  final logic = Get.put(PrescribedMedicineLogic());
  static const routeName = '/PrescribedMedicinePage';

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: GetBuilder<PrescribedMedicineLogic>(builder: (logic) {
          return Column(children: [

            myAppBar2(title: 'Prescribed Medicine',),

            // Row(children: [
            //
            //   Expanded(
            //     child: TabItem(name: AppStrings.today,
            //         selected: logic.medicineStatus == logic.states[0],
            //         fontSize: 13,
            //         onTab: () {
            //           logic.updateMedicineStatus(logic.states[0]);
            //         }),
            //   ),
            //
            //   Expanded(
            //     child: TabItem(name: AppStrings.given,
            //         fontSize: 13,
            //
            //         selected: logic.medicineStatus == logic.states[1],
            //         onTab: () {
            //           logic.updateMedicineStatus(logic.states[1]);
            //         }),
            //   ),
            //
            //   Expanded(
            //     child: TabItem(name: AppStrings.canceled,
            //         fontSize: 13,
            //
            //         selected: logic.medicineStatus == logic.states[2],
            //         onTab: () {
            //           logic.updateMedicineStatus(logic.states[2]);
            //         }),
            //   ),
            //   Expanded(
            //     child: TabItem(name: AppStrings.missed,
            //         fontSize: 13,
            //
            //         selected: logic.medicineStatus == logic.states[3],
            //         onTab: () {
            //           logic.updateMedicineStatus(logic.states[3]);
            //         }),
            //   ),
            //
            //
            // ],),

            Expanded(child: logic.busy?UiHelper.spinKitProgressIndicator():  DynamicListView(
              data: logic.currentMedicines,
             // scrollable: true,

              itemBuilder: (item) =>
                  PrescribedMedicineCard(
                      prescribedMedicine: item as PrescribedMedicine),


            ))


          ],);
        }),

        // floatingAction: FloatingActionButton(
        //   backgroundColor: AppColors.primaryColor,
        //   onPressed: () {},
        //   child: Icon(Icons.add, color: AppColors.white,),
        // )
    );
  }
}
