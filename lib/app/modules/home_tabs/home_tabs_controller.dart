import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base_controller/base_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/my_flutter_app_icons.dart';
import '../appointment/appointment_types_view.dart';
import '../home_screen/home_screen_view.dart';
import '../medical_file_module/medical_file/medical_file_view.dart';
import '../my_profile_module/my_profile/my_profile_view.dart';

class HomeTabsController extends BaseController
    with GetSingleTickerProviderStateMixin {
  DateTime? currentBackPressTime;

  int _currentPageIndex = 0;

  int get getCurrentIndex => _currentPageIndex;

  changePageIndex(int newValue) {

    // print(currentUser!.name);
    //if(newValue!=2){
    _currentPageIndex = newValue;

    update();
    //}
  }

  late PageController pageController;

  final autoSizeGroup = AutoSizeGroup();

  late AnimationController animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    MyFlutterApp.home,
    MyFlutterApp.appointment,
    MyFlutterApp.medicalFile,
    MyFlutterApp.person,
  ];

  final titles = [
    AppStrings.bookNow,
    AppStrings.appointments,
    AppStrings.medicalFile,
    AppStrings.myProfile,
  ];

  List<Widget> get tabs  => checkUserSignIn ? [
    HomeScreenView(),
    //  AppointmentPage(),
    AppointmentTypesPage(),
    // Container(),
    MedicalFilePage(),
    MyProfilePage(),
  ]:  [];





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();



    changePageIndex(Get.locale.toString() == 'ar' ? 3 : 0);
    pageController = PageController(initialPage: getCurrentIndex);

    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 2),
      () => animationController.forward(),
    );
  }
}
