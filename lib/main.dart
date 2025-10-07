import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/base_controller/connectivity_controller.dart';
import 'app/core/language_and_localization/app_language.dart';
import 'app/core/theme_helper/theme_helpr.dart';
import 'app/modules/appointment/appointment_types_logic.dart';
import 'app/modules/auth/auth_controller.dart';
import 'app/modules/booking_home_modules/instant_consultation_module/instant_consultation_states/instant_consultation_states_logic.dart';
import 'app/modules/drawer_module/settings/controllers/theme_mode_controller.dart';
import 'app/modules/select_patient/select_patient_logic.dart';
import 'app/services/push_notification_service.dart';
import 'app/services/session_service.dart';
import 'start_app.dart';

//flutter run --no-pub
void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  if (Platform.isIOS) {



    await Firebase.initializeApp(
      name: 'Globcare',
        options: FirebaseOptions(
          apiKey: 'AIzaSyAa0wE4khP19gxMSPHKfchUeR7XQhqhIGc',
          appId: '1:979182963538:ios:6432dccffa95f1c2c3c88b',
          messagingSenderId: '979182963538',
          projectId: 'globe-care-6b8d8',
          iosBundleId: 'com.app.globcare',




        )
    );

  } else {
    await Firebase.initializeApp();
  }

  await Get.put(PushNotificationService().initialise());

  // await PushNotificationService().getAccessToken();
  //
  // //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseAuth auth = FirebaseAuth.instance;

  await GetStorage.init();

  Get.put(ConnectivityController());

  await Get.put(SessionService()).setupDb();
  await Get.put(ThemeHelper()).setUpDb();
  await Get.put(ThemeModeController()).initThemeMode();
  await Get.put(AppLanguage()).setUpDB();
  Get.put(AuthController());
  Get.put(SelectPatientLogic());
  Get.put(AppointmentTypesLogic());

  Get.put(InstantConsultationStatesLogic(),permanent: true);

  //Get.put(AppBarLogic());


  // print("*****************************************");
  // log(Platform.version);
  // print("*****************************************");


  runApp(
    const StartMyApp(),
    //  Row(
    //    textDirection: TextDirection.ltr,
    //    crossAxisAlignment: CrossAxisAlignment.stretch,
    //    children: [
    //      /*Expanded(
    //      child: Container(color: Colors.red),
    //    ),*/
    //      Expanded(
    //        child: DevicePreview(
    //          enabled: false,
    //          plugins: const [
    //            ScreenshotPlugin(),
    //            FileExplorerPlugin(),
    //            SharedPreferencesExplorerPlugin(),
    //          ],
    //          builder: (context) => const StartMyApp(),
    //        ),
    //      ),
    //    ],
    //  ),
  );
}
