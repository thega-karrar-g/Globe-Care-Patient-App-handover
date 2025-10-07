import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widgets/shared/dynamic_grid.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../utils/grid_aspect_ratio.dart';
import '../../select_patient/select_patient_view.dart';
import 'medical_file_logic.dart';
import 'widgets/medical_file_item.dart';

class MedicalFilePage extends StatelessWidget {
  final logic = Get.put(MedicalFileLogic());

  MedicalFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
      child: SizedBox(
        // color: AppColors.bodyBgColor.withOpacity(.9),
        child: Column(
          children: [
            myAppBar3(title: AppStrings.medicalFile, withBack: false, h: 20),
            UiHelper.verticalSpaceMassive,
            Row(
              children: [
                Ui.titleGreenUnderLine(AppStrings.selectPatient.tr,
                    bottomPadding: 8),
              ],
            ),

            SelectPatientPage(),
            Expanded(
                child: DynamicGridView(
              data: logic.services,
              count: 2,
              mainSpacing: 50,
              crossSpacing: 15,
              aspectRatio: GridAspectRatio.aspectRatio(count: 2, height: 180.h),
              itemBuilder: (item ) {
                return MedicalFileItem(
                  homeService: item,
                  onTab: (){
                    logic.onTabItem(item);
                  },
                );
              },
            )

                // GridView.builder(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 15.0,
                //     mainAxisSpacing: 35.0,
                //     childAspectRatio: GridAspectRatio.aspectRatio(count: 2,height: 240),
                //   ),
                //   itemCount: logic.services.length,
                //   itemBuilder: (bc,index)=>MedicalFileItem(homeService: logic.services[index],),
                //
                //   padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                //
                //
                //   primary: false,
                //
                // ),

                ),
          ],
        ),
      ),
    );
  }
}
