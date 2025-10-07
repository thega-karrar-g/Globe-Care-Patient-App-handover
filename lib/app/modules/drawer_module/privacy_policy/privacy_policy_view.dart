import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/data/api/app_urls.dart';
import 'package:globcare/app/utils/launcher.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../global_widgets/shared/dynamic_column.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'privacy_policy_logic.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final PrivacyPolicyLogic logic = Get.put(PrivacyPolicyLogic());

  PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: GetBuilder<PrivacyPolicyLogic>(builder: (logic) {
      return Stack(
        children: [
          Column(
            children: [
              myAppBar2(title: AppStrings.privacyPolicy),

              Expanded(
                  child: SingleChildScrollView(
                child: DynamicColumn(
                  children: [
                    Text(
                      PrivacyPolicyLogic.termsOfServicesText.tr,
                      textAlign: TextAlign.justify,
                      style: AppStyles.primaryStyle(
                          fontSize: 16, opacity: .8, height: 1.5),
                    ),
                    UiHelper.verticalSpaceLarge,
                    GestureDetector(
                      onTap: (){
                        Launcher.launchInBrowser(AppUrls.privacyPolicy);
                      },
                      child: Text(AppStrings.moreDetails.tr,style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,

                        decoration: TextDecoration.underline,
                        color: AppColors.primaryColor,
                        decorationColor: AppColors.primaryColor.withValues(alpha: .7)
                      ),),
                    ),
                    UiHelper.verticalSpaceLarge,


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
