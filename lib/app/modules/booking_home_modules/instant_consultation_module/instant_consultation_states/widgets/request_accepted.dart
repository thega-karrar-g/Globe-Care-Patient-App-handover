import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:globcare/app/core/language_and_localization/ar.dart';

import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../data/constants/booking_constants.dart';
import '../../../../../data/models/m_doctors.dart';
import '../../../../../data/models/nurse_service.dart';
import '../../../../../global_widgets/project_widget/price_item.dart';
import '../../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../../global_widgets/ui.dart';
import '../instant_consultation_states_logic.dart';
import 'invoice_summry.dart';

class RequestAcceptedItem extends StatelessWidget {
  const RequestAcceptedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstantConsultationStatesLogic>(builder: (logic) {
      BookingConstants.doctor = Doctor();
      BookingConstants.appointmentDate = DateTime.parse(logic.currentRequest!.date);
      BookingConstants.service = NurseService(
        id: 1,
        name: AppStrings.instantConsultation,
        nameAr: ar[AppStrings.instantConsultation]!,
        price: '${logic.currentRequest!.price}',
      );

      BookingConstants.service2 = NurseService();
      BookingConstants.service3 = NurseService();
      //   BookingVars.discount=logic.currentRequest!.discount;

      return DynamicColumn(
        children: [
          // Image.asset(AppImages.iconTimerCheck, width: 120, height: 120,),
          UiHelper.verticalSpaceMedium,
          // UiHelper.verticalSpaceLarge,
          //
          // Row(
          //   children: [
          //    // UiHelper.horizontalSpaceLarge,
          //     Expanded(child: Lottie.asset(AppAnim.payNow, width: Get.width*.6, height: Get.width*.35,)),
          //   ],
          // ),
          //
          // UiHelper.verticalSpaceMedium,
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
                color: AppColors.primaryColorOpacity,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.requestAcceptedMsg.tr,
                    style: AppStyles.primaryStyle(fontSize: 14, height: 1.5),
                  ),
                )
              ],
            ),
          ),
          UiHelper.verticalSpaceMedium,

          InvoiceSummryWidget(
            patient: logic.currentUser!,
            price:logic.currentRequest!.price.toDouble(),
            vat: logic.vat ,
            total: logic.price,

            // discount: 8,
            discount: logic.currentRequest!.discount.toDouble(),
          ),

          UiHelper.verticalSpaceMedium,

          Column(
            children: [
              Ui.primaryButton(
                  title: AppStrings.cardPay,
                  fontSize: 15,
                  marginV: Platform.isIOS ? 15 : 20,
                  color: AppColors.primaryColor,
                  capitalize: false,
                  onTab: () {
                    logic.openPayment();
                  }),
              if (Platform.isIOS)
                Ui.primaryButton(
                    title: '',
                    fontSize: 15,
                    icon: FontAwesomeIcons.applePay,
                    marginV: 15,
                    color: AppColors.black,
                    onTab: () {
                      logic.openPayment(
                        applePay: true,
                      );
                    })
            ],
          ),
        ],
      );
    });
  }
}
