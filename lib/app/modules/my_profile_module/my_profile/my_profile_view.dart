import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/modules/auth/auth_controller.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/home_service.dart';
import '../../../global_widgets/shared/dynamic_grid.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../utils/grid_aspect_ratio.dart';
import '../../medical_file_module/medical_file/widgets/medical_file_item.dart';
import 'my_profile_logic.dart';
import 'widgets/profile_row.dart';

class MyProfilePage extends StatelessWidget {
  final MyProfileLogic logic = Get.put(MyProfileLogic(),);

  MyProfilePage({Key? key}) : super(key: key);
  var img = '';

  @override
  Widget build(BuildContext context) {
    // if(logic.currentUser !=null){
    // if (logic.currentUser!.imageUrl!.isNotEmpty &&
    //     logic.currentUser!.imageUrl!.length > 10) {
    //   img = logic.currentUser!.imageUrl!.replaceAll('https', 'http');
    // }}
    return  Ui.myScaffold(
      child: SizedBox(
        // color: AppColors.bodyBgColor.withOpacity(.9),
        child: GetBuilder<MyProfileLogic>(builder: (logic) {
      Get.find<AuthController>().getUserDetails();

          logic.clearImageCache();
          var nationality = logic.currentUser!.nationality!.contains('KSA')
              ? AppStrings.saudi.tr
              : AppStrings.nonSaudi.tr;
          return logic.checkUserSignIn
              ? Column(
                  children: [
                    myAppBar3(
                        title: AppStrings.myProfile, withBack: false, h: 20),
                    UiHelper.verticalSpaceSmall,
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColorOpacity,
                          borderRadius: BorderRadius.circular(10)),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.w, right: 20.w, top: 15.h),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                logic.currentUser!.name,
                                                style: AppStyles.primaryStyle(
                                                    bold: true, fontSize: 16),
                                              )),
                                            ],
                                          ),
                                          UiHelper.verticalSpaceSmall,
                                          ProfileRow(
                                            iconData: AppImages.phoneCall,
                                            title: logic.currentUser!.phone,
                                          ),

                                          ProfileRow(
                                            iconData: AppImages.medicalFileNo,
                                            title: logic.currentUser!.identificationCode,
                                          ),
                                          ProfileRow(
                                            iconData: AppImages.nationality,
                                            title: nationality,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.w, vertical: 0),
                                            child: Column(
                                              children: [
                                                ProfileRow(
                                                  iconData: AppImages.email,
                                                  title:
                                                      logic.currentUser!.email,
                                                ),
                                                //  ProfileRow(iconData: AppImages.location,title: logic.currentUser!.location,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  UiHelper.horizontalSpaceSmall,
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          logic.navToEdit();
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryGreenOpacityColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:

                                                  //Container()
                                                  // Ui.circluarImgRadiusBase64(url: logic.currentUser!.imageUrl!,rTL: 10,rBR: 10,rBL: 10,rTR: 10,margin: 0),
                                                  Ui.circularImg(
                                                url: img,
                                                margin: 0,
                                                radius: 10.w,
                                              ),
                                            ),

                                            UiHelper.verticalSpaceLarge,
                                            UiHelper.verticalSpaceSmall,
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3.h,
                                                  horizontal:
                                                      Get.locale.toString() ==
                                                              'ar'
                                                          ? 5.w
                                                          : 10.w),
                                              height: 25.h,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryColorGreen,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.h)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppStrings
                                                        .edit.tr.capitalizeFirst
                                                        .toString(),
                                                    style:
                                                        AppStyles.primaryStyle(
                                                            color: AppColors
                                                                .white),
                                                  ),
                                                  Icon(
                                                    Icons.edit,
                                                    size: 18.w,
                                                    color: AppColors.white,
                                                  ),
                                                ],
                                              ),
                                            )

                                            // Positioned.fill(
                                            //     bottom: -15.h,
                                            //     child: Align(
                                            //     alignment:Get.locale.toString()=='ar'? Alignment.bottomRight:Alignment.bottomLeft,
                                            //     child: Container(
                                            //       padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.w),
                                            //       height: 25.h,
                                            //       decoration: BoxDecoration(
                                            //         color: AppColors.primaryColorGreen,
                                            //         borderRadius: BorderRadius.only(
                                            //                 topRight: Radius.circular( Get.locale.toString()=='ar'? 0:15.w),
                                            //                 topLeft: Radius.circular( Get.locale.toString()=='ar'? 15.w:0),
                                            //                 bottomRight: Radius.circular( 15.w),
                                            //                 bottomLeft: Radius.circular( 15.w),
                                            //         )
                                            //       ),
                                            //       child: Icon(Icons.edit,size: 18.w,color: AppColors.white,),
                                            //
                                            //
                                            //     )
                                            //     ))
                                          ],
                                        ),
                                      ),
                                      Spacer()
                                    ],
                                  )
                                ],
                              ),
                            ),
                            UiHelper.verticalSpaceMedium,
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: DynamicGridView(
                      data: logic.services,
                      count: 2,
                      mainSpacing: 50,
                      crossSpacing: 15,
                      aspectRatio:
                          GridAspectRatio.aspectRatio(count: 2, height: 170.h),
                      itemBuilder: (item) {
                    var     homeService =item as HomeService;
                        return MedicalFileItem(
                          homeService: homeService,
                          onTab: (){
                            Get.toNamed(homeService.route, arguments: homeService);

                          },
                        );
                      },
                    )

                        // GridView.builder(
                        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,
                        //     crossAxisSpacing: 15.0,
                        //     mainAxisSpacing: 35.0,
                        //     childAspectRatio: GridAspectRatio.aspectRatio(count: 2,height: 240),
                        //   ),
                        //   itemCount: logic.services.length,
                        //   itemBuilder: (bc,index)=>MedicalFileItem(homeService: logic.services[index],primary: index==0||index==3,),
                        //
                        //   padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                        //
                        //
                        //   primary: false,
                        //
                        // ),

                        ),
                  ],
                )
              : Container();
        }),
      ),
    );
  }
}
