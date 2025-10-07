import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../data/constants/booking_constants.dart';
import '../../../../../data/eunums/enums.dart';
import '../../../../../data/models/nurse_service.dart';
import '../../../../../global_widgets/shared/different_dialogs.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../../routes/app_route_names.dart';
import '../../../patient_data/patient_data_logic.dart';
import '../../../radiology_lab/radiology_lab_services/radiology_lab_services_logic.dart';

class PCRItem extends StatelessWidget {
  PCRItem({Key? key, this.pcrModel, this.selected = false, required this.logic})
      : super(key: key);

  final RadiologyLabServicesLogic logic;

  NurseService? pcrModel;
  bool selected;
  bool ar = Get.locale.toString() == 'ar';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BookingConstants.price = double.parse(pcrModel!.price) * pcrModel!.quantity;
        BookingConstants.appointmentType = '-pcr';

        BookingConstants.service = pcrModel!;
        PatientDataLogic.chooseDateType = ChooseDateType.pcr;

        Get.toNamed(AppRouteNames.fillData, arguments: pcrModel!.quantity);
      },
      child: Container(
        height: 120.h,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.h),
          color: AppColors.primaryColorOpacity,
        ),
        child: Row(
          children: [
            UiHelper.horizontalSpaceSmall,
            Expanded(
              child: Column(
                children: [
                  UiHelper.verticalSpaceSmall,
                  Row(
                    children: [
                      UiHelper.horizontalSpaceSmall,
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text.rich(TextSpan(
                          text: ar ? pcrModel!.nameAr : '${pcrModel!.name} ',
                          style: AppStyles.primaryStyle(bold: true, fontSize: 12),
                        )),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        UiHelper.horizontalSpaceSmall,
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              ar
                                  ? pcrModel!.descriptionAr
                                  : pcrModel!.description,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.subTitleStyle(
                                size: 11,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColorGreen,
                                      borderRadius: BorderRadius.circular(5.h)),
                                )),
                              ],
                            )
                          ],
                        )),
                        Column(
                          children: [
                            SizedBox(
                              width: 100.w,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 10.w),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryGreenOpacityColor,
                                  borderRadius: BorderRadius.circular(5.h)),
                              child: Row(
                                children: [
                                  Text(
                                    '${(double.parse(pcrModel!.price) *
                                                pcrModel!.quantity)
                                            .toStringAsFixed(0)}    ${AppStrings.currency.tr}',
                                    style: AppStyles.primaryStyle(
                                        bold: true, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColorGreen
                                      .withOpacity(.7),
                                  borderRadius: BorderRadius.circular(8.h)),
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        logic.updateItemsSub(pcrModel!);
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: AppColors.white.withOpacity(.9),
                                        size: 20.w,
                                      )),
                                  UiHelper.horizontalSpace(5),
                                  Container(
                                      height: 25.h,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColorGreen),
                                      child: Text(
                                        '${pcrModel!.quantity}',
                                        style: AppStyles.whiteStyle(bold: true),
                                      )),
                                  UiHelper.horizontalSpace(5),
                                  GestureDetector(
                                      onTap: () {
                                        logic.updateItemsAdd(pcrModel!);
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.white.withOpacity(.9),
                                        size: 20.w,
                                      )),
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                DifferentDialog.nurseBottomSheet(
                                    serviceName:
                                        ar ? pcrModel!.nameAr : pcrModel!.name,
                                    desc: ar
                                        ? pcrModel!.descriptionAr
                                        : pcrModel!.description,
                                    instructions: ar
                                        ? pcrModel!.instructionsAr
                                        : pcrModel!.instructions);
                              },
                              child: Container(
                                height: 35.h,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(ar ? 0 : 15.h),
                                      topLeft: Radius.circular(ar ? 0 : 15.h),
                                      topRight: Radius.circular(ar ? 15.h : 0),
                                      bottomLeft:
                                          Radius.circular(ar ? 15.h : 0),
                                    )),
                                child: Text(
                                  AppStrings.showMore.tr,
                                  style: AppStyles.whiteStyle(
                                      bold: true, size: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
