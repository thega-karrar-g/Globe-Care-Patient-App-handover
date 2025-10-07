import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../global_widgets/project_widget/price_item.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import 'book_invoice_logic.dart';
import 'widgets/checkout_card_widget.dart';
import 'widgets/coupon_widget.dart';
import 'widgets/login_widget.dart';

class BookInvoicePage extends StatelessWidget {
  final BookInvoiceLogic logic = Get.put(BookInvoiceLogic());

  BookInvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ar = Get.locale.toString() == 'ar';


    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.bookingDetails),
        Expanded(
          child: GetBuilder<BookInvoiceLogic>(builder: (logic) {
            BookingConstants.vat = 0.0;


            if (logic.currentUser != null) {
              if (logic.currentUser!.nationality != null) {
                if (!logic.currentUser!.ssn.startsWith('1')) {
                  BookingConstants.vat = BookingConstants.price * .15;
                  //  BookingVars.price+= vat;
                }
              }
            }

            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Wrap(
                children: [
                  Column(
                    children: [
                      if (logic.currentUser == null)
                        LoginWidget(logic:logic),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: logic.currentUser != null ? 10.h : 10.h,
                                bottom: 5.h),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.h)),
                            child: Column(
                              children: [





                                ///  coupon widget

                                // PriceItem(
                                //   patient: BookingConstants.patient!,
                                //   discount: BookingConstants.percentDiscount,
                                //   controller: logic,
                                //   isInvoice: true,
                                //   isPCR: BookingConstants.isPcr,
                                //
                                //
                                // ),

                                CheckoutCardWidget(logic: logic,),

                              ],
                            ),
                          ),

                        ],
                      ),



                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Row(
                          children: [

                            Checkbox(
                                checkColor: AppColors.white,
                                activeColor: AppColors.primaryColor,
                                side: BorderSide(color: AppColors.primaryColor),
                                value: logic.agreeTermsConditions, onChanged: (value){

                              logic.updateAgreeTermsConditions(value ?? false);

                            }),

                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                    text: '${AppStrings.byClick.tr} ',
                                    style: AppStyles.subTitleStyle(
                                      size: 13,
                                    ),
                                    children: [
                                      TextSpan(
                                          text:
                                              AppStrings.termsAndConditions.tr,
                                          style: AppStyles.primaryStyle(
                                              fontSize: 13,
                                              bold: true,
                                              height: 1.5),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.toNamed(
                                                  AppRouteNames.termsOfService);
                                            })
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Ui.primaryButton(
                          title: AppStrings.cardPay,
                          fontSize: 15,
                          capitalize: false,
                          marginV: Platform.isIOS ? 15 : 20,
                          color: logic.agreeTermsConditions ? AppColors.primaryColor: AppColors.extraGrey,
                          onTab: () {

                            logic.navToPayment();
                          }),

                      if (logic.isIos)
                        Ui.primaryButton(
                            title: '',
                            fontSize: 15,
                            icon: FontAwesomeIcons.applePay,
                            marginV: 15,
                            color: logic.agreeTermsConditions ? AppColors.black :AppColors.extraGrey,
                            onTab: () {
                              logic.navToPayment(applePay: true);
                            })
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ],
    ));
  }

  invoiceRow({String title = '', String value = '', double marginV = 15}) {
    return Padding(
      padding: EdgeInsets.only(left: 0, bottom: marginV.h),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title.tr,
            style: AppStyles.primaryStyle(),
          )),
          Text(
            value.tr,
            textAlign: TextAlign.center,
            style: AppStyles.primaryStyle(bold: true, fontSize: 13),
          ),
        ],
      ),
    );
  }

  genderButton({String title = '', bool selected = false, Function? onTab}) {
    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryColor
                : AppColors.primaryColorOpacity,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          title.tr,
          style: selected
              ? AppStyles.whiteStyle(bold: true, size: 15)
              : AppStyles.primaryStyle(fontSize: 15, opacity: .8),
        ),
      ),
    );
  }
}
