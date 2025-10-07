import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/questionnaire.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../caregiver_contract_questionnaire_logic.dart';

class QuestionRow extends StatelessWidget {
  const QuestionRow(
      {Key? key,
      required this.questionnaire,
      required this.onTab,
      required this.logic})
      : super(key: key);
  final Questionnaire questionnaire;
  final Function onTab;
  final CaregiverContractQuestionnaireLogic logic;

  @override
  Widget build(BuildContext context) {
    var yes = questionnaire.answer != null && questionnaire.answer == true;
    var noChecked =
        questionnaire.answer != null && questionnaire.answer == false;
    return GestureDetector(
      onTap: () {
        // onTab();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: AppColors.primaryColorOpacity),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  Get.locale.toString() == 'ar'
                      ? questionnaire.questionAr
                      : questionnaire.question,
                  style:
                      AppStyles.primaryStyle(bold: true, fontSize: 13, height: 1.5),
                )),
                UiHelper.horizontalSpaceMedium,
              ],
            ),
            UiHelper.verticalSpaceMedium,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      questionnaire.answer = true;
                      logic.update();
                    },
                    child: Row(
                      children: [
                        Text(
                          AppStrings.yes.tr,
                          style: AppStyles.primaryStyleGreen(),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 3.h),
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: yes
                                  ? AppColors.primaryColorGreen
                                  : AppColors.primaryColorOpacity,
                              borderRadius: BorderRadius.circular(5.h),
                              border: Border.all(
                                  width: yes ? 0 : 2.h,
                                  color: AppColors.subTitleColor)),
                          child: yes
                              ? Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 15.w,
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                UiHelper.verticalSpaceMedium,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      questionnaire.answer = false;
                      logic.update();
                    },
                    child: Row(
                      children: [
                        Text(
                          AppStrings.no.tr,
                          style: AppStyles.primaryStyleGreen(),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 3.h),
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: noChecked
                                  ? AppColors.primaryColorGreen
                                  : AppColors.primaryColorOpacity,
                              borderRadius: BorderRadius.circular(5.h),
                              border: Border.all(
                                  width: noChecked ? 0 : 2.h,
                                  color: AppColors.subTitleColor)),
                          child: noChecked
                              ? Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 15.w,
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                UiHelper.verticalSpaceMedium,
//Spacer()

//         Expanded(
//           child: IntrinsicWidth(
//     child: Row(
//     children: [
//
//     Text(AppStrings.other.tr,style: AppStyles.primaryStyleGreen(),),
// UiHelper.horizontalSpaceMedium,
//     Container(
//     padding: EdgeInsets.all(3),
//     width: 20,height: 20,
//     decoration: BoxDecoration(
//     color: !questionnaire.answer?AppColors.primaryColorGreen:AppColors.primaryColorOpacity,
//     borderRadius: BorderRadius.circular(5),
//     border: Border.all(width: !questionnaire.answer?0:2,color: AppColors.subTitleColor)
//
//     ),
//     child:!questionnaire.answer? Icon(Icons.check,color: AppColors.white,size: 15,):Container(),
//     ),
//     ],
//     ),
//     ),
//         ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
