
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../base_controller/base_controller.dart';
import '../../../data/models/m_appointment.dart';

class MeetingLogic extends BaseController {
  Appointment appointment = Get.arguments;

  String room = '';
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  final subjectText = TextEditingController(text: "");
  final nameText = TextEditingController(text: "");
  final emailText = TextEditingController(text: "");
  final iosAppBarRGBAColor = TextEditingController(text: "#0080FF80");

  onAudioOnlyChanged(bool? value) {
    isAudioOnly = value;
    update();
  }

  onAudioMutedChanged(bool? value) {
    isAudioMuted = value;

    update();
  }

  onVideoMutedChanged(bool? value) {
    isVideoMuted = value;
    update();
  }

  joinMeeting(String meetingUrl) async {


    WakelockPlus.enable();


    //String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    // Map<FeatureFlag, Object> featureFlags = {
    //   FeatureFlag.isWelcomePageEnabled: false,
    //   FeatureFlag.isAddPeopleEnabled: false,
    //   FeatureFlag.isInviteEnabled: false,
    //   FeatureFlag.isRaiseHandEnabled: false,
    //   FeatureFlag.isMeetingPasswordEnabled: false,
    //   FeatureFlag.isLiveStreamingEnabled: false,
    //   FeatureFlag.isReplaceParticipantEnabled: false,
    //   FeatureFlag.isRecordingEnabled: false,
    //   // FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
    //   // FeatureFlagEnum.INVITE_ENABLED: false,
    //   // FeatureFlagEnum.RAISE_HAND_ENABLED: false,
    //   // FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
    // };
    //
    // // Define meetings options here
    // var options = JitsiMeetingOptions(
    //   roomNameOrUrl: room,
    //   serverUrl: meetingUrl,
    //   subject: subjectText.text,
    //   // token: tokenText.text,
    //   isAudioMuted: isAudioMuted,
    //   isAudioOnly: isAudioOnly,
    //   isVideoMuted: isVideoMuted,
    //   userDisplayName: nameText.text,
    //   userEmail: emailText.text,
    //   featureFlags: featureFlags,
    // );
    //
    // await JitsiMeetWrapper.joinMeeting(
    //     options: options,
    //     listener: JitsiMeetingListener(
    //       onConferenceWillJoin: (message) {
    //         // debugPrint("${options.room} will join with message: $message");
    //       },
    //       onConferenceJoined: (message) {
    //         // debugPrint("${options.room} joined with message: $message");
    //       },
    //       onConferenceTerminated: (message, er) {
    //         WakelockPlus.disable();
    //
    //         // debugPrint("${options.room} terminated with message: $message");
    //       },
    //     ));
  }





  var meetingUrl = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     meetingUrl = appointment.videoLink;

    room = (meetingUrl.substring(meetingUrl.lastIndexOf('/') + 1));

    nameText.text = currentUser!.name;
    emailText.text = currentUser!.email;
    subjectText.text = appointment.doctor!;

  }


}
