import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/slides_model.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import 'our_services_logic.dart';

class OurServices extends StatefulWidget {
  OurServices({Key? key}) : super(key: key);

  @override
  State<OurServices> createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  final OurServicesLogic logic = Get.put(OurServicesLogic());

  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  List<String> items = [
    AppImages.intro1Tele,
    AppImages.intro2visit,
    AppImages.intro3Care,
    AppImages.intro4Covid,
    AppImages.intro5Xray,
  ];

  List<SliderModel> slides = [];

  int index = 0;
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  var descending = false;

  var width = 50.0;

  @override
  void initState() {
    super.initState();

    if (Get.arguments == true) {
      slides = [
        SliderModel(
            title: AppStrings.telemedicine,
            description: AppStrings.telemedicineDescription,
            image: AppImages.introCallDoctor),
        SliderModel(
            title: AppStrings.homeVisitDoctor,
            description: AppStrings.hvdDescription,
            image: AppImages.introHvd),
        SliderModel(
            title: AppStrings.nurse,
            description: AppStrings.nurseDescription,
            image: AppImages.introNurse),
        SliderModel(
            title: AppStrings.physiotherapist,
            description: AppStrings.physiotherapyDescription,
            image: AppImages.introPhy),
      ];
    } else {
      slides = [
        SliderModel(
            title: AppStrings.telemedicine,
            description: AppStrings.telemedicineDescription,
            image: AppImages.introCallDoctor),
        SliderModel(
            title: AppStrings.homeVisitDoctor,
            description: AppStrings.hvdDescription,
            image: AppImages.introHvd),
        SliderModel(
            title: AppStrings.geriatricCare,
            description: AppStrings.geriatricDescription,
            image: AppImages.introGer),
        SliderModel(
            title: AppStrings.covidPCR,
            description: AppStrings.pcrDescription,
            image: AppImages.introCorona),
        // Slide(title: AppStrings.homeRadiology,description:AppStrings.radiologyDescription ,image: AppImages.iconXRay),
        SliderModel(
            title: AppStrings.sleepMedicine,
            description: AppStrings.sleepDescription,
            image: AppImages.introSleep),
        SliderModel(
            title: AppStrings.manHealth,
            description: AppStrings.manHealthDescription,
            image: AppImages.introMan),
        SliderModel(
            title: AppStrings.nurse,
            description: AppStrings.nurseDescription,
            image: AppImages.introNurse),
        SliderModel(
            title: AppStrings.homeLaboratory,
            description: AppStrings.homeLaboratoryDescription,
            image: AppImages.introLab),
        SliderModel(
            title: AppStrings.physiotherapist,
            description: AppStrings.physiotherapyDescription,
            image: AppImages.introPhy),
      ];
    }

    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (!descending) {
        if (_currentPage < slides.length - 1) {
          _currentPage++;
          if (_currentPage == slides.length - 1) {
            descending = true;
          }
        }
      } else {
        if (descending) {
          _currentPage--;

          if (_currentPage == 0) {
            descending = false;
          }
        }
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: UiHelper.safeAreaPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
//           InOutAnimation(
//             key: UniqueKey(),
//             child: Container(
//               height: 100,
//               width: 200,color: AppColors.primaryColorGreen,
//               child: Text(
//                 'In & Out',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             inDefinition: FadeInAnimation(
// preferences: AnimationPreferences(
//   duration: Duration(seconds: 2)
// )
//             ),
//             outDefinition: BounceOutDownAnimation(),
//
//           ),

            Expanded(
              child: SlideInLeft(
                key: UniqueKey(),
                preferences: AnimationPreferences(
                    duration: Duration(milliseconds: 2000)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        // height: Get.height*.7,
                        child: PageView.builder(
                            controller: _pageController,
                            itemCount: slides.length,
                            itemBuilder: (_, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UiHelper.verticalSpaceLarge,
                                  Ui.titleGreenUnderLine(
                                      slides[index].title!.tr,
                                      fontSize: 18,
                                      bottomPadding: 5),
                                  UiHelper.verticalSpaceSmall,
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          slides[index].description!.tr,
                                          style: AppStyles.primaryStyle(
                                              bold: false,
                                              fontSize: 16,
                                              opacity: .8,
                                              height: 1.5),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: SizedBox(
                                      //   color: AppColors.primaryColorGreen,
                                      child: Image.asset(
                                        slides[index].image!,
                                        height: 500.h,
                                        fit: BoxFit.contain,
                                        width: Get.width * .8,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    UiHelper.verticalSpaceMedium,
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: slides.length,
                      effect: CustomizableEffect(
                        activeDotDecoration: DotDecoration(
                          width: 10,
                          height: 10,
                          color: AppColors.primaryColor,

                          // rotationAngle: 180,
                          //  verticalOffset: -10,
                          borderRadius: BorderRadius.circular(24),
                          // dotBorder: DotBorder(
                          //   padding: 2,
                          //   width: 2,
                          //   color: Colors.indigo,
                          // ),
                        ),
                        dotDecoration: DotDecoration(
                          width: 16,
                          height: 5,
                          color: AppColors.subTitleColor,
                          // dotBorder: DotBorder(
                          //   padding: 2,
                          //   width: 2,
                          //   color: Colors.grey,
                          // ),
                          // borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(2),
                          //     topRight: Radius.circular(16),
                          //     bottomLeft: Radius.circular(16),
                          //     bottomRight: Radius.circular(2)),
                          borderRadius: BorderRadius.circular(16),
                          verticalOffset: 0,
                        ),
                        spacing: 6.0,
                        // activeColorOverride: (i) => colors[i],
                        inActiveColorOverride: (i) => AppColors.subTitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (Get.arguments == true)
              Column(
                children: [
                  Ui.primaryButton(
                      title: AppStrings.getStarted,
                      marginH: Get.width * .2,
                      onTab: () {
                        logic.navToLogin();
                      }),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                logic.navToLogin();
                              },
                              child: Text(
                                AppStrings.skip.tr,
                                textAlign: TextAlign.center,
                                style: AppStyles.subTitleStyle(
                                    bold: true, size: 20),
                              )))
                    ],
                  ),
                ],
              )
            else
              Column(
                children: [
                  UiHelper.verticalSpaceMassive,
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                AppStrings.back.tr,
                                textAlign: TextAlign.center,
                                style: AppStyles.primaryStyle(
                                    bold: true, fontSize: 20),
                              )))
                    ],
                  ),
                ],
              ),

            UiHelper.verticalSpaceMassive,
            UiHelper.verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}
