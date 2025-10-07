import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_fonts.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/project_widget/loading_widget.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'insurance_logic.dart';

class InsurancePage extends StatelessWidget {
  final InsuranceLogic logic = Get.put(InsuranceLogic());

  InsurancePage({Key? key}) : super(key: key);

  bool ar = Get.locale.toString() == 'ar';

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(child: GetBuilder<InsuranceLogic>(builder: (logic) {
      return Column(
        children: [
          myAppBar2(title: AppStrings.insuranceCompanies),
          logic.busy
              ? MyLoadingWidget()
              : Expanded(
                  child: logic.items.isNotEmpty
                      ? Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ListView.builder(
                                      itemCount: logic.items.length,
                                      itemBuilder:
                                          (bc, index) => GestureDetector(
                                                child: Container(
                                                  height: 100,
                                                  color: AppColors.white,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 5),
                                                  child: Stack(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 50,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      Expanded(
                                                                          child:
                                                                              Text(
                                                                        logic
                                                                            .items[index]
                                                                            .name,
                                                                        style: AppStyles.primaryStyle(
                                                                            bold:
                                                                                true,
                                                                            fontSize:
                                                                                14),
                                                                      )),
                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: logic.items[index] == logic.selectedCompany ? AppColors.primaryColorGreen : AppColors.white,
                                                                              border: Border.all(color: logic.items[index] == logic.selectedCompany ? AppColors.primaryColorGreen : AppColors.subTitleColor)),
                                                                          child: Icon(Icons.check, color: AppColors.white)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  color: logic.items[
                                                                              index] ==
                                                                          logic
                                                                              .selectedCompany
                                                                      ? AppColors
                                                                          .primaryColorGreen
                                                                      : AppColors
                                                                          .subTitleColor,
                                                                  thickness: 2,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Positioned.fill(
                                                        left: 0,
                                                        bottom: 0,
                                                        child: Align(
                                                          alignment: ar
                                                              ? Alignment
                                                                  .centerRight
                                                              : Alignment
                                                                  .centerLeft,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: logic.items[index] ==
                                                                            logic
                                                                                .selectedCompany
                                                                        ? AppColors
                                                                            .primaryColorGreen
                                                                        : AppColors
                                                                            .subTitleColor,
                                                                    width: 2),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Ui
                                                                .circularImgRadiusBase64(
                                                                    url: logic
                                                                        .items[
                                                                            index]
                                                                        .image,
                                                                    size: 65,
                                                                    margin: 0,
                                                                    rBL: 30,
                                                                    rBR: 30,
                                                                    rTL: 30,
                                                                    rTR: 30),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  logic.updateCompany(
                                                      logic.items[index]);
                                                },
                                              )),
                                  if (logic.busy)
                                    Positioned.fill(
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: LoadingWidget())),
                                ],
                              ),
                            ),
                            Ui.primaryButton(
                                title: AppStrings.send,
                                radius: 15,
                                marginH: 0,
                                color: logic.selectedCompany != null
                                    ? AppColors.primaryColorGreen
                                    : AppColors.extraGrey,
                                onTab: () {
                                  //Get.toNamed(AppRouteNames.termsOfService);

                                  logic.makeBookingWithFileDio();
                                }),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              UiHelper.verticalSpaceLarge,
                              Image.asset(
                                AppImages.comingSoon,
                                width: 200,
                                height: 200,
                              ),
                              UiHelper.verticalSpaceMedium,
                              Text(
                                AppStrings.oops.tr,
                                style: AppStyles.primaryStyle(
                                    fontSize: 25, bold: true),
                              ),
                              UiHelper.verticalSpaceMedium,
                              Text(
                                AppStrings.insuranceSoon.tr,
                                textAlign: TextAlign.center,
                                style: AppStyles.primaryStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    bold: false,
                                    opacity: .8),
                              ),
                            ],
                          ),
                        ),
                )
        ],
      );
    }));
  }

  TextStyle customTStyle({double size = 14, isBold = false}) {
    return TextStyle(
        color: AppColors.black.withOpacity(.8),
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontFamily: AppFonts.mainFontFamily);
  }
}
