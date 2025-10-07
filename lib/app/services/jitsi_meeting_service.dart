
import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

class JitsiMeetingService{


  JitsiMeetingService._();

  static final JitsiMeetingService _instance = JitsiMeetingService._();

  static JitsiMeetingService get instance => _instance;


  final _jitsiMeetPlugin = JitsiMeet();
  List<String> participants = [];

  join({required String meetingUrl,required String subject ,required String userDisplayName}) async {

    Uri uri=Uri.parse(meetingUrl);
    var room=meetingUrl.substring(meetingUrl.lastIndexOf('/') + 1);
// print(meetingUrl);

    var options = JitsiMeetConferenceOptions(
      room:room ,
      serverURL: uri.origin,
      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
        "subject": subject
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
        "ios.screensharing.enabled": true,
        "invite.enabled": false,
        "add-people.enabled": false,
        "ios.recording.enabled": false,
        "android.screensharing.enabled": false,
        "live-streaming.enabled": false,
        "recording.enabled": false,
        "settings.enabled": false,
        "prejoinpage.enabled": false,
      },
      userInfo: JitsiMeetUserInfo(
        displayName: userDisplayName,
        email: "",

      ),
    );

    var listener = JitsiMeetEventListener(
      conferenceJoined: (url) {
        debugPrint("conferenceJoined: url: $url");
      },
      conferenceTerminated: (url, error) {
        debugPrint("conferenceTerminated: url: $url, error: $error");
      },
      conferenceWillJoin: (url) {
        debugPrint("conferenceWillJoin: url: $url");
      },
      participantJoined: (email, name, role, participantId) {
        debugPrint(
          "participantJoined: email: $email, name: $name, role: $role, "
              "participantId: $participantId",
        );
        participants.add(participantId!);
      },
      participantLeft: (participantId) {
        debugPrint("participantLeft: participantId: $participantId");
      },
      audioMutedChanged: (muted) {
        debugPrint("audioMutedChanged: isMuted: $muted");
      },
      videoMutedChanged: (muted) {
        debugPrint("videoMutedChanged: isMuted: $muted");
      },
      endpointTextMessageReceived: (senderId, message) {
        debugPrint(
            "endpointTextMessageReceived: senderId: $senderId, message: $message");
      },
      screenShareToggled: (participantId, sharing) {
        debugPrint(
          "screenShareToggled: participantId: $participantId, "
              "isSharing: $sharing",
        );
      },
      chatMessageReceived: (senderId, message, isPrivate, timestamp) {
        debugPrint(
          "chatMessageReceived: senderId: $senderId, message: $message, "
              "isPrivate: $isPrivate, timestamp: $timestamp",
        );
      },
      chatToggled: (isOpen) => debugPrint("chatToggled: isOpen: $isOpen"),
      participantsInfoRetrieved: (participantsInfo) {
        debugPrint(
            "participantsInfoRetrieved: participantsInfo: $participantsInfo, ");
      },
      readyToClose: () {
        debugPrint("readyToClose");
      },
    );
    await _jitsiMeetPlugin.join(options,listener);
  }



closeMeeting()async{

  //  print("*********************************  close");

var close=  await _jitsiMeetPlugin.hangUp();


}


}
