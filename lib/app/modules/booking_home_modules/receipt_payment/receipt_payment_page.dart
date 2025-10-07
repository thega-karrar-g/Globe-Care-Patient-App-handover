import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import '../../../core/assets_helper/app_anim.dart';
import '../../appointment_requests_module/caregiver_contract_questionnaire/caregiver_contract_questionnaire_view.dart';
import '../../my_profile_module/requested_payment/requested_payment_logic.dart';
import '../appointment_base_controllers/booking_base_controller.dart';
import 'receipt_payment_logic.dart';

class ReceiptPaymentPage extends StatelessWidget {
  ReceiptPaymentPage({Key? key}) : super(key: key);

  //final String transId,responseCode,appointmentId;
  // final String result;
  // final String amount;
  //
  // final String cardToken;
  // final String cardBrand;
  // final String MaskedPan;

  final logic = Get.put(ReceiptPaymentLogic());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Ui.myScaffold(
        child: GetBuilder<ReceiptPaymentLogic>(builder: (logic) {
          return SingleChildScrollView(
            child: Center(
              child: logic.busy
                  ? Container()
                  : Column(
                      children: <Widget>[
                        myAppBarPayment(title: AppStrings.orderSummary),

                        if (logic.responseCode == '000')
                          Column(
                            children: [
                              UiHelper.verticalSpaceMassive,
                              //   rowItem(title: 'رقم العملية',value: logic.transId),
                              //  // rowItem(title: ' المبلغ',value: logic.amount),
                              //   rowItem(title: ' الكود',value: logic.responseCode),
                              // //  rowItem(title: ' النتيجة',value: logic.result),

                              Lottie.asset(
                                AppAnim.paymentSuccess,
                                repeat: false,
                                width: Get.width * .5,
                                height: Get.height * .3,
                              ),
                              UiHelper.verticalSpaceLarge,
                              // Text(AppStrings.congratulations.tr.capitalize.toString(),
                              //   style: AppStyles.primaryStyle(bold: true, size: 30),),
                              // UiHelper.verticalSpaceMedium,
                              Text(
                                  (logic.successMsg).tr.capitalizeFirst
                                    .toString(),
                                style: AppStyles.primaryStyle(
                                    bold: true, fontSize: 16),
                              ),
                              UiHelper.verticalSpaceLarge,



                              if (BookingConstants.paymentFromInstantCons)
                                Ui.primaryButton(
                                    title: AppStrings.backToConsultation,
                                    onTab: () {
                                      Get.offAndToNamed(
                                          AppRouteNames.instantConsultation);
                                    })


                                else if(logic.isCaregiverContractRequest)
                                Ui.primaryButton(
                                    title: AppStrings.fillQuestioner,
                                    onTab: () {


                                      Get.offAllNamed(AppRouteNames.homeTabs);

                                      Get.toNamed(CaregiverContractQuestionnairePage.routeName,arguments:logic. appointmentId);


                                    })

                              else if(logic.isSleepRequest)
                                  Ui.primaryButton(
                                      title: AppStrings.fillQuestioner,
                                      onTab: () {


                                        Get.offAllNamed(AppRouteNames.homeTabs);

                                        Get.toNamed(AppRouteNames.sleepQuestionnaire,arguments:logic. appointmentId);


                                      })

                              else
                                Ui.primaryButton(
                                    title: AppStrings.backToHome,
                                    onTab: () {
                                      Get.offNamedUntil(AppRouteNames.homeTabs,(route) => false);
                                    })
                            ],
                          )
                        else
                          Column(
                            children: [
                              Lottie.asset(
                                AppAnim.paymentFailed,
                                repeat: true,
                                width: Get.width * .5,
                                height: Get.height * .3,
                              ),
                              UiHelper.verticalSpaceLarge,
                              Text(
                                AppStrings.oops.tr.capitalize.toString(),
                                style: AppStyles.primaryStyle(
                                    bold: true, fontSize: 30),
                              ),
                              UiHelper.verticalSpaceMedium,
                              Text(
                                AppStrings.paymentFailed.tr.capitalizeFirst
                                    .toString(),
                                style: AppStyles.primaryStyle(
                                    bold: true, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  if (logic.failRoute !=
                                      AppRouteNames.requestedPaymentDetails)
                                    if (BookingConstants.paymentFromInstantCons)
                                      Expanded(
                                        child: Ui.primaryButton(
                                            title: AppStrings.tryAgain,
                                            fontSize: 13,
                                            onTab: () {
                                              BookingBaseController()
                                                  .performtrxn(
                                                orderId: logic.appointmentId,
                                                failRoute: logic.failRoute,
                                                redirectPage: AppRouteNames
                                                    .instantConsultation,
                                                amount:  BookingConstants.price
                                              );

                                              // Get.toNamed(AppRouteNames.invoicePage);
                                            }),
                                      )
                                    else
                                      Expanded(
                                        child: Ui.primaryButton(
                                            title: AppStrings.tryAgain,
                                            fontSize: 13,
                                            onTab: () {
                                              BookingBaseController()
                                                  .cancelAppointment(
                                                      logic.appointmentId,
                                                      route: logic.failRoute);

                                              // Get.toNamed(AppRouteNames.invoicePage);
                                            }),
                                      ),
                                  UiHelper.horizontalSpaceMedium,
                                  if (BookingConstants.paymentFromInstantCons)
                                    Expanded(
                                      child: Ui.primaryButton(
                                          title: AppStrings.backToConsultation,
                                          fontSize: 13,
                                          onTab: () {
                                            Get.offAndToNamed(AppRouteNames
                                                .instantConsultation);
                                          }),
                                    )
                                  else
                                    Expanded(
                                      child: Ui.primaryButton(
                                          title: AppStrings.backToHome,
                                          fontSize: 13,
                                          onTab: () {
                                            if (logic.failRoute ==
                                                AppRouteNames
                                                    .requestedPaymentDetails) {
                                              RequestedPaymentLogic()
                                                  .setRequestedPaymentStatus(
                                                      paymentReference:
                                                          logic.transId,price: '0');
                                            } else {
                                              BookingBaseController()
                                                  .cancelAppointment(
                                                      logic.appointmentId);
                                            }
                                            //  Get.offAllNamed(AppRouteNames.invoicePage);
                                          }),
                                    ),
                                ],
                              )
                            ],
                          ),

                        // rowItem(title: 'Masked Card No. ',value: widget.MaskedPan),

                        // visibilityToken ?  Padding(
                        //   padding: const EdgeInsets.fromLTRB(0,20.0,0,0),
                        //   child: Text.rich(
                        //     TextSpan(
                        //       // default text style
                        //       children: <TextSpan>
                        //       [
                        //         TextSpan(text:'Token Details', style: TextStyle(fontWeight: FontWeight.bold)),
                        //       ],
                        //     ),
                        //   ),
                        // ): Container(),
                        // visibilityToken ?  Text.rich(
                        //   TextSpan(
                        //     text: 'Card Token  ', // default text style
                        //     children: <TextSpan>[
                        //       TextSpan(text: widget.cardToken,
                        //           style: TextStyle(fontWeight: FontWeight.bold)),
                        //     ],
                        //   ),
                        // ): Container(),

                        // RaisedButton(
                        //   onPressed: ()
                        //   {
                        //     Navigator.pop(context);
                        //   },
                        //   color: AppColors.primaryColor,
                        //   shape:  RoundedRectangleBorder(
                        //
                        //       borderRadius:  BorderRadius.circular(10.0)),
                        //
                        //   child: Text(AppStrings.newTransaction.tr,                      style:AppStyles.whiteStyle(size: 16,bold: true)
                        //   ),
                        // ),
                      ],
                    ),
            ),
          );
        }),
      ),
    );
  }

  rowItem({String title = '', String value = ''}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Text(
            '${title.tr}   : ',
            style: AppStyles.primaryStyle(bold: true, fontSize: 15),
          ),
          Expanded(
              child: Text(
            value,
            style: AppStyles.primaryStyleGreen(bold: true, size: 15),
          )),
        ],
      ),
    );
  }
}
