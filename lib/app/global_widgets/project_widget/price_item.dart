import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base_controller/base_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../data/constants/booking_constants.dart';
import '../../data/eunums/enums.dart';
import '../../data/models/user_model.dart';
import '../../modules/booking_home_modules/patient_data/patient_data_logic.dart';
import '../shared/ui_helpers.dart';

class PriceItem extends StatelessWidget {
  PriceItem(
      {Key? key,
      required this.controller,
      this.isPCR = false,
      this.isInvoice = false,
      this.isInstantCon = false,
      this.discount = 0,
      required this.patient})
      : super(key: key);

 final bool isPCR , isInvoice , isInstantCon ;
 final BaseController controller;
 final AppUser patient;
  double cardHeight = 265;
  double  subTotal = 0.0;
  var d = (BookingConstants.appointmentDate);
  double discount = 0;

  String prevAmount='';
  bool  isHomeVisitHidden=![ChooseDateType.doctor,ChooseDateType.sleepMedicine,ChooseDateType.caregiver].contains(PatientDataLogic.chooseDateType);

  @override
  Widget build(BuildContext context) {
    var date = DateFormat(' d  MMM   yyyy', Get.locale.toString()).format((d));


    // if (BookingVars.appointmentDate.length > 10) {
    //   date += DateFormat(' HH:mm a', Get.locale.toString()).format((d));
    // } else {
    //
    //
    // }


    if (BookingConstants.period.isNotEmpty) {
      date += '   -     ${BookingConstants.period.tr}';
    }
    else{
      date += DateFormat('       HH:mm a', Get.locale.toString()).format((d));

    }

    if(isInstantCon){
      date = DateFormat(' d  MMM   yyyy   HH:mm a', Get.locale.toString()).format((DateTime.now()));

    }

    calcPrice();
    if (isPCR) {
      cardHeight += 60;
    }

    if (isInvoice) {
      cardHeight += 30;
    }
    if (discount > 0 && !isInstantCon) {
      cardHeight += 30;
    }



    if (isInstantCon) {
      cardHeight += 22;
    }

    if (BookingConstants.doctor.name!.isNotEmpty) {
      cardHeight += 30;
    }
    if (isHomeVisitHidden ) {
      cardHeight -= 20;
    }

    bool ar = Get.locale.toString() == 'ar';

    // print(discount);


    return CouponCard(
      height: cardHeight.h,
      curvePosition: cardHeight.h - 80.h,
      curveRadius: 15.h,
      clockwise: false,
      borderRadius: 10.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withOpacity(.9),
            AppColors.primaryColor.withOpacity(.9),
            // AppColors.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      firstChild: Container(
        decoration: BoxDecoration(color: AppColors.primaryColor),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.verticalSpaceSmall,

            if(controller.currentUser !=null)
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
                child: Text(

               isInstantCon ?controller.currentUser!.name :   BookingConstants.patient!.name,
                  style: AppStyles.primaryStyle(
                      bold: true,fontSize: 15,color: AppColors.white),
                ),
              ),

            UiHelper.verticalSpaceSmall,
            Row(
              children: [
                Text(
                  AppStrings.details.tr,
                  style: AppStyles.whiteStyle(bold: true, size: 13),
                )
              ],
            ),
            UiHelper.verticalSpaceSmall,
            Divider(
              color: AppColors.white,
            ),

            if (BookingConstants.doctor.name!.isNotEmpty)
              invoiceRow(
                title: AppStrings.doctor,
                value:
                    ar ? BookingConstants.doctor.nameAr! : BookingConstants.doctor.name!,
              ),

            if (isInstantCon)
              invoiceRow(
                  title: ar
                      ? '- ${BookingConstants.service.nameAr}'
                      : '- ${BookingConstants.service.name}',
                  value: '${(((double.parse(BookingConstants.service.price)) *
                                  BookingConstants.service.quantity) -
                              discount)
                          .toStringAsFixed(0)}  ${AppStrings.currency.tr}',
                  discount: discount > 0
                      ? ((double.parse(BookingConstants.service.price)) *
                              BookingConstants.service.quantity)
                          .toStringAsFixed(2)
                      : '')
            else
              invoiceRow(
                  title: ar
                      ? '- ${BookingConstants.service.nameAr}'
                      : '- ${BookingConstants.service.name}',
                  value: '${((double.parse(BookingConstants.service.price)) *
                              BookingConstants.service.quantity)
                          .toStringAsFixed(2)}  ${AppStrings.currency.tr}'),

            if (isPCR)
              invoiceRow(
                  title: AppStrings.unit,
                  value: '${(((double.parse(BookingConstants.service.price)) *
                                      BookingConstants.service.quantity)
                                  .toInt() /
                              BookingConstants.service.quantity)
                          .toStringAsFixed(2)}   ${AppStrings.currency.tr}',
                  hasBorder: false),

            if (isPCR)
              invoiceRow(
                  title: AppStrings.personsCount,
                  value: '${BookingConstants.service.quantity}',
                  hasBorder: false),

            if (BookingConstants.service2.id != 0)
              invoiceRow(
                  title: ar
                      ? '- ${BookingConstants.service2.nameAr}'
                      : '- ${BookingConstants.service2.name}',
                  value: '${BookingConstants.service2.price}  ${AppStrings.currency.tr}'),

            if (BookingConstants.service3.id != 0)
              invoiceRow(
                  title: ar
                      ? '- ${BookingConstants.service3.nameAr}'
                      : '- ${BookingConstants.service3.name}',
                  value: '${BookingConstants.service3.price}  ${AppStrings.currency.tr}'),

            if (isInvoice || isInstantCon)
              invoiceRow(title: '- ${AppStrings.bookingDate.tr}', value: date),

// if(isInvoice||isInstantCon)
            // Row(children: [
            //
            //   //UiHelper.horizontalSpaceSmall,
            //   SvgPicture.asset(AppImages.calendar,width: 20.w,height: 20.h,color: AppColors.white,),
            //   UiHelper.horizontalSpaceMedium,
            //
            //
            //   Text( DateFormat(' d  MMM   yyyy',Get.locale.toString()).format((d)),style: AppStyles.whiteStyle(bold: true,size: 12),),
            //
            //   // Text(DateFormat(' MMM ',Get.locale.toString()).format((d)),style: AppStyles.primaryStyleGreen(bold: true,size: 12),),
            //   // Text( DateFormat(' yyyy ').format((d)),style: AppStyles.subTitleStyle(bold: true,size: 12),),
            //
            //   if(BookingVars.appointmentDate.length>10)
            //     Text( DateFormat(' HH:mm a',Get.locale.toString()).format((d)),style: AppStyles.whiteStyle(bold: true,size: 12,opacity: .8),)
            //   else
            //     Padding(
            //       padding:  EdgeInsets.symmetric(horizontal: 20.w),
            //       child: Text(BookingVars.period.tr,style: AppStyles.whiteStyle(bold: true,size: 12,opacity: .8),),
            //     ),
            //
            //
            //
            //
            //
            // ],),

            // Divider(
            //   color: AppColors.white,
            // ),



            if (!isInstantCon &&
                isHomeVisitHidden)
              invoiceRow(
                  title: AppStrings.homeVisitPrice,
                  value:
                      '${BookingConstants.homeVisitPrice}  ${AppStrings.currency.tr}',
                  hasBorder: false),



            if(BookingConstants.percentDiscount>0)
              invoiceRow(
                  title: AppStrings.discountPercent,
                  value:
                  '${(BookingConstants.percentDiscount).toStringAsFixed(0)} %',
                  hasBorder: false),


          ],
        ),
      ),
      secondChild: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white),
          ),
        ),
        padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        child: Column(
          children: [

            // if (discount > 0 && !isInstantCon)
            //   invoiceRow(
            //       title: AppStrings.discount,
            //       value:
            //       '${(BookingVars.subTotal - (isInstantCon ? discount : (BookingVars.subTotal * BookingVars.percentDiscount/100) )).toStringAsFixed(0)}  ${AppStrings.currency.tr}',
            //       discount: BookingVars.subTotal.toStringAsFixed(0),
            //       hasBorder: false),

            invoiceRow(
                title: AppStrings.addedTax,
                value: '${ BookingConstants. vat.toStringAsFixed(2)}  ${AppStrings.currency.tr}',
                hasBorder: false),




            invoiceRow(
                title: AppStrings.dueAmount,
                discount:prevAmount.toString(),
                marginV: 0,
                hasBorder: false,

                value: '${(BookingConstants.price ).toStringAsFixed(2)}  ${AppStrings.currency.tr} ',

                fontSize: 14),




          ],
        ),
      ),
    );
  }

  invoiceRow(
      {String title = '',
      String value = '',
      String discount = '',
      double marginV = 10,
      bool hasBorder = true,
      double fontSize = 13}) {
    return Container(
      margin: EdgeInsets.only(left: 0, bottom: marginV.h),
      padding: EdgeInsets.only(left: 0, bottom: 0),
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title.tr,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppStyles.whiteStyle(size: fontSize, height: 1.5),
          )),
          if (discount.isNotEmpty)
            Text(
              '${discount.tr}  ${AppStrings.currency.tr}',
              textAlign: TextAlign.center,
              style: AppStyles.primaryStyle(
                  bold: false,
                  color: AppColors.white,
                  lineThrough: true,
                  textDecoration: TextDecoration.lineThrough,
                  lineThroughColor: AppColors.white,

                  fontSize: fontSize),
            ),
          UiHelper.horizontalSpaceSmall,
          Text(
            value.tr,
            textAlign: TextAlign.center,
            style: AppStyles.whiteStyle(bold: true, size: fontSize),
          ),
        ],
      ),
    );
  }

  calcPrice() {
   // print("********************************  ${discount} ");
    //print("******************************** percentDiscount :  ${BookingVars.percentDiscount} ");

    BookingConstants.price = 0;
    if (!isInstantCon) {
      BookingConstants.discount = 0;
    }
    BookingConstants.price =
        double.parse(BookingConstants.service.price) * BookingConstants.service.quantity;
    if (BookingConstants.service2.id != 0) {
      cardHeight += 40;
      BookingConstants.price += double.parse(BookingConstants.service2.price) *
          BookingConstants.service2.quantity;
    }
    if (BookingConstants.service3.id != 0) {
      cardHeight += 40;

      BookingConstants.price += double.parse(BookingConstants.service3.price) *
          BookingConstants.service3.quantity;
    }
    BookingConstants. subTotal = BookingConstants.price;

    if (isHomeVisitHidden &&
        !isInstantCon) {
      BookingConstants.price += BookingConstants.homeVisitPrice;
    }

    // print("******************************** before discount ${BookingVars.price} ");

    if (discount > 0) {

      if(isInstantCon){
      BookingConstants.price -= discount;
      }

      else{
        BookingConstants.price -= (BookingConstants.price * discount/100);

      }

    }
   // print("******************************** after discount ${BookingConstants.price} ");

    if (!patient.ssn.startsWith('1')) {
      BookingConstants. vat = BookingConstants.price * .15;
      //  BookingVars.price+= vat;
    }

    BookingConstants.price +=BookingConstants. vat;
    BookingConstants.price= double.parse( BookingConstants.price.toStringAsFixed(2));

    // print("******************************** due amount ${BookingConstants.price} ");
    // print("******************************** subTotal ${BookingConstants.subTotal} ");
    // print("******************************** homeVisitPrice ${BookingConstants.homeVisitPrice} ");
    // print("******************************** prev ${BookingConstants.subTotal+(BookingConstants.vat>0 ?(BookingConstants.subTotal +BookingConstants.homeVisitPrice)*.15:0)+BookingConstants.homeVisitPrice} ");
prevAmount=BookingConstants. percentDiscount>0 ?   '${ isInstantCon ? BookingConstants.subTotal+discount : (BookingConstants.subTotal+(BookingConstants.vat>0 ?(BookingConstants.subTotal +BookingConstants.homeVisitPrice) *.15:0)+BookingConstants.homeVisitPrice).toStringAsFixed(2)} ':'';


  }
}
