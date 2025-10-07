import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/m_appointment.dart';
import '../../../global_widgets/ui.dart';

class AppointmentItem extends StatelessWidget {
  AppointmentItem({this.appointment, Key? key}) : super(key: key);

  final Appointment? appointment;
  final DateFormat dateFormat = DateFormat("dd MMM yyyy HH:mm a");

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
      title: Column(
        children: [
          SizedBox(height: 6.0),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: AppColors.primaryColor.withOpacity(.1), blurRadius: 3)
            ], color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Ui.circularImg(
                        url: '', size: 60, errorImg: AppImages.doctorImg),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${appointment!.doctor}',
                          style: (AppStyles.primaryStyle(
                              color: AppColors.filedBg,
                              fontSize: 14,
                              bold: true)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${appointment!.appointmentType}',

                          style: (
                              AppStyles.primaryStyle(color: AppColors.black, fontSize: 12)),
                        ),
                      ],
                    )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.registerFiled,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.calendarAlt,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //   Expanded(child: Text('${prescription!.doctor}',style: Get.textTheme.subtitle1,)),
                            Expanded(
                                child: Text(
                              DateFormat('EEE, MMM dd')
                                  .format(appointment!.appointmentDate),
                              style: (AppStyles.primaryStyle(
                                  fontSize: 13, color: AppColors.black)),
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_alarm_outlined,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //   Expanded(child: Text('${prescription!.doctor}',style: Get.textTheme.subtitle1,)),
                            Expanded(
                                child: Text(
                              DateFormat('HH:mm a').format(DateTime.parse(
                                  appointment!.visitTime.toString())),
                              style: AppStyles.primaryStyle(
                                  fontSize: 13, color: AppColors.black),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.registerFiled)),
                        child: Text(
                          AppStrings.cancel.tr,
                          style: AppStyles.primaryStyle(),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.filedBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.filedBg)),
                        child: Text(
                          AppStrings.reschedule.tr,
                          style: AppStyles.primaryStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVisitTypeButton(int? type, {bool past = false}) {
    switch (type) {
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.video,
              size: 14,
              color:
                  !past ? Get.theme.colorScheme.secondary : AppColors.extraGrey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'video_visit',
                style: !past
                    ? (
                        TextStyle(color: Get.theme.colorScheme.secondary))
                    : (TextStyle(color: AppColors.extraGrey)),
              ),
            ),
          ],
        );

      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.mapMarkerAlt,
              size: 14,
              color: AppColors.extraGrey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'clinic_visit',
                style: (TextStyle(color: AppColors.extraGrey)),
              ),
            ),
          ],
        );
      case 3:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.phoneAlt,
              size: 14,
              color: AppColors.extraGrey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'call_visit',
                style: (TextStyle(color: AppColors.extraGrey)),
              ),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }
}
