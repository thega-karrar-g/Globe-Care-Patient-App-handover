import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:globcare/app/modules/home_screen/home_screen_controller.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:string_mask/string_mask.dart';


import '../../base_controller/base_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../data/api/api.dart';
import '../../data/api/auth_api.dart';
import '../../data/constants/booking_constants.dart';
import '../../data/models/questionnaire.dart';
import '../../data/models/user_model.dart';
import '../../global_widgets/shared/different_dialogs.dart';
import '../../routes/app_route_names.dart';
import '../../data/api/api_keys.dart';
import '../appointment/appointment_types_logic.dart';
import '../booking_home_modules/instant_consultation_module/instant_consultation_home/instant_consultation_home_logic.dart';
import '../booking_home_modules/instant_consultation_module/instant_consultation_home/instant_consultation_home_view.dart';
import '../booking_home_modules/instant_consultation_module/instant_consultation_states/instant_consultation_states_logic.dart';
import '../booking_home_modules/patient_data/patient_data_logic.dart';
import '../home_tabs/home_tabs_controller.dart';
import '../select_patient/select_patient_logic.dart';
import 'auth_forms_mixin.dart';

class AuthController extends BaseController  with AuthFormsMixin{
  final AuthApi _authApi = AuthApi();
  final GetStorage rememberBox = GetStorage();
  var formatter = StringMask(
    '+ (000) 0  0000  ****',
  );

  bool showRegisterForm=true,showForgotPasswordForm=true;

// String get passwordPattern=>r'^(?=.*[A-Za-z])(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
// String get passwordPattern=>r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$';


  String otpCode="";

  TextEditingController otpCtrl = TextEditingController();
  String phoneNum = '966597217452';


  bool hidePassword = true;
  bool isLoading = false;
  int profileIndex = 0;
  RxInt genderIndex = 0.obs;

  int otpID=0;

  int step = 0;
  TextEditingController dobTextEditingController = TextEditingController();

  DateTime? dob = DateTime.now();

  updateDateTime(DateTime dateTime) {
    dob = dateTime;
    update();
  }

  var mapUser = {};
  var resultLocation = '';
  int gender = 0;

  String genderType = 'Male';
  final Questionnaire nationality = Questionnaire(
    question: AppStrings.nationality,
  );


  updateNationality(bool value) {
    nationality.answer = value;
    update();
  }

  updateGender(int index) {
    gender = index;
    genderType = gender == 0 ? 'male' : 'female';

    update();
  }

  updateStep(int st) {
    step = st;
    update();
  }

  updateLocation(String? txt) {
    if (txt != null && txt.isNotEmpty) {
      resultLocation = txt;
    } else {
      buildFailedSnackBar(msg: AppStrings.selectLocationMsg.tr);
    }

    update();
  }

  updateGenderIndex(int selected) {
    genderIndex.value = selected;
    update();
  }

  updateProfileIndex(int selected) {
    profileIndex = selected;
    update();
  }

  updatePassword(bool hide) {
    hidePassword = hide;
    update();
  }

  updateLoading(bool load) {
    isLoading = load;
    update();
  }

  void loginPatient() async {

    final requiredFields = ' '
        '${AppStrings.idNo.tr} *\n'
        '${AppStrings.password.tr} *\n'
        ''
        '';
Map<String,dynamic> allValues={};
    if (loginForm.valid) {


      allValues.addAll(loginForm.value);
     // loginPatient(loginForm().value);
    } else {
      // print(form.errors.toString());
      //  form.markAllAsTouched();
      buildFailedSnackBar(
          msg: '${AppStrings.fillAllRequiredFields.tr}\n\n$requiredFields\n${AppStrings.passwordLengthHint.tr}');

   return;
    }


    if (!noInternetConnection()) {

      var username =
          allValues[ApiKeys.smsUserName.toLowerCase()].toString().trim();
      var password =
          allValues[ApiKeys.formPassword.toLowerCase()].toString().trim();
      var data = {
        ApiKeys.smsUserName.toLowerCase(): username,
        ApiKeys.formPassword.toLowerCase(): password,
      };


      try {
        await DifferentDialog.showProgressDialog();

        var value=  await   _authApi.loginPatient(data);
        Get.back();
        //
        // print(value!.data);
        // print(value!.statusCode);
        // print(value!.statusMessage);
        if (value != null  && value.statusCode ==200) {
          var jsonResponse = (value.data);


          print(jsonResponse);
          if (jsonResponse['success'] == 1) {
            rememberBox.write(ApiKeys.remember.toLowerCase(), true);
            rememberBox.write(ApiKeys.smsUserName.toLowerCase(), username);
            rememberBox.write(ApiKeys.formPassword, password);

            var userMap = jsonResponse['data'];

            AppUser user = AppUser.fromMap(userMap);
            // user.token = Api.token;
            user.userType = '1';

            await   authService.saveUserInfoToHive(user);

            await  authService.setupDb();

            var mf = Get.find<SelectPatientLogic>();
            var appointmentTypesCtrl = Get.find<AppointmentTypesLogic>();

            mf.onInit();
            appointmentTypesCtrl.onInit();

            if(BookingConstants.fromPatientData ==true ) {



              if(InstantConsultationHomeLogic.fromInstantConsultation){
                InstantConsultationHomeLogic.fromInstantConsultation = false;

                //   Get.offNamedUntil(InstantConsultationHomePage.routeName,ModalRoute.withName(AppRouteNames.home),);

                Get.offNamedUntil(AppRouteNames.homeTabs,(route)=>false);
                Get.toNamed(
                  InstantConsultationHomePage.routeName,
                );

              }
              else{
                // Get.back(result: true);
                Get.offNamedUntil(AppRouteNames.patientData,ModalRoute.withName(PatientDataLogic.previousRoute),);

                // Get.toNamed(AppRouteNames.patientData);
              }



            }

            else{



              if(Get.isRegistered<HomeScreenController>()){

                Get.find<HomeScreenController>().onInit();
              }
              if(Get.isRegistered<InstantConsultationStatesLogic>()){


                Get.delete<InstantConsultationStatesLogic>(force: true);
                Get.put(InstantConsultationStatesLogic(),permanent: true);

              }

              Get.offNamedUntil(AppRouteNames.homeTabs,(route)=>false);

            }


          } else if (jsonResponse['success'] == 0) {
            buildFailedSnackBar(msg: AppStrings.invalidData.tr);
//Get.back();
          }
        } else {
        //  Get.back();

          buildFailedSnackBar(msg: AppStrings.invalidData.tr);
        }

      } catch (e) {
        Get.back();

        buildFailedSnackBar(msg: AppStrings.thereIsProblem.tr);

      }


    } else {
      buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
    }
  }

  void forgetPassword() async {

    final requiredFields = ' '
        '${AppStrings.idNo.tr} *\n'
        '${AppStrings.phoneNum.tr} *\n'
        ''
        '';
    if (!noInternetConnection()) {






        try {
          Map<String, dynamic> allValues={};

          if (forgetPasswordForm.valid) {
            allValues.addAll(forgetPasswordForm.value);
            // allValues=forgetPasswordForm.value;
            // logic.forgetPassword(form.value);
          } else {
            // print(form.errors.toString());
            //  form.markAllAsTouched();
            buildFailedSnackBar(
                msg: '${AppStrings.fillAllRequiredFields.tr}\n\n$requiredFields');
          }

          phoneNum=allValues[ApiKeys.formMobile];

          var data = {
            'mobile': '966${allValues['mobile']}'  ,
            'ssn': allValues['ssn'],
            'user_type': '1',
          };

          await DifferentDialog.showProgressDialog();

          var response=await   _authApi.forgetPassword(data);


          Get.back();


          if(response ==null){

            buildFailedSnackBar(msg: AppStrings.invalidData.tr);

          }

          var jsonResponse = (response!.data);

         // logger.i(jsonResponse);

          if (jsonResponse['success'] == 1) {


            otpID = jsonResponse['data']['id'];

            updateShowForgotPasswordForm(false);


            // print("*************************  ${showForgotPasswordForm}");


          } else if (jsonResponse['success'] == 0) {
            buildFailedSnackBar(msg: AppStrings.invalidData.tr);
//Get.back();
          }

        } catch (_) {

        }
    } else {
      buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
    }
  }
  Future resetPassword(Map<String, dynamic> allValues) async {
    if (!noInternetConnection()) {
      setBusy(true);

      await DifferentDialog.showProgressDialog();

      var data = {
        'patient_id': allValues['id']  ,
        'new_password': allValues['code'],
      };
      _authApi.resetPasswordHttp(data).then((value) async {
        try {
          var jsonResponse = (value!.data);

         // logger.i(jsonResponse);
          Get.back();

          if (jsonResponse['success'] == 0) {
            buildFailedSnackBar(msg: AppStrings.invalidData.tr);
//Get.back();
          }

          setBusy(false);
        } catch (e) {
          Get.back();

          setBusy(false);
          print(e.toString());
        }
      });
    } else {
      buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
    }
  }

  void getUserDetails({String id = '0'}) async {
    if (!noInternetConnection()) {

        try {

          setBusy(true);

          if(currentUser ==null){
            return;}

          var value=await    _authApi.getUserDetails(id: currentUser!.id);

          setBusy(false);

          var jsonResponse = value!.data;

          if (jsonResponse['success'] == 1) {
            var userMap = jsonResponse['data'] as List;

            AppUser user = AppUser.fromMap(userMap[0]);
            // user.token = Api.token;
            user.userType = '1';
            user.accessToken=currentUser!.accessToken;

            authService.saveUserInfoToHive(user);



            // if(BookingVars.fromPatientData !=null){
            //
            //   Get.back();
            // }
            // else{
            //   Get.offAllNamed(AppRouteNames.home);
            // }

          }
          else if
          (jsonResponse['success'] == 0) {
            // setBusy(false);
          }

        } catch (e) {

          print(e.toString());
        }

    } else {}
  }

  void register() async {

    var requiredFields = ' '
        '${AppStrings.fullName.tr} *\n'
        '${AppStrings.idNo.tr} *      ${AppStrings.numberLengthHint.trParams(
        {
          'length': '10',
        }  )}  \n'
        '${AppStrings.phoneNum.tr} *   ${AppStrings.numberLengthHint.trParams(
        {
          'length': '9',
        }  )}   \n'
        '${AppStrings.age.tr} *\n'
        ''
        '';

print(requiredFields);

    if (!noInternetConnection()) {
      // setBusy(true);


      try {

        Map<String,dynamic> formValues={};


        if (registerForm.valid) {

          var age = registerForm.value[ApiKeys.ageKey].toString();
          var dob = DateTime(
              DateTime.now().year - int.parse(age), 1, 1);

          var username=registerForm.value[ApiKeys.idNumberKey];
          phoneNum=registerForm.value[ApiKeys.formMobile].toString();

          // var nationality = registerForm.value[ApiKeys.idNumberKey]
          //     .toString()
          //     .startsWith('1')
          //     ? 'KSA'
          //     : '';
          formValues.addAll(  {
            ApiKeys.smsUserName.toLowerCase(): username,
          //  ApiKeys.genderKey: genderType.toLowerCase(),
            ApiKeys.sex: genderType.toLowerCase(),
            // ApiKeys.nationalityKey: nationality,
            ApiKeys.dobKey:
            DateFormat('yyyy-MM-dd').format(dob),

          });
          formValues.addAll(registerForm.value);



        } else {
          // print(form.errors.toString());
          //  form.markAllAsTouched();
          buildFailedSnackBar(
              msg: '${AppStrings.fillAllRequiredFields.tr}\n$requiredFields');

          return;
        }



       logger.i(formValues);
        DifferentDialog.showProgressDialog();

        var response=await  _authApi.registerPatient(formValues);

        Get.back();

        if(response!.statusCode==0){


          buildFailedSnackBar(msg: response.statusMessage ?? AppStrings.thereIsProblem.tr);


        }

        var data = response.data;

        logger.i(data);
        if (data['success'] == 1) {
          // print('id:************************* ${respo['data']['id']} ');
          // login2({'username':data['ssn'],'password':data['password']});
          //  buildSuccessSnackBar(msg: respo['data']['message']);

           otpID = data['data']['id'];


// print(otpID);
          // setBusy(false);

updateShowRegisterForm(false);


        } else {
          buildFailedSnackBar(msg: data['message']);
        }

        // setBusy(false);
      } catch (e) {
        // setBusy(false);
      }


    } else {
      buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
    }


  }


  updateShowRegisterForm(bool isShown){

    showRegisterForm=isShown;
    update();
  }
  updateShowForgotPasswordForm(bool isShown){

    showForgotPasswordForm=isShown;
    update();
  }

  void verifyCode({bool isRegister=true}) async {
    if (!noInternetConnection()) {
      setBusy(true);







      try {

        if(otpCtrl.text.isEmpty || otpCtrl.text.length<4 ){

          // otpCode="";
          buildFailedSnackBar(msg: AppStrings.verifyCodeErrorMsg.tr);
          return;
        }

        Map<String,dynamic> body={

          ApiKeys.otpID:otpID,
          ApiKeys.code:otpCtrl.text,

        };

        // logger.i(body);

        DifferentDialog.showProgressDialog();
        var response=await  _authApi.verifyCode(body,isRegister: isRegister);


        Get.back();

        var data = response!.data;

        logger.i(data);

        if (data['success'] == 1) {

          showForgotPasswordForm=true;
          showRegisterForm=true;
          registerForm.reset();
          forgetPasswordForm.reset();
          otpCtrl.clear();
          // print('id:************************* ${respo['data']['id']} ');
          // login2({'username':data['ssn'],'password':data['password']});
          //  buildSuccessSnackBar(msg: respo['data']['message']);

          var userMap = data['data'];

          logger.i(userMap);

          AppUser user = AppUser.fromMap(userMap);
          // user.token = Api.token;
          user.userType = '1';

          authService.saveUserInfoToHive(user);

          await  authService.setupDb();

          rememberBox.write(ApiKeys.smsUserName.toLowerCase(), user.ssn);
          rememberBox.write(ApiKeys.formPassword, otpCtrl.text);


          updateShowForgotPasswordForm(true);
          updateShowRegisterForm(true);

          var mf = Get.find<SelectPatientLogic>();
          var appointmentTypesCtrl = Get.find<AppointmentTypesLogic>();

          mf.onInit();
          appointmentTypesCtrl.onInit();

          if (BookingConstants.fromPatientData != null) {
            Get.back();
          } else {
            String id = '';
            if (currentUser != null) {
              id = currentUser!.id;
            }

            Get.offNamedUntil(AppRouteNames.homeTabs,(route)=>false,arguments: id);

          }

          setBusy(false);



        } else {
          buildFailedSnackBar(msg: data['message']);
        }

        setBusy(false);
      } catch (e) {
        setBusy(false);
      }


    } else {
      buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
    }
  }






  Future<dynamic> addMember() async {
    if (!noInternetConnection()) {

      try {
        var requiredFields = ' '
            '${AppStrings.fullName.tr} *\n'
            '${AppStrings.idNo.tr} *      ${AppStrings.numberLengthHint.trParams(
            {
              'length': '10',
            }  )} \n'
            '${AppStrings.phoneNum.tr} *   ${AppStrings.numberLengthHint.trParams(
            {
              'length': '9',
            }  )}  \n   '
            '${AppStrings.age.tr} *\n'
            ''
            '';
        Map<String, dynamic> data={};
        if (addMemberForm.valid) {
          var age = int.parse(addMemberForm.value[ApiKeys.ageKey].toString());

          if (age > 100) {
            buildFailedSnackBar(msg: AppStrings.ageMsg);
          } else {
            var dob =
            DateTime(DateTime.now().year - (age), 1, 1);

            // var nationality = form.value[idNumberKey]
            //     .toString()
            //     .startsWith('1') ? 'KSA' : '';
            data = {
              'parent_id': currentUser!.id,
              'name': addMemberForm.value['name'].toString(),
              'ssn': addMemberForm.value['ssn'].toString(),

              'gender': genderType.toLowerCase(),
              // 'ksa_nationality': nationality,
              'dob': DateFormat('yyyy-M-d').format(dob),
            };
            // print(form.value);
            // data.addAll(form.value);


          }
        } else {
          // print(form.errors.toString());
          //  form.markAllAsTouched();
          buildFailedSnackBar(
              msg: '${AppStrings.fillAllRequiredFields.tr}\n\n$requiredFields');

          return;
        }

        setBusy(true);

        DifferentDialog.showProgressDialog();

      //  logger.i(data);
        var value= await _authApi.addMember(data);
        var response = (value);
       logger.i(value);


        Get.back();
        if (response['success'] == 1) {
          var mf = Get.find<SelectPatientLogic>();
          var appointmentTypesCtrl = Get.find<AppointmentTypesLogic>();

          mf.onInit();
          appointmentTypesCtrl.onInit();

          var back = await DifferentDialog.showRequestServiceSuccessDialog(
              msg: AppStrings.newMemberMsg, isBack: true);

          if (back == true) {
            Get.back(result: true);
          }

          setBusy(false);
        } else {
          buildFailedSnackBar(msg: response['message'].toString().tr);
        }


        setBusy(false);
      } catch (e) {
        Get.back();
        //  buildFailedSnackBar(msg: AppStrings.thereIsProblem.tr);

        setBusy(false);
      }


    } else {
      buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
    }
  }


  // void editProfile(Map<String, dynamic> data) async {
  //   //  var dob = DateFormat('yyyy-MM-dd').format(data['dob']);
  //   var myData = {
  //     'login': data['login'],
  //     'name': data['name'],
  //     'password': data['password'],
  //   };
  //
  //   DifferentDialog.showProgressDialog();
  //
  //   _authApi.registerPatient(myData).then((value) {
  //     if (value!.data!['success'] == 1) {
  //     } else {
  //       buildFailedSnackBar(msg: value.data['message']);
  //     }
  //   });
  //
  //   // var result = await _userRepository.loginWithEmailThenGetUserData(user);
  //   await DifferentDialog.hideProgressDialog();
  //
  //   //  Get.toNamed(AppRouteNames.home);
  // }


  final addressController = TextEditingController(text: '');
  final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{0,8}$');

  changePassword() async {

    // logger.i(query);
    Map<String, dynamic> data = {
      ApiKeys.formType: '1',
      ApiKeys.smsUserName.toLowerCase():
      currentUser!.phone
    };
    if (changePasswordForm.valid) {


      data.addAll(changePasswordForm.value);


    } else {
      buildFailedSnackBar(msg: AppStrings.fillAllFields.tr);
      return;
    }



    DifferentDialog.showProgressDialog();

    var changePass = await _authApi.changePassword(data);

    Get.back();
    logger.i(changePass);

    if(changePass!.data == null){

      buildFailedSnackBar(msg: AppStrings.passwordUpdateFailed.tr);
      return;
    }


    var jsonRes = changePass.data;


    if (  jsonRes['success'] == 1) {
      var res = await DifferentDialog.showEditProfileSuccessDialog(
          msg: AppStrings.passwordUpdateSuccessfully);

      if (res) {
        Get.back();
      }
    } else {
      buildFailedSnackBar(msg:  AppStrings.passwordUpdateFailed.tr);
      return false;
    }
  }

  String? validatePassword(String password) {
    // final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (!regex.hasMatch(password)) {
      return 'Password must have at least:\n'
          '- 1 uppercase letter\n'
          '- 1 lowercase letter\n'
          '- 1 number\n'
          '- 1 special character\n'
          '- Minimum length of 8 characters';
    }
    return null;
  }

}
