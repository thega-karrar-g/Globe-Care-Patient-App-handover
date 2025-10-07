import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import 'meeting_logic.dart';

class MeetingPage extends StatelessWidget {
  final MeetingLogic logic = Get.put(MeetingLogic());

  MeetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: SingleChildScrollView(
      child: Column(
        children: [
          myAppBar2(
              title: Get.previousRoute == AppRouteNames.instantConsultation
                  ? AppStrings.meetInstantConsultation
                  : AppStrings.meetTelemedicine),
          Container(
            child: kIsWeb
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.30,
                        child: meetConfig(),
                      ),
                    ],
                  )
                : meetConfig(),
          ),
        ],
      ),
    ));
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: GetBuilder<MeetingLogic>(builder: (logic) {
        return Theme(
          data: ThemeData(unselectedWidgetColor: AppColors.subTitleColor),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              // TextField(
              //   controller: serverText,
              //   decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: "Server URL",
              //       hintText: "Hint: Leave empty for meet.jitsi.si"),
              // ),
              // SizedBox(
              //   height: 14.0,
              // ),
              // TextField(
              //   controller: roomText,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "Room",
              //   ),
              // ),
              // SizedBox(
              //   height: 14.0,
              // ),
              // TextField(
              //   controller: subjectText,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "Subject",
              //   ),
              // ),
              // SizedBox(
              //   height: 14.0,
              // ),
              // TextField(
              //   controller:logic. nameText,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "Display Name",
              //   ),
              // ),
              // SizedBox(
              //   height: 14.0,
              // ),
              // TextField(
              //   controller: emailText,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "Email",
              //   ),
              // ),
              SizedBox(
                height: 14.0,
              ),
              SizedBox(
                height: 14.0,
              ),
              CheckboxListTile(
                  title: Text(
                    AppStrings.audioOnly.tr,
                    style: AppStyles.primaryStyle(),
                  ),
                  checkColor: AppColors.white,
                  activeColor: AppColors.primaryColor,
                  value: logic.isAudioOnly,
                  onChanged: logic.onAudioOnlyChanged,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              SizedBox(
                height: 14.0,
              ),
              CheckboxListTile(
                title: Text(
                  AppStrings.muteAudio.tr,
                  style: AppStyles.primaryStyle(),
                ),
                value: logic.isAudioMuted,
                checkColor: AppColors.white,
                activeColor: AppColors.primaryColor,
                onChanged: logic.onAudioMutedChanged,
              ),
              SizedBox(
                height: 14.0,
              ),
              CheckboxListTile(
                title: Text(
                  AppStrings.muteVideo.tr,
                  style: AppStyles.primaryStyle(),
                ),
                value: logic.isVideoMuted,
                checkColor: AppColors.white,
                activeColor: AppColors.primaryColor,
                onChanged: logic.onVideoMutedChanged,
              ),
              Divider(
                height: 48.0,
                thickness: 2.0,
              ),
              Ui.primaryButton(
                title: AppStrings.startMeeting,
                onTab: () {
                  logic.joinMeeting(logic.meetingUrl);
                },
              ),
              SizedBox(
                height: 48.0,
              ),
            ],
          ),
        );
      }),
    );
  }
}
