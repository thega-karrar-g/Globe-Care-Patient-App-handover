import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/home_service.dart';
import '../../../data/models/m_appointment.dart';
import '../../../global_widgets/shared/no_data.dart';
import '../../../core/assets_helper/app_anim.dart';
import 'appointment_item2.dart';

class AppointmentList extends StatelessWidget {
  const AppointmentList({required this.appointments, this.homeService, Key? key})
      : super(key: key);

  final List<AppointmentGroup> appointments;

  final HomeService? homeService;

  @override
  Widget build(BuildContext context) {
    return appointments.isNotEmpty
        ?

    // DynamicListView(
    //         data: appointments!,
    //         itemBuilder: (
    //           item,
    //         ) {
    //           return AppointmentItem2(
    //             appointment: item as Appointment,
    //             homeService: homeService,
    //           );
    //         },
    //       )


    GroupListView(
      sectionsCount: appointments.length,
      countOfItemInSection: (int section) {
        return appointments[section].appointments.length;
      },
      itemBuilder: (BuildContext context, IndexPath index) {
        return

        AppointmentItem2(
                    appointment: appointments[index.section].appointments[index.index],
                    homeService: homeService,
                  );

        },

      groupHeaderBuilder: (BuildContext context, int section) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: Text(
            dateConverter(
                appointments[section].dateTime).tr,
            style: AppStyles.primaryStyle(bold: false,fontSize: 15),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 2.h),
      sectionSeparatorBuilder: (context, section) => SizedBox(height: 10.h),
    )





        : NoDataFound(
            animation: AppAnim.noAppointmentFound,
            msg: AppStrings.noAvailableBookings,
          );

    // appointments!.isNotEmpty ? ListView.builder(
    //   itemCount: appointments?.length,
    //   itemBuilder: (bc,index)=>AppointmentItem2(appointment: appointments?[index],)):NoDataFound();
    //
    //
  }


  String dateConverter(DateTime myDate) {
    String date='Today';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final dateToCheck = myDate;
    final checkDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (checkDate == today) {
      date = AppStrings.today;
    } else if (checkDate == yesterday) {
      date = AppStrings.yesterday;
    }
    else {
      date = DateFormat("d MMM yyyy",Get.locale.toString()).format(myDate);
    }
    return date;
  }

}
