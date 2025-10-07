import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../auth/widgets/reactive_login_form.dart';
import '../../../auth/widgets/reactive_register_form.dart';
import '../book_invoice_logic.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key,required this.logic}) : super(key: key);
final BookInvoiceLogic logic;
  @override
  Widget build(BuildContext context) {
    return                         Column(
      children: [
        Ui.primaryButton(
            title: AppStrings.logIn,
            onTab: () {
              BookingConstants.fromPatientData = true;

              Get.bottomSheet(
                  Padding(
                    padding: UiHelper.safeAreaPadding,
                    child: SizedBox(
                        height: (Get.height * .7).h,
                        child: ReactiveLoginForm(
                          title: AppStrings.logIn,
                        )),
                  ),
                  backgroundColor: AppColors.white,
                  isScrollControlled: true,
                  enterBottomSheetDuration:
                  Duration(milliseconds: 750),
                  exitBottomSheetDuration:
                  Duration(milliseconds: 750),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight:
                          Radius.circular(10.h),
                          topLeft:
                          Radius.circular(10.h))))
                  .then((value) {
                logic.update();
              });
            }),
        SizedBox(
          height: 16.h,
        ),
        Row(
          children: [
            Expanded(
                child: Divider(
                  color: AppColors.subTitleColor,
                )),
            UiHelper.horizontalSpaceMedium,
            Text(
              AppStrings.or.tr,
              style: AppStyles.primaryStyle(bold: true),
            ),
            UiHelper.horizontalSpaceMedium,
            Expanded(
                child: Divider(
                  color: AppColors.subTitleColor,
                )),
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                BookingConstants.fromPatientData = true;

                Get.bottomSheet(
                    Padding(
                      padding: UiHelper.safeAreaPadding,
                      child: SizedBox(
                          height: (Get.height * .8).h,
                          child:
                          ReactiveRegisterForm()),
                    ),
                    backgroundColor: AppColors.white,
                    isScrollControlled: true,
                    enterBottomSheetDuration:
                    Duration(milliseconds: 750),
                    exitBottomSheetDuration:
                    Duration(milliseconds: 750),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight:
                            Radius.circular(10.h),
                            topLeft:
                            Radius.circular(10.h))))
                    .then((value) {
                  logic.update();
                });

                //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
              },
              child: Text(
                AppStrings.register.tr,
                style: AppStyles.primaryStyle(
                    bold: true, fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    )
    ;
  }
}
