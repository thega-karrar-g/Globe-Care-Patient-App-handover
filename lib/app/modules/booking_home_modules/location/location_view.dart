
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/my_appbar.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../../routes/app_route_names.dart';
import '../../drawer_module/drawer_widget/main_drawer_widget.dart';
import 'location_logic.dart';

class LocationPage extends StatelessWidget {
  final LocationLogic logic = Get.put(LocationLogic());

  LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationLogic>(builder: (logic) {
      return Scaffold(
        drawer: MainDrawerWidget(),
        endDrawerEnableOpenDragGesture: false,
        drawerEnableOpenDragGesture: false,
        body: SafeArea(
          // minimum: UiHelper.safeAreaPadding,
          child:

          Stack(
            children: [



              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.h, right: 30.w),
                    child: Column(
                      children: [
                        myAppBar2(title: AppStrings.selectLocation.tr,onBack: (){

                          Get.offAllNamed(AppRouteNames.homeTabs);

                        }),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColorOpacity,
                                      borderRadius: BorderRadius.circular(10.h)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 20.w),
                                  child: TextFormField(
                                    controller: LocationLogic.addressController,
                                    textAlign: TextAlign.start,
                                    style: AppStyles.primaryStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                  )

                                  //  Text(LocationLogic.addressController.text,textAlign: TextAlign.start,style: AppStyles.primaryStyle(),),
                                  ),
                            ),
                          ],
                        ),
                        UiHelper.verticalSpaceMedium,
                      ],
                    ),
                  ),
                  Expanded(
                      child: !logic.busy
                          ?
                      Container(
                              constraints:
                                  BoxConstraints(minHeight: 100, minWidth: 100),
                              child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: logic.kGooglePlex,
                                markers: Set<Marker>.of(logic.markers.values),
                                onMapCreated: (GoogleMapController controller) {
                                  //  logic.getCurrentLocation();
                                  // logic.mapController=controller;
                                  logic.updateMapController(controller);
                                  logic.controller.complete(controller);

                                  logic.getCurrentLocation();
                                },
                                onTap: (latLang) {
                                  logic.getAddress(latLang);
                                },
                                buildingsEnabled: true,
                                indoorViewEnabled: true,
                                trafficEnabled: true,
                                compassEnabled: true,
                                onCameraMove: (position) {},
                                myLocationEnabled: true,
                                  gestureRecognizers: Set()
                                    ..add(Factory<OneSequenceGestureRecognizer>(
                                            () =>  EagerGestureRecognizer()))
                                    ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                                    ..add(
                                        Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                                    ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                                    ..add(Factory<VerticalDragGestureRecognizer>(
                                            () => VerticalDragGestureRecognizer()))
                              ),
                            )



                      : Container()),


                ],
              ),
              
              

              
            ],
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          color: AppColors.white.withOpacity(.0),
          child: Ui.primaryButton(
              title: AppStrings.continueTo.tr,
              marginH: 50,

              color: LocationLogic.addressController.text.isNotEmpty
                  ? AppColors.primaryColor
                  : AppColors.extraGrey,
              onTab: () {
                logic.navToNext();
              }),
        ),
      );
    });
  }
}
