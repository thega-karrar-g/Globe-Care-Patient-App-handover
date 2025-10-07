import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/models/requested_payment.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import 'requested_payment_logic.dart';

class RequestedPaymentDetailsPage extends StatelessWidget {
  final RequestedPaymentLogic logic = Get.put(RequestedPaymentLogic());
final RequestedPayment requestedPayment=Get.arguments;
  RequestedPaymentDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ar = Get.locale.toString() == 'ar';

    // var d=DateTime.parse(BookingVars.appointmentDate.substring(0,10));

    var d = (BookingConstants.appointmentDate);

    return Ui.myScaffold(
        child: Column(
      children: [
        myAppBar2(title: AppStrings.paymentDetails),
        Expanded(
          child: GetBuilder<RequestedPaymentLogic>(builder: (logic) {
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 60.h, bottom: 25.h),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColorOpacity,
                                borderRadius: BorderRadius.circular(10.h)),
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Column(
                                      children: [
                                        if (logic.currentUser != null)
                                          UiHelper.verticalSpace(80)
                                        else
                                          UiHelper.verticalSpace(16),
                                        invoiceRow(
                                            title: AppStrings.price,
                                            value: '${RequestedPaymentLogic.amount
                                                    .toStringAsFixed(0)}   ${AppStrings.currency.tr}'),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              AppStrings.date.tr,
                                              style: AppStyles.primaryStyle(),
                                            )),

                                            Text(
                                              DateFormat(' d ').format((d)),
                                              style: AppStyles.subTitleStyle(
                                                  bold: true, size: 12),
                                            ),

                                            Text(
                                              DateFormat(' MMM ',
                                                      Get.locale.toString())
                                                  .format((d)),
                                              style:
                                                  AppStyles.primaryStyleGreen(
                                                      bold: true, size: 12),
                                            ),
                                            Text(
                                              DateFormat(' yyyy ').format((d)),
                                              style: AppStyles.subTitleStyle(
                                                  bold: true, size: 12),
                                            ),

                                            //    UiHelper.horizontalSpaceMedium,SvgPicture.asset(AppImages.calendar,color: AppColors.primaryColorGreen,),
                                          ],
                                        ),
                                        UiHelper.verticalSpaceMedium,
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Positioned(
                              top: 10.h,
                              child: Row(
                                children: [
                                  if (logic.currentUser != null)
                                    RotatedBox(
                                      quarterTurns: ar ? 2 : 0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 100.h,
                                          width: Get.width - 60.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                AppImages.invoiceBgPng,
                                              ),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 15.h),
                                            child: RotatedBox(
                                                quarterTurns: ar ? 2 : 0,
                                                child: Text(
                                                  logic.currentUser!.name,
                                                  style: AppStyles.whiteStyle(
                                                      bold: true),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              )),
                        ],
                      ),

                      UiHelper.verticalSpaceSmall,
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.primaryColorOpacity,
                            borderRadius: BorderRadius.circular(10.h)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.details.tr,
                                        style: AppStyles.primaryStyle(
                                            bold: true, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpaceMedium,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        RequestedPaymentLogic.details,
                                        style: AppStyles.primaryStyle(fontSize: 15),
                                      )),
                                    ],
                                  ),
                                  UiHelper.verticalSpaceSmall,
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              height: 60.h,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.h),
                                      bottomRight: Radius.circular(10.h))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.total.tr,
                                        style: AppStyles.whiteStyle(
                                            size: 15, bold: false),
                                      ),
                                      Spacer(),
                                      Text(
                                        ' ${(RequestedPaymentLogic.amount).toStringAsFixed(2)}   ${AppStrings.currency.tr}',
                                        style: AppStyles.whiteStyle(
                                            size: 15, bold: true),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpaceSmall,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text(AppStrings.paymentType.tr,style: AppStyles.primaryStyle(bold: true,size: 16),),
                      //       ],
                      //     ),
                      //     Ui.greenLine(),
                      //
                      //
                      //     Row(
                      //       children: [
                      //
                      //         genderButton(title: AppStrings.cash,selected: logic.index==0,onTab: (){logic.changePaymentType(0);}),
                      //         UiHelper.horizontalSpaceMedium,
                      //         genderButton(title: AppStrings.insurance,selected: logic.index==1,onTab: (){logic.changePaymentType(1);}),
                      //         UiHelper.horizontalSpaceMassive,
                      //
                      //
                      //       ],
                      //     )
                      //   ],
                      // ),

                      UiHelper.verticalSpaceMedium,
                      if ( !["done","paid"].contains( requestedPayment.state.toLowerCase() ))
                      Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                    text: '${AppStrings.byClick.tr} ',
                                    style: AppStyles.subTitleStyle(
                                      size: 13,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: AppStrings.termsAndConditions.tr,
                                          style: AppStyles.primaryStyle(
                                              fontSize: 13, bold: true, height: 1.5),
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
                        UiHelper.verticalSpaceMedium,

                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Ui.primaryButton(
                                  title: AppStrings.cardPay,
                                  fontSize: 15,
                                  capitalize: false,
                                  marginV: Platform.isIOS ? 5 : 5,
                                  color: AppColors.primaryColor,
                                  onTab: () {
                                    logic.openPayment();
                                  }),
                            ),
                          ],
                        ),

                        if (Platform.isIOS)
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Ui.primaryButton(
                                    title: '',
                                    fontSize: 15,
                                    icon: FontAwesomeIcons.applePay,
                                    marginV: Platform.isIOS ? 5 : 5,
                                    paddingV: 10,
                                    color: AppColors.black,
                                    onTab: () {
                                      logic.openPayment(applePay: true);
                                    }),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: Ui.primaryButton(
                                  title: AppStrings.reject,
                                  fontSize: 15,
                                  marginV: Platform.isIOS ? 5 : 5,
                                  paddingH: 5,
                                  color: AppColors.primaryColorGreen,
                                  onTab: () {
                                    logic
                                        .setRequestedPaymentStatus(
                                        showDialog: true,price: '0',isReject: true)
                                        .then((value) {
                                      Future.delayed(Duration(milliseconds: 30),
                                              () {
                                            Get.back(result: true);
                                          });
                                    });
                                  }),
                            ),
                          ],
                        ),

                      ],),






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
      padding: EdgeInsets.only(left: 0, bottom: marginV),
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
