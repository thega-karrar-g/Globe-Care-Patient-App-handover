import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/loading.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'service_details_logic.dart';

class ServiceDetailsPage extends StatelessWidget {
  final ServiceDetailsLogic logic = Get.put(ServiceDetailsLogic());

  final ar = Get.locale.toString() == 'ar';

  ServiceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
      child: Column(
        children: [
          Expanded(
            child: GetBuilder<ServiceDetailsLogic>(builder: (logic) {
              return Stack(
                children: [
                  if (logic.busy == false && logic.nurseService != null)
                    Column(
                      children: [
                        myAppBarServices(
                            title: AppStrings.serviceDetails,
                            code: ServiceDetailsLogic.serviceCode),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // UiHelper.verticalSpaceSmall,
                                Container(
                                  //  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColorOpacity,
                                      borderRadius:
                                          BorderRadius.circular(15.h)),

                                  child: Column(
                                    children: [
                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w,
                                                              vertical: 5.h),
                                                      decoration: BoxDecoration(
                                                          //   color: AppColors.primaryGreenOpacityColor,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                ar ? 15.h : 0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                ar ? 15.h : 0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                ar ? 0 : 15.h),
                                                        topLeft:
                                                            Radius.circular(
                                                                ar ? 0 : 15.h),
                                                      )),
                                                      child: Image.asset(
                                                        ServiceDetailsLogic
                                                            .icon,
                                                        width: 70.w,
                                                        height: 70.h,
                                                        fit: BoxFit.fitHeight,
                                                      )),
                                                ),
                                              ],
                                            ),

                                            UiHelper.horizontalSpaceSmall,
                                            Expanded(
                                                child: Text(
                                              ar
                                                  ? logic.nurseService!.nameAr
                                                  : logic.nurseService!.name,
                                              textAlign: TextAlign.start,
                                              style: AppStyles.primaryStyle(
                                                  fontSize: 13,
                                                  bold: true,
                                                  height: 1.5),
                                            )),
                                            UiHelper.horizontalSpaceMedium,



if(logic.showPrice())
  Container(
                                          padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 10.w),
                                          decoration: BoxDecoration(color: AppColors.primaryColorGreen,

                                              borderRadius: BorderRadius.only(

                                                topLeft: Radius.circular(ar?0:10.h),
                                                bottomLeft: Radius.circular(ar?0:10.h),


                                                bottomRight: Radius.circular(ar?10.h:0),
                                                topRight: Radius.circular(ar?10.h:0),



                                              )
                                          ),
                                          child: Text(logic.nurseService!.price+'   '+AppStrings.currency.tr,style: AppStyles.whiteStyle(bold: true),),

                                        )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                if(logic.showPrice())
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Text(
                                        AppStrings.priceWithoutVATAndHVP.tr,
                                        style: AppStyles.primaryStyle(
                                          color: AppColors.primaryColorGreen,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                UiHelper.verticalSpaceSmall,

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Ui.titleGreenUnderLine(
                                        AppStrings.serviceDescription.tr,
                                        bottomPadding: 0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 10.h),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 10.h),
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColorOpacity,
                                          borderRadius:
                                              BorderRadius.circular(15.h)),
                                      child: Column(
                                        children: [
                                          Ui.vSpace10,
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                ar
                                                    ? logic.nurseService!
                                                        .descriptionAr
                                                    : logic.nurseService!
                                                        .description,
                                                textAlign: TextAlign.start,
                                                style: AppStyles.primaryStyle(
                                                    fontSize: 15,
                                                    opacity: .7,
                                                    height: 1.5),
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    UiHelper.verticalSpaceMedium,
                                    Ui.titleGreenUnderLine(
                                        AppStrings.moreDetails.tr,
                                        bottomPadding: 0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 15.h),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 10.h),
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColorOpacity,
                                          borderRadius:
                                              BorderRadius.circular(15.h)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                ar
                                                    ? logic.nurseService!
                                                        .instructionsAr
                                                    : logic.nurseService!
                                                        .instructions,
                                                textAlign: TextAlign.start,
                                                style: AppStyles.primaryStyle(
                                                    fontSize: 15,
                                                    opacity: .7,
                                                    height: 1.5),
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                UiHelper.verticalSpaceLarge,
                              ],
                            ),
                          ),
                        ),
                        UiHelper.verticalSpaceMedium,
                        Ui.primaryButton(
                            title: AppStrings.continueTo,
                            onTab: () {
                              logic.navToNext();
                            })
                      ],
                    ),
                  // if(logic.busy==false&&logic.nurseService==null) Center(child: NoDataFound(),)
                  // ,

                  if (logic.busy && logic.nurseService == null)
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: MyLoadingWidget(),
                      ),
                    ))
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
