import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../base_controller/base_controller.dart';
import '../../routes/app_route_names.dart';

class SplashController extends BaseController {
  // final PushNotificationService _pushNotificationService =
  //     LocatorHelper.locator<PushNotificationService>();

//bool  show=false;
  GetStorage introBox = GetStorage();
  GetStorage authBox = GetStorage();

  @override
  void onInit() async {
    super.onInit();

//     if(!noInternetConnection()){
// if(currentUser!=null) {
//    authController.getUserDetails();
//
// }
//     }

    // introBox = await Hive.openBox(AppBoxesNames.introBoxName);

    // Future.delayed(Duration(seconds: 1),(){
    //   show=true;
    //   update();
    // });

    hideSoftKeyBoard();
    // await _pushNotificationService.initialise();

    await handleSignIn();
  }

  handleSignIn() async {
    Future.delayed(const Duration(milliseconds: 4100), () async {
      if (introBox.read('displayed') == 3) {
        String id = '';
        if (currentUser != null) {
          id = currentUser!.id;

        }

        if(currentUser !=null  && currentUser!.accessToken.isEmpty  ){
          authBox.write("new_token",true);
          print("This is new version  *******************************");
      await   logUserOut();

        }

        else{



          Get.offAllNamed(AppRouteNames.homeTabs, arguments: id);
        }


        //Get.offAllNamed(currentUser != null ? AppRouteNames.home : AppRouteNames.login);
        // Get.toNamed( AppRouteNames.login);

      } else {
        Get.offAllNamed(AppRouteNames.intro, arguments: true);
      }
    });

    // bool hasLoggedIn = roleController.checkUserSignIn();
    // await NoConnectionSnackBar.hideNoConnectionSnackBar();
    // if (hasLoggedIn) {
    //   await navigateTo();
    // } else {
    //   Get.offAllNamed(IntroductionPage.id);
    // }
  }
}
