import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../my_invoice/my_invoice_view.dart';

class MyProfileLogic extends BaseController {
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
        route: AppRouteNames.member,
        primary: true),
    HomeService(
        id: 4,
        name: AppStrings.invoices,
        icon: AppImages.invoice,
        route: MyInvoicePage.routeName,
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

  pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
      ],
    );

    if (result != null) {
      profileImage = File(result.files.first.path!);
      Map <String ,File> files={
        ApiKeys.profileImage:profileImage!
      };
      DifferentDialog.showProgressDialog();

   var editImage=await   authApi.editProfileImage(files);
        var jsonData = (editImage!.data);
        if (jsonData['success'] == 1) {
         var value=await authApi.getUserDetails();

            var jsonResponse = value!.data;

            saveInfo(jsonResponse);

            update();

            Get.back();
        } else {
          Get.back();
        }

      // update();

    } else {
      // User canceled the picker
    }
  }

  updateProfile(query) async {
    DifferentDialog.showProgressDialog();

    var edit = await authApi.editPatientProfile(query);

    var jsonRes = edit!.data;

    if (jsonRes['success'] == 1) {
      await authApi.getUserDetails().then((value) async {
        var jsonResponse = value!.data;

        saveInfo(jsonResponse);

        update();
        Get.back();

        var res = await DifferentDialog.showEditProfileSuccessDialog();

        if (res) {
          Get.back();
        }
      });
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(currentUser !=null) {
      clearImageCache();


      dob = DateTime.tryParse(currentUser!.dob!);
      if (!noInternetConnection()) {


        Future.delayed(Duration(milliseconds: 200),(){

          authController.getUserDetails();

        });

      }
    }


  }

  clearImageCache() async {
    await CachedNetworkImage.evictFromCache(currentUser!.imageUrl!);
  }
}
