import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:globcare/app/modules/auth/auth_controller.dart';

import '../data/models/user_model.dart';
import '../routes/app_route_names.dart';

class SessionService extends GetxService {
  final String currentUserKey = 'currentUser';
  final String currentUserGuestKey = 'currentUserGuest';

  AppUser? _currentUser;

  late GetStorage userBox = GetStorage();

  AppUser? get currentUser => _currentUser;

  setupDb() async {
    fetchCurrentUser();
  }

  Future fetchCurrentUser() async{
    if (!userBox.hasData(currentUserKey)) {

    //  print("no user data   ***************************");

      return;
    }
   // print(" user has data   ***************************  ${userBox.read(currentUserKey)}");

    Map<String, dynamic>? user;
    user = Map<String, dynamic>.from(jsonDecode(userBox.read(currentUserKey)));
  //  debugPrint(" fetch:\n "+user.toString());

    _currentUser = AppUser.fromMap(user);

return;
  }


  saveUserInfoToHive(AppUser user) async {
    signOutGuest();

    _currentUser = user;
    // fetchCurrentUser();
    try {

     // debugPrint(" save:\n ${user.toMap()}");
      await userBox.write(currentUserKey, jsonEncode(user.toMap()));
     await fetchCurrentUser();
      return true;
    } catch (e) {
      return e.toString();
    }
  }


  bool checkUserSignIn() {
    if (currentUser != null) {
      if (currentUser!.userType == '1') {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  bool checkGuestSignIn() {
    if (currentUser != null) {
      if (currentUser!.userType == '2') {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  Future signOut() async {
    _currentUser = null;
    // if (userBox.hasData(currentUserKey)) {
      await userBox.remove(currentUserKey);
      Get.offAllNamed(AppRouteNames.login);
    // }
  }

  Future signOutGuest() async {
    _currentUser = null;
    if (userBox.hasData(currentUserGuestKey)) {
      await userBox.remove(currentUserGuestKey);
      // Get.offAllNamed(AppRouteNames.home);

    }
  }
}
