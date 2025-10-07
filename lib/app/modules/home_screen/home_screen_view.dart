import 'dart:math' as math; // import this

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../core/assets_helper/app_images.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../data/constants/booking_constants.dart';
import '../../data/models/branch.dart';
import '../../data/models/home_service.dart';
import '../../global_widgets/project_widget/image_slider_widget.dart';
import '../../global_widgets/shared/my_appbar.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import '../../global_widgets/ui.dart';
import '../../utils/grid_aspect_ratio.dart';
import 'home_screen_controller.dart';
import 'widgets/card_item.dart';
import 'widgets/guest_widget.dart';
import 'widgets/image_slider_widget.dart';
import 'widgets/instant_consultation_widget.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  static const String id = '/HomeScreenView';

  HomeScreenView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(HomeScreenController(),);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: UiHelper.safeAreaPaddingHome,
      child: SizedBox(
        // color: AppColors.bodyBgColor.withOpacity(.9),
        child: Column(
          children: [
            myAppBarHome(title: 'Hello', withBack: false, isHome: true, h: 10),

            UiHelper.verticalSpace(20),

            Expanded(
              child: GetBuilder<HomeScreenController>(
                init: HomeScreenController(),
                builder: (controller) => SingleChildScrollView(
                  child: ShowCaseWidget(

                    builder:(context) {

                      if (box.read('ICHint') == null) {
                        WidgetsBinding.instance.addPostFrameCallback(
                                (_) => ShowCaseWidget.of(context).startShowCase([languageKey]));

                        box.write('ICHint', true);
                      }


                      return Wrap(
                        children: <Widget>[
                          // HomeSliderWidget(asstsSlides: controller.assetsSlides),
                          // emergencySection(),



                          if(controller.slides.isNotEmpty)
                            ImageSliderWidget(sliders: controller.slides,height: 170,),

                          Showcase(
                            description: AppStrings.instantConsultationHint.tr,
                            descTextStyle: AppStyles.primaryStyle(),
                            targetBorderRadius: BorderRadius.circular(30.h),
                            tooltipPadding:
                            EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                            key: languageKey,
                            targetPadding:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                            child: InstantConsultationWidget(onTab: (){

                              // print(controller.currentUser!.accessToken);
                             controller.navToInstantCon();

                            },),
                          ),
                          UiHelper.verticalSpace(30),



                          if (controller.currentUser == null)
                            UiHelper.verticalSpaceSmall,

                          if (controller.currentUser == null)
                            GuestWidget(),

                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0.w,
                              mainAxisSpacing: 2.0.h,
                              childAspectRatio: GridAspectRatio.aspectRatio(
                                  count: 2, height: (150.h)),
                            ),
                            itemCount: HomeService.homeServices.length -(controller.images.isNotEmpty ?2:0 ),
                            itemBuilder: (bc, index) =>
                                AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    columnCount: 3,
                                    duration: Duration(milliseconds: 500),
                                    child: SlideAnimation(
// flipAxis: FlipAxis.y,
                                        verticalOffset: 150.h,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                        child: FadeInAnimation(
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.fastOutSlowIn,
                                            child: CardItem(
                                              homeService:
                                              HomeService.homeServices[index],
                                              primary: true,
                                              onTab: ()async{
                                                controller.navToServices(HomeService.homeServices[index]);


                                              },
                                            )))),
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 10.h),
                            primary: false,
                            shrinkWrap: true,
                          ),


                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColorOpacity),
                            height: 140.h,
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  UiHelper.verticalSpaceSmall,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Text(
                                            AppStrings.otherServices.tr,
                                            style: AppStyles.primaryStyle(
                                                bold: true, fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      Transform(
                                          transform: Matrix4.rotationY(
                                              Get.locale.toString() == 'ar'
                                                  ? math.pi
                                                  : 0),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.double_arrow_outlined,
                                            color: AppColors.primaryColorGreen,
                                            size: 20.w,
                                          )),
                                      UiHelper.horizontalSpaceSmall,
                                    ],
                                  ),

                                  Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                      HomeService.homeServicesHorizontal.length -(controller.images.isNotEmpty ?0:2 ),
                                      scrollDirection: Axis.horizontal,
                                      controller: controller.scrollController,
                                      itemBuilder: (bc, index) => GestureDetector(
                                        onLongPress: () {
                                        },
                                        child: AnimationConfiguration.staggeredGrid(
                                            position: index,
                                            columnCount: 3,
                                            duration: Duration(milliseconds: 500),
                                            child: SlideAnimation(
// flipAxis: FlipAxis.y,
                                                verticalOffset: 150.h,
                                                duration:
                                                Duration(milliseconds: 500),
                                                curve: Curves.easeInOut,
                                                child: FadeInAnimation(
                                                    duration:
                                                    Duration(milliseconds: 500),
                                                    curve: Curves.fastOutSlowIn,
                                                    child: SizedBox(
                                                        width: 120.w,
                                                        //height: 150,
                                                        child: CardItem(
                                                          homeService: HomeService
                                                              .homeServicesHorizontal[
                                                          index],
                                                          primary: false,

                                                          onTab: (){

                                                            if(HomeService.homeServicesHorizontal[index].code=='HVD'){



                                                              selectBranchSheet((){
                                                                controller
                                                                    .navToServices(
                                                                    HomeService
                                                                        .homeServicesHorizontal[index]);
                                                              });

                                                            }

                                                            else {
                                                              controller
                                                                  .navToServices(
                                                                  HomeService
                                                                      .homeServicesHorizontal[index]);
                                                            }

                                                          },

                                                        ))))),
                                      ),

                                      //  physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(top: 5.h),

                                      // primary: false,
                                      shrinkWrap: true,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),


                          CallUsWidget(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget homeAppBar({double marginTop = 30.0, double paddingV = 50}) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: paddingV),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.welcome.tr,
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    controller.currentUser!.name.split(' ').first,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
//            Get.toNamed(AppRouteNames.account);
            },
            child: Ui.circularImg(
                url: '', errorImg: AppImages.doctorImg, size: 70, margin: 0),
          ),
        ],
      ),
    );
  }

  Widget svgIcon(String url) {
    return SvgPicture.asset(
      url,
      width: 30,
      height: 30,
    );
  }


  selectBranchSheet(Function onTab){

    Get.bottomSheet(SingleChildScrollView(
      child: Column(

        children: [

          UiHelper.verticalSpaceLarge,

          Text(AppStrings.selectBranchMsg.tr,style: AppStyles.primaryStyle(fontSize: 18),),

          UiHelper.verticalSpaceLarge,


          Row(children: [

            Expanded(child: Ui.primaryButton(title: AppStrings.riyadhBranch.tr,paddingH: 10,paddingV: 10,marginH: 10,onTab: (){

              BookingConstants.branch='riyadh';
              // Branch(id: 1,nameAr: 'الرياض',nameEn: 'Riyadh',code: 'riyadh');

              onTab();
            })),
            UiHelper.horizontalSpaceSmall,

            Expanded(child: Ui.primaryButton(title: AppStrings.dammamBranch.tr,paddingH: 10,paddingV: 10,marginH: 10,onTab: (){

              controller.      buildFailedSnackBar(msg: AppStrings.serviceUnavailable.tr);


              // BookingConstants.branch=
              // Branch(id: 2,nameAr: 'الدمام',nameEn: 'Dammam',code: 'dammam');
              // onTab();

            })),


          ],),

          UiHelper.verticalSpaceMassive,





        ],


      ),
    ),


    isScrollControlled: true,

      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r)
      )
    );


  }


}
