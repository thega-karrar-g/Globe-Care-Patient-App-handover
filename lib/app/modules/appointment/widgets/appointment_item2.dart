import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globcare/app/base_controller/base_controller.dart';
import 'package:intl/intl.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/api/api_keys.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/models/home_service.dart';
import '../../../data/models/m_appointment.dart';
import '../../../global_widgets/shared/bottom_sheet_text_form.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import '../../../core/assets_helper/app_images.dart';
import '../../booking_home_modules/appointment_base_controllers/booking_base_controller.dart';
import '../appointment_controller.dart';

class AppointmentItem2 extends StatelessWidget {
  AppointmentItem2({this.appointment, this.homeService, Key? key})
      : super(key: key);
 final bool ar = Get.locale.toString() == 'ar';
 final List<String> status = [
    'scheduled',
    'completed',
    'visit_done',
    'canceled',
  ];

 final HomeService? homeService;
  final Appointment? appointment;
  final DateFormat dateFormat = DateFormat("dd MMM yyyy HH:mm a");
final TextEditingController reasonCtrl=TextEditingController();
  bool isMeetPossible(String currentStatus) {
    return status.contains(currentStatus.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    // var h = ((!isMeetPossible(appointment!.state)) &&
    //         appointment!.state.toLowerCase() != 'start'
    //     ? 100.0
    //     : 75.0);
    var imageW = ((!isMeetPossible(appointment!.state) &&
            appointment!.state.toLowerCase() != 'start')
        ? 90.0
        : 75.0);
    double radius = 15;
    String time = appointment!.period.isNotEmpty
        ? appointment!.period.capitalizeFirst!
        : DateFormat('HH:mm a', Get.locale.toString())
            .format((appointment!.appointmentDate));

    return ListTile(
      contentPadding:
          EdgeInsets.only(left: 0.0, right: 0.0, top: 5.h, bottom: 5.h),
      title: SizedBox(
       //height: h.h,
        child: GestureDetector(
          onTap: () async {

            // print(appointment!.state);

            if (!isMeetPossible(appointment!.state.toLowerCase()) &&
                appointment!.state.toLowerCase() == 'start' &&
                homeService!.icon == AppImages.iconTeleMed) {
              Get.toNamed(AppRouteNames.meetingPage, arguments: appointment);
            }
          },
          child: IntrinsicHeight(
            child: Container(
              // padding: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                  color: AppColors.primaryColorOpacity,
                  borderRadius: BorderRadius.circular(radius.h)),
              child: Row(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: imageW.w,
                         // height: h.h,
                          decoration: BoxDecoration(
                            color: AppColors.iconAppointmentColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ar ? 0 : radius.h),
                              topRight: Radius.circular(ar ? radius.h : 0),
                              bottomRight: Radius.circular(radius.h),
                              bottomLeft: Radius.circular(radius.h),
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          child: Image.asset(
                            homeService!.icon,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Container(
                    // height: h,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(ar ? 0 : radius.h),
                        bottomRight: Radius.circular(ar ? 0 : radius.h),
                        topLeft: Radius.circular(ar ? radius.h : 0),
                        bottomLeft: Radius.circular(ar ? radius.h : 0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(appointment!.name.isNotEmpty)
                        Text(
                                                appointment!.name ,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyles.primaryStyle(bold: true, fontSize: 13),
                                              ).marginSymmetric(vertical: 2.h),

                        Text(
                                                    appointment!.doctor,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style:
                          AppStyles.subTitleStyle(bold: true, size: 12),
                                                  ),
                        UiHelper.verticalSpaceTiny,
                        Row(
                          children: [
                            Text(
                              DateFormat(' d ', Get.locale.toString())
                                  .format((appointment!.appointmentDate)),
                              style: AppStyles.primaryStyleGreen(
                                  bold: true, size: 11),
                            ),
                            Text(
                              DateFormat(' MMM ', Get.locale.toString())
                                  .format((appointment!.appointmentDate)),
                              style: AppStyles.primaryStyleGreen(
                                  bold: true, size: 11),
                            ),
                            Text(
                              DateFormat(' yyyy ', Get.locale.toString())
                                  .format((appointment!.appointmentDate)),
                              style:
                                  AppStyles.subTitleStyle(bold: true, size: 11),
                            ),
                            Text(
                              '  $time',
                              style: AppStyles.primaryStyle(
                                  opacity: .8, bold: true, fontSize: 11),
                            ),
                            UiHelper.horizontalSpaceMedium,
                            SvgPicture.asset(
                              AppImages.calendar,
                              color: AppColors.primaryColorGreen,
                              width: 18.w,
                              height: 18.h,
                            ),
                          ],
                        ),
                        UiHelper.verticalSpaceTiny,
                        Row(children: [

                          Text("${AppStrings.appointmentStatus.tr} : ",style: AppStyles.primaryStyle(),),
                          Text(getStatusName(appointment!.state.toLowerCase()),style: AppStyles.primaryStyle(bold: true),),

                        ],),
                        UiHelper.verticalSpaceTiny,
                        if ( !['canceled','completed','requestcancellation','visit_done'].contains(appointment!.state.toLowerCase()))
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    cancelRefundRequestBottomSheet();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 5.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColorGreen,
                                        borderRadius: BorderRadius.circular(5.h)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.clear,
                                          color: AppColors.white,
                                          size: 20.sp,
                                        ),
                                        UiHelper.horizontalSpaceTiny,
                                        Expanded(
                                          child: Text(
                                            AppStrings.cancelRequest.tr,
                                            style: AppStyles.primaryStyle(
                                                color: AppColors.white,
                                                bold: true,
                                                fontSize: 10),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )),
                  if ((appointment!.state.toLowerCase() == 'start') &&
                      homeService!.icon == AppImages.iconTeleMed)
                    Container(
                      width: 25.w,
                      // height: h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(ar ? 0 : radius.h),
                          bottomRight: Radius.circular(ar ? 0 : radius.h),
                          topLeft: Radius.circular(ar ? radius.h : 0),
                          bottomLeft: Radius.circular(ar ? radius.h : 0),
                        ),
                      ),
                      padding: EdgeInsets.all(0),
                      child: RotatedBox(
                          quarterTurns: ar ? 3 : 1,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  AppStrings.startMeeting.tr,
                                  style: AppStyles.primaryStyle(
                                      fontSize: 11, color: AppColors.white),
                                ),
                              ),
                            ],
                          )),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  cancelRefundRequestBottomSheet(){


    Get.bottomSheet(
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: 50.h, horizontal: 30.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.sendCancelAppointment.tr,
                textAlign: TextAlign.center,
                style: AppStyles.primaryStyle(
                    bold: true, fontSize: 16),
              ),

              UiHelper.verticalSpaceLarge,

              Text("* ${AppStrings.reasonMsg.tr}: ",style: AppStyles.primaryStyle(fontSize: 16,color: AppColors.red),),

              UiHelper.verticalSpaceSmall,
              Row(
                children: [

                  Expanded(child: BottomSheetTextForm(controller: reasonCtrl,unit: '',height: 100,isMultiLine: true,isDecimal: false,isInt: false,length: 1000,)),
                ],
              ),

              UiHelper.verticalSpaceMedium,

              Ui.primaryButton(
                  title: AppStrings.sendRequest,
                  onTab: () {

                    if(reasonCtrl.text.isNotEmpty && reasonCtrl.text.trim().length>3){
                      BookingConstants.patient=AppointmentController.user;
                      Map<String, String> data = {
                        ApiKeys.patientId: AppointmentController.user!.id,

                        'appointment_id':
                        '${appointment!.id}',
                        'type': homeService!.code,
                        'reason': reasonCtrl.text,
                      };

                      BookingBaseController()
                          .requestCancelAppointment(
                          data);
                    }else{
                      BaseController().buildFailedSnackBar(msg: AppStrings.reasonMsg.tr);
                    }
                  })
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.h),
              topLeft: Radius.circular(10.h))),
      backgroundColor: AppColors.white,
    );

  }


 String getStatusName(String status){


    List<String> states = [
      'scheduled',
      'completed',
      'visit_done',
      'canceled',
      'requestCancellation',
      'incomplete',
    ];
    List<String> confirmedStates = [
      'head_doctor',
      'team',
      'head_nurse',
      'operation_manager',
      'start'
    ];

    if(confirmedStates.contains(status)){

      return AppStrings.confirmed.tr;
    }
    else if( status==states[0]){

      return AppStrings.unpaid.tr;

    }
    else if( status.toLowerCase()==states[4].toLowerCase()){

      return AppStrings.underReview.tr;

    }

    else if(status==states[1] || status==states[2]){

      return AppStrings.completed.tr;

    }
    else if( status==states[3]){

      return AppStrings.canceled.tr;

    }
    else if( status==states[5]){

      return AppStrings.incomplete.tr;

    }
    else{

      return '';
    }





  }


}
