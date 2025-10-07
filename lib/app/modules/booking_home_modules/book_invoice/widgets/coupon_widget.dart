import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/action_buttons/action_button.dart';
import 'package:globcare/app/modules/booking_home_modules/book_invoice/book_invoice_logic.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/different_dialogs.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../qr_scanner/qr_scanner_logic.dart';

class CouponWidget extends StatelessWidget {
   CouponWidget({Key? key,required this.logic}) : super(key: key);
  final BookInvoiceLogic logic;
  final FocusNode _focusNode =
  FocusNode(); //1 - declare and initialize variable

 final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.h)),
    borderSide: BorderSide(color: AppColors.registerFiled),

  );
  final double paddingHeight = 25.0.h;
  final labelStyle = TextStyle(
      color: AppColors.subTitleColor,
      fontWeight: FontWeight.bold,
      fontSize: 13.sp);

  @override
  Widget build(BuildContext context) {
    return                                 Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(
          vertical: 5.h, horizontal: 10.w),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(.9),
          borderRadius:
          BorderRadius.circular(10.h)),
      child: Column(
        children: [
          UiHelper.verticalSpaceSmall,

          Text(
            AppStrings.scanCodeDiscountMsg.tr,
            style: AppStyles.primaryStyle(
                bold: false, fontSize: 11, height: 1.2,color: AppColors.white),
          ),

             UiHelper.verticalSpaceSmall,

          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  textInputAction:
                  TextInputAction.newline,
                  keyboardType:
                  TextInputType.multiline,
                  // maxLines: null,
                  focusNode: _focusNode,
                  obscureText: true,
                  obscuringCharacter: '*',
                  style: AppStyles.primaryStyle(
                      color:
                      AppColors.white),
                  controller: QrScannerLogic.qrCtrl,
                  decoration: InputDecoration(
                    //  labelText: lable.tr,

                    labelStyle:
                    AppStyles.primaryStyle(
                        bold: true,color: AppColors.white),
                    filled: true,
                    fillColor: AppColors
                        .primaryColorOpacity,
                    contentPadding:
                    EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 15.h),
                    hintText:
                    AppStrings.enterCode.tr,
                    errorStyle: TextStyle(
                        color: Colors.white
                            .withOpacity(0.7)),
                    errorBorder: outlineInputBorder,
                    hintStyle:
                    AppStyles.primaryStyle(
                      bold: true,
                      color: AppColors.white

                    ),
                    border: outlineInputBorder,
                    focusedBorder:
                    outlineInputBorder,
                    enabledBorder:
                    outlineInputBorder,
                    suffixIcon: GestureDetector(

                      onTap: (){

                        DifferentDialog
                            .showScanQRDialog();
                      },
                      child: Icon(Icons.qr_code,size: 50.sp,color: AppColors.white,),
                    ),

                  ),
                ),
              ),
              UiHelper.horizontalSpaceMedium,
              Expanded(
                child: Ui.primaryButton(
                    title: AppStrings.verify,
                    fontSize: 15,
                    radius: 5,
                    paddingV: 13,
                    paddingH: 5,
                    marginV: 10,
                    color: AppColors.primaryColorGreen,
                    onTab: () {

                      logic.checkCoupon();
                    }),
              ),


              UiHelper.horizontalSpaceSmall,



            ],
          ),

          // UiHelper.verticalSpaceSmall,
          // Row(
          //   children: [
          //     Expanded(
          //         child: Text(
          //           AppStrings.discountWithoutVAT.tr,
          //           style: AppStyles.primaryStyle(
          //             color: AppColors.white,
          //             fontSize: 11
          //           ),
          //         )),
          //   ],
          // ),
          UiHelper.verticalSpaceSmall,
        ],
      ),
    )
    ;
  }
}
