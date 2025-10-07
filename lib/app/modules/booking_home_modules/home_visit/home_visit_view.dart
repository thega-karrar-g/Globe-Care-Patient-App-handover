import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/ui.dart';
import 'home_visit_item.dart';
import 'home_visit_logic.dart';

class HomeVisitPage extends StatelessWidget {
  final HomeVisitLogic logic = Get.put(HomeVisitLogic());

  HomeVisitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.homeVisitDoctor),
        Expanded(
          child: ListView.builder(
              itemCount: logic.homeVisitServices.length,
              itemBuilder: (bc, index) => HomeVisitItem(
                    homeService: logic.homeVisitServices[index],
                  )),
        )
      ],
    ));
  }
}
