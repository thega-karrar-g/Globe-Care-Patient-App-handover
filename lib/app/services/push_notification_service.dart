import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

import 'local_notification_service.dart';

class PushNotificationService {
  final globcareDoctorServerKey =
      'AAAAxEhFwTs:APA91bEZEBXZwOpgzHXgC1PR12uxxLBUn7UwIc9yaKaQB9Akw0cpWCY00fXiF1sZ_0ktCjONT3FWVE7utFnaRgG732ig_QBCSgiUiMJNqrO79ChxTh8inYUsOsTsbHJBr5AqmuYr1oKp';

 static  String patientAccessToken="ya29.c.c0ASRK0GbEwJnIyFy-bATg2eIoVvhxcgxKf35RMBB6YkSOn_hDcykz-aK-anW_hZBrlkmM-R7ohKsqQnx64bQ2r-xNbQs92LYT5_Zf-bl_OXXlSUkclYPhCnhyBNoExU3eShJveJ7NNQHP_QM37H6-sp_zyJZhzgZIrybU3bDKh_M74T0kz3LyTdQvGYq_egEmljHDT6omyo3aNVY2jz99lgrRp9IAcUibnpM7xRd2oFySYzP5xYJVVZMsSidHjIcLVIHPgyJx_Mn64BOeVjSN0NmesnIzaeii17mNOPtBL7jIYBp5WAR7hSVPF6O2BuelGJlvDqJ4kSKLMcpbJ_ZbNIUn_0st8w-u2FCEUBxh3btk57ntifwTStDwE385A9eIkF8o0yBr2u2Z3bQlyZokR0ZOh9im8yU7g1e5Y2rf4sBzZZSSOd0QplsUMh41i0cpvyfW3SjviR5uUzs1Q1utwxuRmJxtXd9kRi93rw4Jb0Zo3I_jpQ42ugUqBgVz5jOc_Ur2w4RktUJc2M7fSJ5-seX-cx0Xkat3Zswe1xUOcbyRig7XZQnu7jM68gBejM_izywtOQpjdugRMjinegaQ7zyuvfy3WQuz33uBOcWWrZWS07VvOwMVJ-zylc3IYtb8a6UU8sFcgFXz_F7OWgw2fqFfyvMkqvJ-4do-fZWfb2VouvQ3OlutjgZ-MIM896J7ozV9u17nF02Sg6Mtbskrsa4-OcvkFmx4vrl_050fJ2p_uxI5mQ4Og3u2bUaka8uoqW511eV6IoQh-Qbmv5Vx4eS8Qe3kemkhyqZni5S4g1SyS1_VbuVRYtpqv0cuXglIumQYl_-W10krJyUfbOUwgZ_eJB4_caIBeYQ03bU1IWr8pzI-6OVO-t2rSlR8j947mIVqtmWdq-yMwpoyxiodYIs7XVF9IQims1u4oqea5lFSQFI9FjJkxmZ616U66RUaFq1d2zXX1g2sep8foW4zJjwm9m_tfw7swsnQV8hy";



  static const String privateKeyPatient = '-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCscS7neHmiIw3q\nWd6zbJh6DZ+vZmh9VUDiT0DgFmXFhy/vffsi01AuPOkE8q25MunYVPt4zNDRegpj\nAXT3EtStuZcX1rdJ/Hc6jYXd+5Xn/7/9qWjoOaMCAxy8VsQgjCG391ATF2DSQ/QG\nNkdgvy6H33PYT/Z6ECiv2wpd8mLGoQzt03Yf+ktDgBbClZQYf1vt9WB7wxdnjtoz\nZ4rVLH1azMkoJIXcCygY/Zud1fAXqkFWDxz1Jkt7/mAJmN1JoqnQfsjLwg1oOOOd\nwdzXs2ACyOvyOB30XlXAE6+u/fIvj85t4KW0DUtswsiPRStsNaGvwgQF7o9uFAqP\n//WQp8iHAgMBAAECggEADU4ESO62L8jVm4XIlX5k+1HOxsk3eagYw/1Ka5++xXFL\nRQaq2EKGlrKzZeLVfYsMmNjhuC3RVMA+SepEXIXS6/58RmYWKTq19koSEJEHPWmx\npgAqrHQ5+/9CedOV+U7mkRufTYHJwh9lFg+dDT1i+S/H7+Inib5ybTMQxzPa5ClL\nR/Jq/Slwsh/CZaTeA7DpVn5PqCkgdT5drfAKY6R3pGYavR0xG8IZW86QuuaYSfWl\nyn9ikEhI/IeFttIu7O4FzhwhOIv4SsVBQN39WUrvybr6agijtr9eTlt0LFWloMan\n0ST0zFJd1/a6xETh33tSJlgRXqzPUUEiahhWrrwC3QKBgQDqnVBfOtvlOeCJd66z\nJu/LqhvOHGJOfpiBbT5cQrZGDWuir2xEeQ+Q6JN76qMDgZI7axubGt6qbqJ0MIJl\nfmY6Gn9QvgXa77emH+5vM6LjjpT/2SDMTOm/eEgrK8zDMv/Opm/4JIVwMg6En9As\nsRBHueXXJ+BSMt2ySeeo3wYLUwKBgQC8KRaSX1aNWM68bptCBQfuDtw43SYTY+VQ\neyT9EvZxLT5cqF03Fh5+G5XDYbjgQXJ7hOBd5fuFkhRlpC/R7l/dL+NNl90dCv6L\nBZ95Hn5YOKAoS0K4SFjDqC1nt0WjnKIx9iFsQwyEtv3xT4qOKrHWUcoQoUsEs7WJ\n9BcYhKObfQKBgEtyKU1mbR5KvWUXgquD4usYmfZu9EIPvdUpHzumDF18pVdcmDFw\nyMutrvfTXXacLT1EVU1Ml7ww9bbtfpFK027t5HE/mjxsiB8494D1FvWcfVfFKCHq\nveRftr2DSUagWNjIdwtSG0MYJckKZ3RnwDeAlWPaI+3rA5X45DFO/u+XAoGAM1Tm\nQoJd42vB4qguFQG4WxqUu7KhS5LqIV2nBp+gudmE9NQ9seSH5xFxdv72578TE115\ntEQkrRjgFaaIITZt0rLYyPdQLDcuoBClo+5Mu5afIr79cbbS+HWuBWh7SBpYKVcj\nYRydkqs1dhqkCwrcv0JK5OSLybmZIgyELH0rASUCgYEAu+yY4pT91QS+LE8060dF\nl4Mbc58utPJ5y3oBETxTOof28QsoXK40o1QmWilxBBAcpsXjEaqrF8syVubHAg7I\nRW0RdqyYyAiyykgdMZvdcB/ikpAJwa6jYHEcRhLbbp/W1oOrMBzgY1YNz5WREcU7\nQZC7mfVlkVPhuXb+5WPGVPM=\n-----END PRIVATE KEY-----\n'; // copy value from downloaded json file



 static const String clientEmailPatient="firebase-adminsdk-czs5v@globe-care-doctor.iam.gserviceaccount.com";

Logger logger=Logger();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final LocalNotificationService _localNotification =
      LocalNotificationService.instance;
  static bool supportIconBadge = false;

  //static const String currentTopic = '/topics/test3';

  static const String androidTopic = 'android_new_instant_consultation';
  // static const String androidTestTopic = 'android_new_consultation_test';
  // static const String androidTestTopicNew = 'android_new_consultation_test_new';

  static const String iosTopic = 'ios_new_instant_consultation';
  // static const String iosTestTopic = 'ios_new_consultation_test';
  static const String notificationTitle = 'New Consultation';
  static const String notificationBody =
      'A new consultation request is waiting by ';

  // var _lastOnResumeCall = DateTime.now().microsecondsSinceEpoch;

  getToken() async {

await FirebaseMessaging.instance.requestPermission(
  provisional: true
);


String fcmToken='';
    if(Platform.isIOS){
 await Future.delayed(Duration(seconds: 1));
     var apnsToken = await FirebaseMessaging.instance.getAPNSToken() ?? '' ;
   //  print("*********    $apnsToken");
      fcmToken = await FirebaseMessaging.instance.getToken()  ?? '';

    }

    else{
      fcmToken = await FirebaseMessaging.instance.getToken()  ?? '';


    }
    // print('fcm token is ====>');
    // print(fcmToken);
    // // logger.i(fcmToken);
    // print('========');



    return fcmToken;
  }

  subscribeToTopic({String topic = 'news'}) async {
     await _fcm.subscribeToTopic(topic);

    print('fcm subscribe to $topic done ====>');
  }

  ///topics/mytargettopic

  initialise() async {

    // init local
    _localNotification.initializing();
    // await doesPlatformSupportIconBadge();
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );



    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,


    );
    // FirebaseMessaging.instance.subscribeToTopic("ios_notifications");
    // resetIconCounter();
    await _fcmConfig();


    if(Platform.isAndroid){
      subscribeToTopic(topic: 'globcare_news_android');
    }
    else{
      subscribeToTopic(topic: 'globcare_news_ios');
    }

    // getOAuthToken();

  }



/*  doesPlatformSupportIconBadge() async {
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        supportIconBadge = true;
      } else {
        supportIconBadge = false;
      }
    } on PlatformException {
      supportIconBadge = false;
    }
  }*/

/*  resetIconCounter() async {
    if (supportIconBadge) FlutterAppBadger.removeBadge();
  }*/

  _fcmConfig() async {
    //--- 1

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //--- 2
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('==> Got a message whilst in the foreground! (onMessage)');
      print('Message data: ${message.data}');


      await _localNotification.showNotification(message);


    });
    //3 =>onOpenFromTerminatedState
    onOpenFromTerminatedState();
  }

  // subscribeToAllNotification() async {
  //   await _fcm
  //       .subscribeToTopic('subscribeToAlalamiyaForOudAppAllNotifications');
  // }

  onOpenFromTerminatedState() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      print('=====> initialMessage');
      print('=====> iniMessage.data ===>  ${initialMessage.data} //end');
      print(
          'initMessage.notification.title ===>  ${initialMessage.notification?.title}');
      print(
          'initMessage.notification.body ===>  ${initialMessage.notification?.body}');

      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      // if (initialMessage?.data['type'] == 'chat') {
      //   // Navigator.pushNamed(context, '/chat',
      //   //     arguments: ChatArguments(initialMessage));
      // }
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('=====> onMessageOpenedApp');
      print('=====> message.data ===>  ${message.data} //end');
      print('message.notification.title ===>  ${message.notification?.title}');
      print('message.notification.body ===>  ${message.notification?.body}');
       _localNotification.showNotification(message);

      // if (message.data['type'] == 'chat') {
      //   Navigator.pushNamed(context, '/chat',
      //       arguments: ChatArguments(message));
      // }
    });
  }


  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      // "type": "service_account",
      // "project_id": "globe-care-6b8d8",
      // "private_key_id": "a52223a0946f2eb777c04d4ec9ab3c03af5f2838",
      // "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCscS7neHmiIw3q\nWd6zbJh6DZ+vZmh9VUDiT0DgFmXFhy/vffsi01AuPOkE8q25MunYVPt4zNDRegpj\nAXT3EtStuZcX1rdJ/Hc6jYXd+5Xn/7/9qWjoOaMCAxy8VsQgjCG391ATF2DSQ/QG\nNkdgvy6H33PYT/Z6ECiv2wpd8mLGoQzt03Yf+ktDgBbClZQYf1vt9WB7wxdnjtoz\nZ4rVLH1azMkoJIXcCygY/Zud1fAXqkFWDxz1Jkt7/mAJmN1JoqnQfsjLwg1oOOOd\nwdzXs2ACyOvyOB30XlXAE6+u/fIvj85t4KW0DUtswsiPRStsNaGvwgQF7o9uFAqP\n//WQp8iHAgMBAAECggEADU4ESO62L8jVm4XIlX5k+1HOxsk3eagYw/1Ka5++xXFL\nRQaq2EKGlrKzZeLVfYsMmNjhuC3RVMA+SepEXIXS6/58RmYWKTq19koSEJEHPWmx\npgAqrHQ5+/9CedOV+U7mkRufTYHJwh9lFg+dDT1i+S/H7+Inib5ybTMQxzPa5ClL\nR/Jq/Slwsh/CZaTeA7DpVn5PqCkgdT5drfAKY6R3pGYavR0xG8IZW86QuuaYSfWl\nyn9ikEhI/IeFttIu7O4FzhwhOIv4SsVBQN39WUrvybr6agijtr9eTlt0LFWloMan\n0ST0zFJd1/a6xETh33tSJlgRXqzPUUEiahhWrrwC3QKBgQDqnVBfOtvlOeCJd66z\nJu/LqhvOHGJOfpiBbT5cQrZGDWuir2xEeQ+Q6JN76qMDgZI7axubGt6qbqJ0MIJl\nfmY6Gn9QvgXa77emH+5vM6LjjpT/2SDMTOm/eEgrK8zDMv/Opm/4JIVwMg6En9As\nsRBHueXXJ+BSMt2ySeeo3wYLUwKBgQC8KRaSX1aNWM68bptCBQfuDtw43SYTY+VQ\neyT9EvZxLT5cqF03Fh5+G5XDYbjgQXJ7hOBd5fuFkhRlpC/R7l/dL+NNl90dCv6L\nBZ95Hn5YOKAoS0K4SFjDqC1nt0WjnKIx9iFsQwyEtv3xT4qOKrHWUcoQoUsEs7WJ\n9BcYhKObfQKBgEtyKU1mbR5KvWUXgquD4usYmfZu9EIPvdUpHzumDF18pVdcmDFw\nyMutrvfTXXacLT1EVU1Ml7ww9bbtfpFK027t5HE/mjxsiB8494D1FvWcfVfFKCHq\nveRftr2DSUagWNjIdwtSG0MYJckKZ3RnwDeAlWPaI+3rA5X45DFO/u+XAoGAM1Tm\nQoJd42vB4qguFQG4WxqUu7KhS5LqIV2nBp+gudmE9NQ9seSH5xFxdv72578TE115\ntEQkrRjgFaaIITZt0rLYyPdQLDcuoBClo+5Mu5afIr79cbbS+HWuBWh7SBpYKVcj\nYRydkqs1dhqkCwrcv0JK5OSLybmZIgyELH0rASUCgYEAu+yY4pT91QS+LE8060dF\nl4Mbc58utPJ5y3oBETxTOof28QsoXK40o1QmWilxBBAcpsXjEaqrF8syVubHAg7I\nRW0RdqyYyAiyykgdMZvdcB/ikpAJwa6jYHEcRhLbbp/W1oOrMBzgY1YNz5WREcU7\nQZC7mfVlkVPhuXb+5WPGVPM=\n-----END PRIVATE KEY-----\n",
      // "client_email": "firebase-adminsdk-9eqtz@globe-care-6b8d8.iam.gserviceaccount.com",
      // // "client_email": "firebase-adminsdk-czs5v@globe-care-doctor.iam.gserviceaccount.com",
      // "client_id": "109980129938433578445",
      // "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      // "token_uri": "https://oauth2.googleapis.com/token",
      // "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      // "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-9eqtz%40globe-care-6b8d8.iam.gserviceaccount.com",
      // "universe_domain": "googleapis.com"


      "type": "service_account",
      "project_id": "globe-care-doctor",
      "private_key_id": "87f42fb6e9959647a8157c13f9a3823cfbe2f50e",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCe/J/I80ObkZ6D\ntowi5zajwgXsbmxUhRbh/qgUOVqki5jEbs+HPfSgSU0zTf/fpB55dRa1uuTa2Yih\nlcDnmXTWl9iIWmncOu9zIY2b+zC2iA+imagfznk9Kz9j/iFvL9Kg8FoibtHiQ2Uo\nsDlCVdk+TTUOBhHlOKk7O8g3/MmMnyWKk/FALfN/3VwKxGHtFNY9r60viNs4IzKo\nK3H44zyldwUYZrMtjGkmi5bZEBNZRfHHpVdSC4eZ17+tPV6xFjiahkXfAblckU7J\n36Z4wIoRbnYDpy2+QSSFFvd5D1PpdjJ2OfB1bgtsNCKKjlNVrNgPPvkFcz94jaAF\n96z7G0lpAgMBAAECggEAJsARG/P63wCTn6vPJTSwsyI3umRBoCoeJTAh/GfsSV3C\n+uG9UEvQA39KQz54JqTETrs0sU+ftx29OREchvZ2rVUuUDGlSqnMsgWUE9gaC+tG\n0E1eVn5HO5r+ZNtMf+KqllJuzaSwIFNn5Q5qrlnpTM+ZplThaLqyOL898jN5Vn4T\nOezmI+QDIBFiaYz4w6NfujfeHuhg8sdmHkgTD/xhVfkz0aI2Bec3fhbNN+Mu5svA\nxqtsNfcO8RZEKLG6GWtmv5/LdA/+YUrpJ0OcfRDc34qPXfTrP/FYTAXiwD2pmkhv\nKFRGuazkWi6tgioHdukmirEE2mAOHhucedhbWNRWmQKBgQDUS3d6rEZT10qIVsZl\nmPCKPcqCWfZ9FSWpn+WGVqidmZesj5hztCTJmv1msw/jrtftOI/N2sLbY2HDVZ4P\naQfoMPNI8RZovckNFC0Zu1K0s4a5wmj2E9bBqQt1IBIMI9od4+tcGW/GdZYvi+NB\nqVgc9POq4wv35jAyI8oB0iporQKBgQC/t61HKqXj+nYFAoIOLCdBhEn4BpS3yWFh\n3lpExbqMSiamuPcGZNSzmPLrAcQrkDMov4NeaZW61apM6IlAoYADAPfdp+Zrc70B\nxODcyBz03EqnFWG+ty/s7isFXt9cfr9req9UtfC5/OxGn7PNKy3iHzKC7XH4KmWo\nUzNETG/PLQKBgEYy+jw3UT4SF9RDlXEtBIVB73/xDZ/I6V5QwE4Ow8zxaAUoqonA\nDNYZiSd3mI56V25a4Lp6VyrCjyZPXmfMHFA8N4ZsKjPSZfQMMumqVqvoHWm5jomo\nf8AkDOTbCPy4sjxmDIK06pAee94XDLu+qqNQoG5mi6Oam19JFFhLzbg1AoGAGm1t\nW2QLnhOGdUZVOzLm7mcX8zKlCXifDeiitNw0zOXj0hOpKZ54m5E32yFRM1gbVUCh\nEUCovSp64UMkuF4K0V8uy8U7RBCeO0IyZPzI0RAU0ldmM+34k0Z5c7ISRCPMqzos\nNRcnadvtjgaxuFR9bLA0PEwS68ycWsmtRXrr5rkCgYB+7Qz0QYufLswzipV/BVTR\nvO59kR+jltO36opb9Z03QHFtVTGn1E/+Qe2ZNK34XRe+v8TAynevpK8bNxtHZaYK\nZ5Jb7ETSdOd2x/tGejMuK5cP53bGRGXuy9zZDbUyGOqNR504Dt4mNWVqPjuMOTWp\nquPuGHytnXIve8T9F4GPWw==\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-czs5v@globe-care-doctor.iam.gserviceaccount.com",
      "client_id": "106336998932039372982",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-czs5v%40globe-care-doctor.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }
    ;

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
      await auth.obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
          scopes,
          client);

      client.close();

      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  void sendPushMessage(
      {String body = '',
      String title = '',
      String to = '',
      bool isIos = false,bool isTopic=false}) async {
    try {

      String  accessToken= await getAccessToken() ?? '';

      if(accessToken.isEmpty){
        return;
      }

      var bodyData = <String, dynamic>{
        // 'priority': 'high',
        // "sound": "notification.caf",



        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          "sound": "new_consultation.mp3",
          'body': body,
          'title': title,
        },
        isTopic? "topic":'token': to,
      };

      bodyData['android']=       {

        // "sound": "new_consultation.mp3",
        "priority": "high",
        // "notification": {
        //   "sound": 'new_consultation.mp3'
        // },
      };

      if (isIos) {

        bodyData['notification']=       {
    'body': body,
    'title': title,

  };

        bodyData['apns'] =

        {
          "payload":{
            "aps":{
              'sound': "notification.caf"
            }
          },
        };



      }

      print(bodyData);

   var result=   await http.post(
        // Uri.parse('https://fcm.googleapis.com/fcm/send'),
        Uri.parse('https://fcm.googleapis.com/v1/projects/globe-care-doctor/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(  { "message":bodyData }),
      );

      logger.i(result.body);
      print('done **************************************');
    } catch (e) {
      print("error push notification");
    }
  }



}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /// If you're going to use other Firebase services in the background, such as Firestore,
  /// make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("==>Handling a background message.id: ${message.messageId}");
  print("message.data == >: ${message.data}");
  // print("message.notification.title == >: ${message?.notification?.title}");
  // print("message.notification.body == >: ${message?.notification?.body}");
/*  if (true */ /*message.notification == null*/ /*) {
  }*/
  // await PushNotificationService.addIconCounter();
  LocalNotificationService.instance.showNotification(message,isAppTerminated: true);



}
