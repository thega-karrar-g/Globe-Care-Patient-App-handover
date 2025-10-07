import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../global_widgets/shared/loading.dart';
import '../../../../global_widgets/shared/my_appbar.dart';
import '../../../../global_widgets/shared/no_data.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../routes/app_route_names.dart';
import '../../../../core/assets_helper/app_anim.dart';
import 'instant_consultation_home_logic.dart';
import 'widgets/select_patient.dart';

class InstantConsultationHomePage extends StatelessWidget {
  final logic = Get.put(InstantConsultationHomeLogic());

  static const routeName = '/SelectPatientPage';

  InstantConsultationHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: GetBuilder<InstantConsultationHomeLogic>(builder: (logic) {
      return Column(
        children: [
          myAppBar2(title: AppStrings.instantConsultation,onBack: (){
            Get.offAllNamed(AppRouteNames.homeTabs);

          }),
          if (logic.noInternetConnection())
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  NoDataFound(
                    animation: AppAnim.noInternet,
                    msg: AppStrings.checkInternet,
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [


                    if (logic.busy) MyLoadingWidget() else SelectPatient()
                  ],
                ),
              ),
            )
        ],
      );
    }));
  }
}
