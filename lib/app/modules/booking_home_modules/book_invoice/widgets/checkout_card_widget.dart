import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/assets_helper/app_images.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';
import 'package:globcare/app/modules/booking_home_modules/location/location_logic.dart';
import 'package:globcare/app/utils/string_reverse.dart';
import 'package:intl/intl.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../data/eunums/enums.dart';
import '../../patient_data/patient_data_logic.dart';
import '../book_invoice_logic.dart';
import 'coupon_widget.dart';

class CheckoutCardWidget extends StatelessWidget {
   CheckoutCardWidget({Key? key,required this.logic}) : super(key: key);
 final bool ar = Get.locale.toString() == 'ar';
 // final  double discount = 0;
   final BookInvoiceLogic logic;
   String prevAmount='';
final   bool  showHomeVisit=![ChooseDateType.doctor,ChooseDateType.sleepMedicine,ChooseDateType.caregiver].contains(PatientDataLogic.chooseDateType);

double servicesAmount=0;
  @override
  Widget build(BuildContext context) {
    // BookingConstants.percentDiscount=0;
    var d = (BookingConstants.appointmentDate);
    calcPrice();

    var date = DateFormat(' d  MMM   yyyy', Get.locale.toString()).format((d));
    if (BookingConstants.period.isNotEmpty) {
      date += '   -     ${BookingConstants.period.tr}';
    }
    else{
      date += DateFormat('       HH:mm a', Get.locale.toString()).format((d));

    }
    return Column(children: [





      Container(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiHelper.verticalSpaceMedium,

            patientRowWidget(),
            UiHelper.verticalSpaceMedium,
            Divider(color: AppColors.white.withOpacity(.5),),

          Text("${AppStrings.bookingServices.tr} : ",textAlign: TextAlign.start,style: AppStyles.primaryStyle(color: AppColors.white,bold: true,fontSize: 16),),

        //  UiHelper.verticalSpaceMedium,
          invoiceRow(title: ar
              ? ' ${BookingConstants.service.nameAr}'
              : ' ${BookingConstants.service.name}',
              value: '${(((double.parse(BookingConstants.service.price)) *
                  BookingConstants.service.quantity))
                  .toStringAsFixed(0)}  ${AppStrings.currency.tr}',
             ),

          if (BookingConstants.service2.id != 0)
            invoiceRow(title: ar
                ? ' ${BookingConstants.service2.nameAr}'
                : ' ${BookingConstants.service2.name}',
                value: '${(((double.parse(BookingConstants.service2.price)) *
                    BookingConstants.service2.quantity))
                    .toStringAsFixed(0)}  ${AppStrings.currency.tr}',
                ),

          if (BookingConstants.service3.id != 0)
            invoiceRow(title: ar
                ? ' ${BookingConstants.service3.nameAr}'
                : ' ${BookingConstants.service.name}',
                value: '${(((double.parse(BookingConstants.service3.price)) *
                    BookingConstants.service3.quantity) )
                    .toStringAsFixed(0)}  ${AppStrings.currency.tr}',
                ),

            Divider(color: AppColors.white.withOpacity(.5),),

            invoiceRow(title: AppStrings.bookingDate.tr, value: date),
            // invoiceRow(title: AppStrings.address.tr, value: LocationLogic.addressController.text),



          ],),
      ),

      CouponWidget(logic:logic),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // UiHelper.verticalSpaceMedium,

            Text("${AppStrings.paymentDetails.tr} : ",textAlign: TextAlign.start,style: AppStyles.primaryStyle(color: AppColors.white,bold: true,fontSize: 16),),


            invoiceRow(
                title: AppStrings.bookingServices.tr,
                value:
                '${ BookingConstants.percentDiscount>0 ? BookingConstants.subTotal * BookingConstants.percentDiscount/ 100  :BookingConstants.subTotal}  ${AppStrings.currency.tr}',
                hasBorder: false,
                preDiscount: BookingConstants.percentDiscount>0 ? "${BookingConstants.subTotal }" :""),

            //  UiHelper.verticalSpaceMedium,
            if(showHomeVisit)
            invoiceRow(
                title: AppStrings.homeVisitPrice,
                value:
               BookingConstants.percentDiscount>0 ? '${BookingConstants.homeVisitPrice* BookingConstants.percentDiscount/100}  ${AppStrings.currency.tr}':"${BookingConstants.homeVisitPrice}  ${AppStrings.currency.tr}",
                preDiscount: BookingConstants.percentDiscount>0 ? "${BookingConstants.homeVisitPrice} " :"",
                hasBorder: false),

            if( BookingConstants.showTransportingFee)
              invoiceRow(
                  title: AppStrings.transportingFee,
                  value:
                  '${BookingConstants.transportingFee}  ${AppStrings.currency.tr}',
                  hasBorder: false),

            if(BookingConstants.percentDiscount>0)
              invoiceRow(
                  title: AppStrings.discountPercent,
                  value:
                  '${(BookingConstants.percentDiscount).toStringAsFixed(0)} %',
                  hasBorder: false),

            invoiceRow(
                title: AppStrings.addedTax,
                value: '${ BookingConstants. vat.toStringAsFixed(2)}  ${AppStrings.currency.tr}',
                hasBorder: false),




            invoiceRow(
                title: AppStrings.dueAmount,
                preDiscount:prevAmount.toString(),
                marginV: 0,
                hasBorder: false,

                value: '${(BookingConstants.price ).toStringAsFixed(2)}  ${AppStrings.currency.tr} ',

                fontSize: 14),



          ],),
      ),




    ],);
  }


   invoiceRow(
       {String title = '',
         String value = '',
         String preDiscount = '',
         double marginV = 20,
         bool hasBorder = true,
         double fontSize = 13}) {
     return Padding(
       padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 0.w),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("- ",style: AppStyles.primaryStyle(bold: true,color: AppColors.white),),
           Expanded(
               child: Text(
                 title.tr,
                 overflow: TextOverflow.ellipsis,
                 maxLines: 2,
                 style: AppStyles.primaryStyle(fontSize: fontSize, height: 1.5,color: AppColors.white),
               )),
           if (preDiscount.isNotEmpty)
             Text(
               '${preDiscount.tr}  ${AppStrings.currency.tr}',
               textAlign: TextAlign.center,
               style: AppStyles.primaryStyle(
                   bold: false,
                   color: AppColors.white,
                   lineThrough: true,
                   fontSize: fontSize,
               textDecoration: TextDecoration.lineThrough
               ),
             ),
           UiHelper.horizontalSpaceSmall,
           Text(
             value.tr,
             textAlign: TextAlign.center,
             style: AppStyles.primaryStyle(bold: true, fontSize: fontSize,color: AppColors.white),
           ),
         ],
       ),
     );
   }


   patientRowWidget(){

    return Row(children: [

      SvgPicture.asset(AppImages.person,color: AppColors.white,),
      UiHelper.horizontalSpaceSmall,
      Expanded(child: Text(BookingConstants.patient!.name,style: AppStyles.primaryStyle(color: AppColors.white,fontSize: 18),)),

    ],);

   }
   calcPrice() {


     BookingConstants.price = 0;
     BookingConstants.vat = 0;

     BookingConstants.price =
         double.parse(BookingConstants.service.price) * BookingConstants.service.quantity;
     if (BookingConstants.service2.id != 0) {
       BookingConstants.price += double.parse(BookingConstants.service2.price) *
           BookingConstants.service2.quantity;
     }
     if (BookingConstants.service3.id != 0) {

       BookingConstants.price += double.parse(BookingConstants.service3.price) *
           BookingConstants.service3.quantity;
     }
     BookingConstants. subTotal = BookingConstants.price;

     if (showHomeVisit) {
       BookingConstants.price += BookingConstants.homeVisitPrice;
     }
     if (BookingConstants.percentDiscount > 0) {


       BookingConstants.price = (BookingConstants.price * BookingConstants.percentDiscount/100);

     }



     if(BookingConstants.transportingFee >0){

       BookingConstants. vat += BookingConstants.transportingFee * .15;


       if (BookingConstants.patient!.ssn.startsWith('2')) {
         BookingConstants.vat +=   BookingConstants.price * .15;
       }

       BookingConstants.price += BookingConstants.transportingFee;

     }

     else {
       if (BookingConstants.patient!.ssn.startsWith('2')) {
         BookingConstants.vat = BookingConstants.price * .15;
         //  BookingVars.price+= vat;
       }
     }









     print("******************************** before vat ${BookingConstants.price} ");
     print("********************************  vat ${BookingConstants.vat} ");

     BookingConstants.price +=BookingConstants. vat;
     BookingConstants.price= double.parse( BookingConstants.price.toStringAsFixed(2));

     print("******************************** due amount ${BookingConstants.price} ");
     print("******************************** subTotal ${BookingConstants.subTotal} ");
     // print("******************************** homeVisitPrice ${BookingConstants.homeVisitPrice} ");
     // print("******************************** prev ${BookingConstants.subTotal+(BookingConstants.vat>0 ?(BookingConstants.subTotal +BookingConstants.homeVisitPrice)*.15:0)+BookingConstants.homeVisitPrice} ");
     prevAmount=BookingConstants. percentDiscount>0 ?   '${  (BookingConstants.subTotal+(BookingConstants.vat>0 ?(BookingConstants.subTotal +BookingConstants.homeVisitPrice+BookingConstants.transportingFee) *.15:0)+BookingConstants.homeVisitPrice+BookingConstants.transportingFee).toStringAsFixed(2)} ':'';


   }





}
