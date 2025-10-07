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
import 'sleep_questionnaire_logic.dart';
import 'widgets/question_row.dart';
import 'widgets/questionnaire_form.dart';

class SleepQuestionnairePage extends StatelessWidget {
  final SleepQuestionnaireLogic logic = Get.put(SleepQuestionnaireLogic());
  final double paddingHeight = 25.0;
  final labelStyle = TextStyle(
      color: AppColors.subTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 13);
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: AppColors.subTitleColor),
  );

  final TextStyle style =
      (TextStyle(color: AppColors.white));

  SleepQuestionnairePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.sleepQuestionnaire),
        UiHelper.verticalSpaceMedium,
        Expanded(
          child: SingleChildScrollView(
            child: GetBuilder<SleepQuestionnaireLogic>(builder: (logic) {
              return QuestionnaireForm();
            }),
          ),
        ),
      ],
    ));
  }
}
