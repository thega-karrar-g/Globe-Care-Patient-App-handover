import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../global_widgets/shared/dynamic_column.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'terms_of_services_logic.dart';

class TermsOfServicesPage extends StatelessWidget {
  final TermsOfServicesLogic logic = Get.put(TermsOfServicesLogic());

  TermsOfServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: GetBuilder<TermsOfServicesLogic>(builder: (logic) {
      return Stack(
        children: [
          Column(
            children: [
              myAppBar2(
                title: AppStrings.termsAndConditions,
              ),

              Expanded(
                  child: SingleChildScrollView(
                child: DynamicColumn(
                  children: [
                    Text(
                      TermsOfServicesLogic.termsOfServicesText.tr,
                      style: AppStyles.primaryStyle(
                          fontSize: 16, opacity: .8, height: 1.5),
                    ),
                  ],
                ),
              )),

              UiHelper.verticalSpaceLarge,

              // if(logic.showCheckBox)        Column(
              //           children: [
              //             RowCheck(title:AppStrings.agree.tr ,checked:logic.agree ,onTab: (){logic.updateAgree(!logic.agree);},),
              //
              //       UiHelper.verticalSpaceSmall,
              //           //  RowCheck(title:AppStrings.responsibility.tr ,checked:logic.responsibility ,onTab: (){logic.updateResponsibility(!logic.responsibility);},),
              //             //
              //             // UiHelper.verticalSpaceLarge,
              //
              //             Ui.primaryButton(title:  PatientDataLogic.paymentType=='insurance'? AppStrings.send:AppStrings.bookNow,color: logic.agree?AppColors.primaryColorGreen:AppColors.subTitleColor,onTab: (){
              //
              //             if(logic.agree) {
              //               logic.makeBookingWithFileDio();
              //             }
              //             else{
              //               logic.buildFailedSnackBar(msg: 'You should agree and  responsible to terms of services');
              //             }
              //
              //             }),
              //           ],
              //         )
            ],
          ),
          if (logic.busy)
            Positioned.fill(
                // top: Get.height*.1,

                //   right: Get.width*.5,
                child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [DifferentDialog.loadingDialog()],
              ),
            ))
        ],
      );
    }));
  }
}
