import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/api/api.dart';
import '../../../data/api/api_keys.dart';
import '../../../data/api/auth_api.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/models/home_service.dart';
import '../../../data/models/user_model.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../routes/app_route_names.dart';
import '../../../core/assets_helper/app_images.dart';
import '../../auth/auth_controller.dart';

class EditProfileLogic extends BaseController {
  final ImagePicker _picker = ImagePicker();
  final String cacheKey = 'profile';
  AuthApi authApi = AuthApi();
  static File? profileImage;
  AuthController authController = Get.put(AuthController());

  List<HomeService> services = [
    HomeService(
        id: 1,
        name: AppStrings.changePassword,
        icon: AppImages.iconChangePass,
        route: AppRouteNames.editPassword,
        primary: true),
    HomeService(
        id: 2,
        name: AppStrings.requestedPayments,
        icon: AppImages.iconRequestedPayment,
        route: AppRouteNames.requestedPayment,
        primary: true),
    HomeService(
        id: 3,
        name: AppStrings.myMembers,
        icon: AppImages.iconMyMembers,
        route: '',
        primary: true),
    HomeService(
        id: 4,
        name: AppStrings.myWallet,
        icon: AppImages.iconMyWallet,
        route: '',
        primary: true),
  ];
  TextEditingController dobTextEditingController = TextEditingController();

  DateTime? dob = DateTime.now();

  updateDateTime(DateTime dateTime) {
    dob = dateTime;
    update();
  }

  int gender = 0;

  updateGender(int index) {
    gender = index;
    BookingConstants.doctorGender = index == 0 ? 'Male' : 'Female';

    update();
  }

  String resultLocation = '';

  updateLocation(String result) {
    resultLocation = result;
    update();
  }

  pickImage() async {
    clearImageCache();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage = File(image.path);

      Map <String ,File> files={
        ApiKeys.profileImage:profileImage!
      };

      DifferentDialog.showProgressDialog();

    var value= await authApi.editProfileImage(files);
Get.back();
    if(value ==null){

      buildFailedSnackBar(msg: AppStrings.failedToUpdate.tr);

      return;
    }

    // print(value.data);
        var jsonData = (value.data);
        if (jsonData['success'] == 1) {
          authApi.getUserDetails().then((value) {
            var jsonResponse = value!.data;

            // print(jsonResponse);
            saveInfo(jsonResponse);

            update();

            Get.back();
            buildSuccessSnackBar(msg: AppStrings.profileUpdated.tr);

          });
        } else {
          // Get.back();
          buildFailedSnackBar(msg: AppStrings.failedToUpdate.tr);

        }

      // update();

    } else {
      // User canceled the picker
    }
  }

  // pickFiles() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: false,
  //     type: FileType.custom,
  //     allowedExtensions: [
  //       'jpg',
  //       'jpeg',
  //       'png',
  //     ],
  //   );
  //
  //   if (result != null) {
  //     profileImage = File(result.files.first.path!);
  //     Map <String ,File> files={
  //       ApiKeys.profileImage:profileImage!
  //     };
  //     DifferentDialog.showProgressDialog();
  //
  //   var value=await  authApi.editProfileImage(files) ;
  //       var jsonData = (value!.data);
  //       if (jsonData['success'] == 1) {
  //         authApi.getUserDetails().then((value) {
  //           var jsonResponse = value!.data;
  //
  //           saveInfo(jsonResponse);
  //
  //           update();
  //
  //           Get.back();
  //         });
  //       } else {
  //         Get.back();
  //       }
  //
  //     // update();
  //
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  updateProfile(query) async {

    logger.i(query);

    DifferentDialog.showProgressDialog();

    var editResponse = await authApi.editPatientProfile(query);

    Get.back();
    // DifferentDialog.hideProgressDialog();

    if(editResponse ==null){

      buildFailedSnackBar(msg: AppStrings.thereIsProblem.tr);
      return;
    }


    var jsonRes = editResponse.data;


    if ( jsonRes['success'] !=null && jsonRes['success'] == 1) {
    var  value=  await authApi.getUserDetails();

    if(value ==null){

      buildFailedSnackBar(msg: AppStrings.thereIsProblem.tr);
      return;
    }

    var jsonResponse = value.data;

    if ( jsonResponse['success'] !=null && jsonRes['success'] == 1) {
      saveInfo(jsonResponse);

      update();

      var res = await DifferentDialog.showEditProfileSuccessDialog();

      Get.back();

    }


    } else {
      buildFailedSnackBar(msg: AppStrings.profileUpdateFailed.tr);
      return false;
    }
  }

  navToEdit() {
    Get.toNamed(AppRouteNames.editProfile)!.then((value) {
      update();
    });
  }

  saveInfo(jsonResponse) {
    var userMap = jsonResponse['data'] as List;

    AppUser user = AppUser.fromMap(userMap[0]);
    // user.token = Api.token;
    user.userType = '1';
user.accessToken=currentUser!.accessToken;
    authService.saveUserInfoToHive(user);
  }

  File? fileImg;
  bool isLoading = true;

  writeFile({String imageData = ''}) async {
    final decodedBytes = base64Decode(currentUser!.imageUrl!);
    final directory = await getApplicationDocumentsDirectory();
    fileImg = File('${directory.path}/testImage.png');
    print(fileImg!.path);
    fileImg!.writeAsBytesSync(List.from(decodedBytes));

    update();
  }

  File? currentImage;

  @override
  void onInit() async {
    // TODO: implement onInit
    // clearImageCache();
    super.onInit();
    currentImage = await file('filename');
    dob = DateTime.tryParse(currentUser!.dob!);
    update();
    authController.getUserDetails();
  }

  clearImageCache() async {
    var cm = DefaultCacheManager();
    var f = await cm.getSingleFile(currentUser!.imageUrl!);

    if (f.existsSync()) {
      print(f.path);
      print('yes');
    } else {
      print('no');
    }
    // CachedNetworkImage.evictFromCache(currentUser!.imageUrl!);
// update();
  }

  Future<void> deleteCacheDir() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.delete(recursive: true);
    }
  }

  void removeFile() {
    DefaultCacheManager().removeFile(currentUser!.imageUrl!).then((value) {
      //ignore: avoid_print
    }).onError((error, stackTrace) {
      //ignore: avoid_print
      print(error);
    });
  }

  Future<File> file(String filename) async {
    Directory dir = await getTemporaryDirectory();
    String pathName =
        p.join(dir.path, '${currentUser!.phone.trim()}${currentUser!.id}.png');
    return File(pathName);
  }
}
