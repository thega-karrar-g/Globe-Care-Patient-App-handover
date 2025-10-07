import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';



class InvoiceSummryWidget extends StatelessWidget {
  InvoiceSummryWidget(
      {Key? key,
      this.discount = 0,
        required this.price,
        required this.total,
        this.vat=0,
      required this.patient})
      : super(key: key);

 final AppUser patient;
  double cardHeight = 287;
 final double  total ;
final  double discount ,price,vat;

  // String prevAmount='';

  @override
  Widget build(BuildContext context) {


    var date = DateFormat(' d  MMM   yyyy', Get.locale.toString()).format((DateTime.now()));
// prevAmount=discount>0 ?  (price+discount).toString() :'';


    // if (BookingVars.appointmentDate.length > 10) {
    //   date += DateFormat(' HH:mm a', Get.locale.toString()).format((d));
    // } else {
    //
    //
    // }

// print("total $total");
// print("price $price");
// print("vat $vat");
// print("discount $discount");



    date = DateFormat(' d  MMM   yyyy   HH:mm a', Get.locale.toString()).format((DateTime.now()));














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

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
                child: Text(

               patient.name,
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



              invoiceRow(
                  title:AppStrings.instantConsultation.tr,
                  value: '${(price - discount)
                          .toStringAsFixed(0)}  ${AppStrings.currency.tr}',
                  oldPrice: discount > 0
                      ? price
                          .toStringAsFixed(2)
                      : '')
,







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
                value:  '${  vat.toStringAsFixed(2,)}  ${AppStrings.currency.tr}',
                hasBorder: false),




            invoiceRow(
                title: AppStrings.dueAmount,
                oldPrice:discount >0 ? (price+vat).toStringAsFixed(2):'',
                marginV: 0,
                hasBorder: false,

                value: '${(total  ).toStringAsFixed(2)}  ${AppStrings.currency.tr} ',

                fontSize: 14),




          ],
        ),
      ),
    );
  }

  invoiceRow(
      {String title = '',
      String value = '',
      String oldPrice = '',
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
          if (oldPrice.isNotEmpty)
            Text(
              '${oldPrice.tr}  ${AppStrings.currency.tr}',
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

//   calcPrice() {
//    // print("********************************  ${discount} ");
//     //print("******************************** percentDiscount :  ${BookingVars.percentDiscount} ");
//
//     BookingConstants.price = 0;
//     if (!isInstantCon) {
//       BookingConstants.discount = 0;
//     }
//     BookingConstants.price =
//         double.parse(BookingConstants.service.price) * BookingConstants.service.quantity;
//     if (BookingConstants.service2.id != 0) {
//       cardHeight += 40;
//       BookingConstants.price += double.parse(BookingConstants.service2.price) *
//           BookingConstants.service2.quantity;
//     }
//     if (BookingConstants.service3.id != 0) {
//       cardHeight += 40;
//
//       BookingConstants.price += double.parse(BookingConstants.service3.price) *
//           BookingConstants.service3.quantity;
//     }
//     BookingConstants. subTotal = BookingConstants.price;
//
//     if (isHomeVisitHidden &&
//         !isInstantCon) {
//       BookingConstants.price += BookingConstants.homeVisitPrice;
//     }
//
//     // print("******************************** before discount ${BookingVars.price} ");
//
//     if (discount > 0) {
//
//       if(isInstantCon){
//       BookingConstants.price -= discount;
//       }
//
//       else{
//         BookingConstants.price -= (BookingConstants.price * discount/100);
//
//       }
//
//     }
//    // print("******************************** after discount ${BookingConstants.price} ");
//
//     if (!patient.ssn.startsWith('1')) {
//   vat = BookingConstants.price * .15;
//       //  BookingVars.price+= vat;
//     }
//
//     BookingConstants.price +=BookingConstants. vat;
//     BookingConstants.price= double.parse( BookingConstants.price.toStringAsFixed(2));
//
//     // print("******************************** due amount ${BookingConstants.price} ");
//     // print("******************************** subTotal ${BookingConstants.subTotal} ");
//     // print("******************************** homeVisitPrice ${BookingConstants.homeVisitPrice} ");
//     // print("******************************** prev ${BookingConstants.subTotal+(BookingConstants.vat>0 ?(BookingConstants.subTotal +BookingConstants.homeVisitPrice)*.15:0)+BookingConstants.homeVisitPrice} ");
// prevAmount=BookingConstants. percentDiscount>0 ?   '${ isInstantCon ? BookingConstants.subTotal+discount : (BookingConstants.subTotal+(BookingConstants.vat>0 ?(BookingConstants.subTotal +BookingConstants.homeVisitPrice) *.15:0)+BookingConstants.homeVisitPrice).toStringAsFixed(2)} ':'';
//
//
//   }
}
