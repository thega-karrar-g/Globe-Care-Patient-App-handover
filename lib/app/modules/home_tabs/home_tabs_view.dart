import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../core/theme_helper/my_flutter_app_icons.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import '../appointment/appointment_types_logic.dart';
import '../drawer_module/drawer_widget/main_drawer_widget.dart';
import '../home_screen/home_screen_controller.dart';
import '../home_screen/home_screen_view.dart';
import 'home_tabs_controller.dart';

class HomeTabsView extends StatelessWidget {
  HomeTabsView({Key? key}) : super(key: key);

  final controller = Get.put(HomeTabsController(),permanent: true);


  final GlobalKey<ScaffoldState> parentScaffoldKey = GlobalKey<ScaffoldState>();

  final titles = [
    AppStrings.bookNow,
    AppStrings.appointmentsAndRequests,
    AppStrings.medicalFile,
    AppStrings.myProfile,
  ];
  var ar = Get.locale.toString() == 'ar';
  final Color navigationBarColor = AppColors.white;

  @override
  Widget build(BuildContext context) {
    const Duration duration = Duration(milliseconds: 500);


    // print(controller.tabs.length);
    return GetBuilder<HomeTabsController>(
      builder: (controller) => Scaffold(
        drawer: MainDrawerWidget(),
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        body: controller.checkUserSignIn
            ? Column(
                children: [
                  // homeAppBar(title: 'Home', key: parentScaffoldKey),
                  //   Container(height: Get.height*.1,),
                  Expanded(
                    child: WillPopScope(
                      onWillPop: onWillPop,
                      child:
                          // HomeScreenView()

                          PageView(
                        //  physics: const NeverScrollableScrollPhysics(),
                        controller: controller.pageController,

                        children: ar
                            ? controller.tabs.reversed.toList()
                            : controller.tabs,
                        onPageChanged: (int index) {
                          controller.changePageIndex(index);
                          // controller.   pageController.animateToPage(index,
                          //     duration: duration,
                          //     curve: Curves.easeOutQuad);
                          // print('index:$index');
                        },
                      ),
                    ),
                  ),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      children: [
                        WaterDropNavBar(
                            backgroundColor: navigationBarColor,
                            iconSize: 22.h,
                            bottomPadding: 5.h,
                            onItemSelected: (int index) {
                              controller.changePageIndex(index);
                              controller.pageController.animateToPage(
                                  controller.getCurrentIndex,
                                  duration: duration,
                                  curve: Curves.easeOutQuad);
                            },
                            selectedIndex: controller.getCurrentIndex,
                            inactiveIconColor: AppColors.subTitleColor,
                            waterDropColor: AppColors.primaryColor,
                            barItems:
                                ar ? getItems().reversed.toList() : getItems()),
                        SizedBox(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: Row(
                                children: getTitles(ar)
                                    .map((e) => Expanded(
                                            child: GestureDetector(
                                          onTap: () {
                                            controller.changePageIndex(
                                                getTitles(ar).indexOf(e));

                                            controller.pageController
                                                .animateToPage(
                                                    controller.getCurrentIndex,
                                                    duration: duration,
                                                    curve: Curves.easeOutQuad);
                                          },
                                          child: AnimatedDefaultTextStyle(
                                              style: getTitles(ar).indexOf(e) ==
                                                      controller.getCurrentIndex
                                                  ? AppStyles.primaryStyle(
                                                      fontSize: 10, bold: true)
                                                  : AppStyles.subTitleStyle(
                                                      size: 10, bold: true),
                                              duration: duration,
                                              child: Text(
                                                e.tr,
                                                textAlign: TextAlign.center,
                                              )),
                                        )))
                                    .toList()),
                          ),
                        )
                      ],
                    ),
                  )

//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 0,),
// //padding: EdgeInsets.symmetric(vertical: 10,),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                        borderRadius: BorderRadius.only(
//                        topRight: Radius.circular(10), topLeft: Radius.circular(10)),
//                     boxShadow: [
//                       BoxShadow(color: AppColors.primaryColorGreen.withOpacity(.05), spreadRadius: 0, blurRadius: 10),
//                     ],
//                   ),
//
//                   child: ClipRRect(
//
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10.0),
//                       topRight: Radius.circular(10.0),
//                     ),
//
//                     child: BottomNavigationBar(
//                       backgroundColor:    AppColors.white,
//
//                       currentIndex: controller.getCurrentIndex,
//                       onTap: controller.changePageIndex,
//                       selectedFontSize: 5,
//                       iconSize: 10,
//                       unselectedFontSize: 5,
//                       // elevation: 8.0,
//                       // backgroundColor: Get.theme.primaryColor,
//                       selectedItemColor: AppColors.primaryColor,
//                       type: BottomNavigationBarType.fixed,
//
//                      // iconSize: 24.0.w,
//
//
//                       items:  [
//                         BottomNavigationBarItem(
//                           icon: svgIcon(  AppImages.myHome,selected: controller.getCurrentIndex==0,title: AppStrings.bookNow),
//                           label: '',
//                         ),
//
//                         BottomNavigationBarItem(
//                           icon: svgIcon(  AppImages.appointment,selected: controller.getCurrentIndex==1,title: AppStrings.appointments),
//                           label: '',
//
//                         ),
//
//                         // BottomNavigationBarItem(
//                         //   icon: Container(),
//                         //
//                         //   label: '',
//                         // ),
//
//                         BottomNavigationBarItem(
//                           icon: svgIcon(  AppImages.medicalFile,selected: controller.getCurrentIndex==2,title: AppStrings.medicalFile),
//                           label: '',
//                         ),
//
//                         BottomNavigationBarItem(
//                           icon: svgIcon(  AppImages.person,selected: controller.getCurrentIndex==3,title: AppStrings.myProfile),
//                           label: '',
//
//                         ),
//
//
//
//                         // BottomNavigationBarItem(
//                         //   icon: Icon(FontAwesomeIcons.stethoscope),
//                         //   label: '',
//                         // ),
//                         // BottomNavigationBarItem(
//                         //   icon: Icon(FontAwesomeIcons.solidCalendarCheck),
//                         //   label: '',
//                         // ),
//
//                       ],
//                       showSelectedLabels: false,
//                       showUnselectedLabels: false,
//                     ),
//                   ),
//                 ),
//
//                 // Positioned.fill(
//                 //     top: -20,
//                 //     child:Align(alignment: Alignment.topCenter,
//                 //
//                 // child: GestureDetector(
//                 //
//                 //     onTap: (){
//                 //       Get.toNamed(AppRouteNames.doctors,arguments: AppRouteNames.doctorBook);
//                 //     },
//                 //     child: CircleAvatar(
//                 //       backgroundColor: AppColors.primaryColorGreen,
//                 //
//                 //         radius: 25,
//                 //         child: SvgPicture.asset(AppImages.call,width: 35,height: 35,)))
//                 //       ,
//                 //
//                 // ) )
//               ],
//             )
                ],
              )
            : HomeScreenView(),
      ),
    );
  }

  List<BarItem> getItems() => [
        BarItem(
          filledIcon: MyFlutterApp.home,
          outlinedIcon: MyFlutterApp.home,
        ),
        BarItem(
          filledIcon: MyFlutterApp.appointment,
          outlinedIcon: MyFlutterApp.appointment,
        ),
        BarItem(
          filledIcon: MyFlutterApp.medicalFile,
          outlinedIcon: MyFlutterApp.medicalFile,
        ),
        BarItem(
          filledIcon: MyFlutterApp.person,
          outlinedIcon: MyFlutterApp.person,
        ),
      ];

  List<String> getTitles(bool ar) {
    return ar ? titles.reversed.toList() : titles;
  }

  PreferredSizeWidget buildAppBar(int index) {
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else {}
    return AppBar(
      title: Text(
        AppStrings.appTitle.tr,
        style: (const TextStyle(color: AppColors.white, letterSpacing: 1.5)),
      ),
    );
  }

  Future<bool> onWillPop() async {
    final controller = Get.find<HomeTabsController>();
    DateTime now = DateTime.now();
    if (controller.currentBackPressTime == null ||
        now.difference(controller.currentBackPressTime!) >
            const Duration(seconds: 2)) {
      controller.currentBackPressTime = now;
      controller
          .toastMessage(AppStrings.doubleClickToExitApp.tr.capitalizeFirst!);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget svgIcon(String url, {bool selected = false, String title = ''}) {
    return Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: selected?AppColors.primaryColor:AppColors.bottomNavBG
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              url,
              width: 25,
              height: 25,
              color:
                  selected ? AppColors.primaryColor : AppColors.subTitleColor,
            ),
            UiHelper.verticalSpaceSmall,
            Text(
              title.tr,
              style: selected
                  ? AppStyles.primaryStyle(bold: true, fontSize: 10)
                  : AppStyles.subTitleStyle(bold: true, size: 10),
            ),
            UiHelper.verticalSpaceSmall,
            if (selected)
              Container(
                width: Get.width * .2,
                height: 5,
                decoration: BoxDecoration(
                    color: AppColors.primaryColorGreen,
                    borderRadius: BorderRadius.circular(5)),
              )
          ],
        ));
  }

// Widget _getBody(int index) {
//   return controller.tabs[index] ;
// }

}
