import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../data/models/requested_payment.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../routes/app_route_names.dart';
import '../requested_payment_logic.dart';

class RequestedPaymentItem extends StatelessWidget {
  RequestedPaymentItem({Key? key, this.requestedPayment, required this.onTab})
      : super(key: key);

  final RequestedPayment? requestedPayment;
  final double h = 80.h;
  final ar = Get.locale.toString() == 'ar';
final Function onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTab();

      },
      child: Container(
        height: h,
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
        decoration: BoxDecoration(
            color: AppColors.primaryColorOpacity,
            borderRadius: BorderRadius.circular(10.h)),
        child: Row(
          children: [
            UiHelper.horizontalSpaceSmall,
            Image.asset(
              AppImages.iconRequestedPayment, height: h, width: 50.w,
              // color: AppColors.primaryColorGreen,
            ),
            UiHelper.horizontalSpaceSmall,
            Expanded(
                child: Column(
              children: [
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      requestedPayment!.name.tr,
                      style: AppStyles.primaryStyle(bold: true, fontSize: 13),
                    )),
                  ],
                ),
                UiHelper.verticalSpaceSmall,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppImages.calendar,
                              color: AppColors.primaryColorGreen,
                              width: 16.w,
                              height: 16.w,
                            ),
                            UiHelper.horizontalSpace(3),
                            Expanded(
                                child: Text(
                              DateFormat(
                                      'dd  MMM yyyy', Get.locale!.languageCode)
                                  .format(requestedPayment!.date!),
                              maxLines: 2,
                              style: AppStyles.primaryStyle(
                                  bold: true, fontSize: 11, opacity: .7),
                            )),
                          ],
                        ),
                      ),
                      UiHelper.horizontalSpaceSmall,
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              color: AppColors.primaryColorGreen,
                              size: 16.w,
                            ),
                            UiHelper.horizontalSpace(3),
                            Expanded(
                              child: Text(
                                ' ${requestedPayment!.paymentAmount} ${AppStrings.currency.tr}',
                                maxLines: 2,
                                style: AppStyles.primaryStyle(
                                    bold: true, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
            UiHelper.horizontalSpaceSmall,
            if ( ["done","paid"].contains( requestedPayment!.state.toLowerCase() ))
              Container(
                padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                decoration: BoxDecoration(
                    color: AppColors.subTitleColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ar ? 0 : 10.h),
                      bottomLeft: Radius.circular(ar ? 0 : 10.h),
                      bottomRight: Radius.circular(ar ? 10.h : 0),
                      topRight: Radius.circular(ar ? 10.h : 0),
                    )),
                child: Text(
                  AppStrings.paid.tr,
                  style: AppStyles.whiteStyle(bold: true),
                ),
              )
            else
              Container(
                alignment: Alignment.center,
                width: 30.w,
                height: h,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(ar ? 0 : 10.h),
                      bottomRight: Radius.circular(ar ? 0 : 10.h),
                      topLeft: Radius.circular(ar ? 10.h : 0),
                      bottomLeft: Radius.circular(ar ? 10.h : 0),
                    )),
                child: CircleAvatar(
                  radius: 10.h,
                  backgroundColor: AppColors.white,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15.w,
                    color: AppColors.primaryColor,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
