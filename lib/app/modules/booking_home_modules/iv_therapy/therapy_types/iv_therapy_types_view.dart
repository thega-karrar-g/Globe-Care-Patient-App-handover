import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globcare/app/modules/appointment/appointment_types_logic.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/models/home_service.dart';
import '../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../global_widgets/shared/my_appbar.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../appointment/widgets/appointment_type_item.dart';

class IVTherapyTypesPage extends StatelessWidget {
  IVTherapyTypesPage({Key? key}) : super(key: key);

  static const routeName='/IVTherapy';

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
      child: Column(
        children: [
          myAppBar2(title: AppStrings.ivAntibioticVitamin, h: 20),
          UiHelper.verticalSpaceSmall,
          Expanded(
              child: SingleChildScrollView(
                  child: DynamicColumn(
            children: HomeService.ivTherapyTypes
                .map((e) => AppointmentTypeItem(
                      homeService: e,
              onTab:()=> Get.find<AppointmentTypesLogic>().onAppointmentTypeTab(e),
                    ))
                .toList(),
          )))
        ],
      ),
    );
  }
}
