import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../global_widgets/form_widgets/reactive_text_form.dart';
import '../../../global_widgets/shared/dynamic_column.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'caregiver_contract_questionnaire_logic.dart';
import 'widgets/question_row.dart';
import 'widgets/questionnaire_form.dart';

class CaregiverContractQuestionnairePage extends StatelessWidget {
  final CaregiverContractQuestionnaireLogic logic = Get.put(CaregiverContractQuestionnaireLogic());


  static const routeName="/CaregiverContractQuestionnairePage";

  CaregiverContractQuestionnairePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.caregiverContractQuestionnaire),
        UiHelper.verticalSpaceMedium,
        Expanded(
          child: SingleChildScrollView(
            child: GetBuilder<CaregiverContractQuestionnaireLogic>(builder: (logic) {
              return QuestionnaireForm();
            }),
          ),
        ),
      ],
    ));
  }
}
