import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:globcare/app/core/language_and_localization/app_strings.dart';
import 'package:globcare/app/data/api/api_keys.dart';
import 'package:globcare/app/modules/my_profile_module/my_profile/edit_profile_logic.dart';
import 'package:http/http.dart' as http;

import 'app_urls.dart';
import 'base_api.dart';

class AuthApi extends BaseApi {
  static final _loginApi = AuthApi._internal();

  factory AuthApi() {
    return _loginApi;
  }

  AuthApi._internal();

  // var login = AppUrls.getUrl(AppUrls.loginPatient, withExtension: false);
  // var registerPatient =
  //     AppUrls.getUrl(AppUrls.registerPatient, withExtension: false);
  // var registration = AppUrls.registration;
  // var edit = AppUrls.editProfile;
  // var profile = AppUrls.getUrl(AppUrls.userDetails, withExtension: false);

  Future<Response?> getMembers() async {
    try {
      var response = await api.dioGet(AppUrls.getMembers + currentUser!.id);

      return response;
    } catch (e) {
      return null;

      //
    }
  }

  Future<Response?> loginPatient(query) async {
    try {

      // print("***************");

      var response = await api.dioPost( endPath:  AppUrls.loginPatient, body: query);


      print(response);

      return response;
    }on DioException catch (e) {
      // logger.e(e.message);
      return null;

      //
    }
  }

  Future<Response?> getUserDetails({String id = '0'}) async {


    String endPath=AppUrls.userDetails + currentUser!.id;

  //  print("*********************************  $endPath  ");

    var response = await api.dioGet( endPath );

    return response;
  }





  Future<Response?> forgetPassword(query) async {

    return await api.dioPost( endPath:  AppUrls.forgetPassword, body: query);


  }
  Future<Response?> resetPasswordHttp(query) async {
    //  try {
    //  var q="?login=smartmind&password=medical25@Sm%2321&db=smartmind_medical&device_type=1";

    var response = await api.dioPost( endPath:  AppUrls.resetPassword, body: query);

    return response;
    // }catch(_){
    //
    // }
  }


  Future<dynamic> addMember(Map<String, dynamic> body) async {
    var resFail={ApiKeys.responseSuccess:0,ApiKeys.responseMessage:AppStrings.thereIsProblem};

    try {


      var response = await api.dioPost(endPath:  AppUrls.addMember, body: body);

      if(response ==null){
        return resFail;
      }

      if(response.statusCode==200){

      return response.data;}

      else{
        return resFail;
      }

    } catch (e) {
      return resFail;
    }
  }



  Future<Response?> editPatientProfile(query) async {
    //  try {


    var response =
        await api.dioPost( endPath:  AppUrls.editProfile + currentUser!.id, body: query);

    return response;
  }

  Future<Response?> changePassword(query) async {
    //  try {

    //  var q="?login=smartmind&password=medical25@Sm%2321&db=smartmind_medical&device_type=1";

    var response = await api.dioPost(endPath: AppUrls.changePassword, body: query);

    return response;
  }

  Future<Response?> editProfileImage(Map <String ,File> files) async {



    var response = await api.dioPut(endPath: AppUrls.updateProfilePhoto + currentUser!.id,files: files);

    return response;
  }

  Future<Response?> registerPatient(query) async {
    try {
      var response = await api.dioPost( endPath:  AppUrls.registerPatient, body: query);

      return response;
    } catch (e) {
      return null;

      //
    }
  }
  Future<Response?> verifyCode(query,{bool isRegister=true}) async {
    try {
      var response = await api.dioPost( endPath: isRegister? AppUrls.registerVerifyCode :AppUrls.forgotPasswordVerifyCode, body: query);

      return response;
    } catch (e) {
      return null;

      //
    }
  }

}
