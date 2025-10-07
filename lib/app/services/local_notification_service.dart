import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../data/models/push_notification_model.dart';
// import '../modules/booking_home_modules/instant_consultation_module/instant_consultation_home/instant_consultation_home_view.dart';
import '../routes/app_route_names.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static LocalNotificationService? _instance;

  static LocalNotificationService get instance {
    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    return _instance ??= LocalNotificationService._();
  }

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  AndroidInitializationSettings? androidInitializationSettings;
  DarwinInitializationSettings ? iosInitializationSettings;

  // MacOSInitializationSettings initializationSettingsMacOS;
  InitializationSettings? initializationSettings;
  NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  void initializing() async {
    //Initialisation should only be done once,and this can be done is in the
    // main function of your application. Alternatively, this can be done within
    // the first page shown in your app.
    //-------------
    //initialise the plugin. app_icon needs to be a added
    // as a drawable resource to the Android head project
    // if its in drawable you don't need @drawalbe

    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();

    //android setting init
    androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    //if in drawable
    // AndroidInitializationSettings('ic_launcher');

    //ios setting init
    iosInitializationSettings = DarwinInitializationSettings (

     //   onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    // //MacOS setting init
    // initializationSettingsMacOS = MacOSInitializationSettings(
    //     requestAlertPermission: false,
    //     requestBadgePermission: false,
    //     requestSoundPermission: false);

    //pass init all platform setting to InitializationSettings
    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      // macOS: initializationSettingsMacOS,
    );

    // pass InitializationSettings to flutterLocalNotificationsPlugin
    await flutterLocalNotificationsPlugin?.initialize(
      initializationSettings!,
      onDidReceiveNotificationResponse: onSelectNotification,
    );

    notificationAppLaunchDetails = await flutterLocalNotificationsPlugin
        ?.getNotificationAppLaunchDetails();

    flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
  } //end of initializing

  checkIfInitFromNotification() {
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      print(' / / / checkIfInitFromNotification is true');
      // selectedNotificationPayload = notificationAppLaunchDetails.payload;
      // initialRoute = SecondPage.routeName;
    }
  }

  Future onSelectNotification(NotificationResponse notificationResponse) async {
    // print('badge count is : $badgeCount');
    // bool isAppBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    // if (isAppBadgeSupported) {
    //   FlutterAppBadger.updateBadgeCount(++badgeCount);
    // }

    Get.offAll(AppRouteNames.homeTabs);
    Get.toNamed(AppRouteNames.instantConsultation);


  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // return CupertinoAlertDialog(
    //   title: Text(title),
    //   content: Text(body),
    //   actions: <Widget>[
    //     CupertinoDialogAction(
    //         isDefaultAction: true,
    //         onPressed: () {
    //           print(" got pressed");
    //         },
    //         child: Text("Okay")),
    //   ],
    // );
  }

  Future showNotification(RemoteMessage message, {String? payload,bool isAppTerminated=false}) async {
    String title='', body='';
    PushNotification? pushNotification;
    if (message.data.isNotEmpty) {
      pushNotification = PushNotification.fromMap(message.data);
    }

    String imageUrl="";
    if(pushNotification !=null) {
      title =

isAppTerminated ?         pushNotification.titleAr :

        await getTextByLocal(arTxt: pushNotification.titleAr, enTxt: pushNotification.titleEn);


        body =
        isAppTerminated ?   pushNotification.bodyAr:

         await getTextByLocal(arTxt: pushNotification.bodyAr, enTxt: pushNotification.bodyEn);

      if(Platform.isAndroid  &&  pushNotification.image.isNotEmpty) {

        imageUrl = await downloadFile(pushNotification.image, "large_image${message.hashCode}.png");}


    }





    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel3', // id
      'High Importance Notifications2', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.high,

      //sound: RawResourceAndroidNotificationSound('notification'),
      sound:   UriAndroidNotificationSound("assets/audios/notification.mp3"),
playSound: true,


    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelShowBadge: true,
      onlyAlertOnce: false,
      channelDescription: channel.description,
      //icon: message.notification?.android?.smallIcon,
      playSound: true,
        // sound:  const UriAndroidNotificationSound("assets/audios/notification.mp3"),
          sound: RawResourceAndroidNotificationSound('notification'),

          priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
          styleInformation: imageUrl.isNotEmpty? BigPictureStyleInformation(

              FilePathAndroidBitmap(imageUrl),
              largeIcon:FilePathAndroidBitmap(imageUrl)


              ,contentTitle: title,summaryText: body
          ):BigTextStyleInformation(body),

        );

    DarwinNotificationDetails  iosNotificationDetails = DarwinNotificationDetails (
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future showLocaleNotification(String title, String body,
      {String? payload}) async {
    // String title, body;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelShowBadge: true,
      onlyAlertOnce: false,
      channelDescription: channel.description,
      //icon: message.notification?.android?.smallIcon,
      playSound: true,
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
          styleInformation: BigTextStyleInformation(body),

        );

    DarwinNotificationDetails  iosNotificationDetails = DarwinNotificationDetails (
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin?.show(
      body.hashCode,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }


  Future<String> downloadFile(String url,String fileName)async{
    final directary=await getApplicationDocumentsDirectory();
    final filePath='${directary.path}/$fileName';
    final response=await http.get(Uri.parse(url));
    final file=File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

}

@pragma('vm:entry-point')
Future<String>  getTextByLocal({required String arTxt,required enTxt})async{

  try {

    await GetStorage.init();

    GetStorage appLangBox = GetStorage();

    String code=appLangBox.read("languageCode") ?? 'ar';

    return   code.contains("en") ? enTxt :arTxt;

  }catch (e){
    print("**************************** ");
    print(e.toString());
    return arTxt;
  }

}
