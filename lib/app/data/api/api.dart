import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' ;
import 'package:dio/io.dart';
// import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/io_client.dart';
// import 'package:http_parser/http_parser.dart';


import '../../base_controller/base_controller.dart';
import '../../modules/booking_home_modules/nurse_services/nurse_services_logic.dart';
import '../../modules/my_profile_module/my_profile/edit_profile_logic.dart';
import '../../routes/app_route_names.dart';
import '../constants/booking_constants.dart';
import 'api_keys.dart';
import 'app_urls.dart';
import 'interceptor.dart';

class Api extends BaseController {
  static final _instance = Api._();

  static  get instance=>_instance;

  // factory Api() {
  //   return _instance;
  // }


 late Dio _dio;

  Api._() {




     _dio = Dio(
       BaseOptions(
         headers: requestHeader,
         receiveTimeout: Duration(seconds: 15),
         connectTimeout: Duration(seconds: 15),
         sendTimeout: Duration(seconds: 15),
         validateStatus: (status){

           return status! <= 500;

         }

       )

     ); // with default Options
    _dio.interceptors.add(AppInterceptors());
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();

        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

  }




List<String> tokenMessages=["Missing token in request header",'Token is not valid'];



  Map<String,dynamic> get requestHeader=> {
    if(currentUser !=null )
    'token': currentUser!.accessToken,
    // 'content-type': 'application/json',
    'Accept': 'application/json',
  };

  // var failResponse= {ApiKeys.responseSuccess:0,ApiKeys.responseMessage:'There is a problem \nour team will fix it asap'};


  Future<Response?> dioGet(String endPath, {Map<String,String> queryParameters=const{}})async {

    _dio.options.headers=requestHeader;
    // logger.i("****************** token:  "+currentUser!.toMap().toString());

String url=AppUrls.baseUrl + endPath;
    // print(url);
    Response response=await _dio. get(url,queryParameters:queryParameters );


   //  print("url is $url    status code is ${response.statusCode}");
   //
   //  logger.i(response.statusCode);
   //  logger.i(response.data);
   // logger.i(requestHeader);

    if(response.statusCode ==200) {
      // print(response.data);

      if( response.data[ApiKeys.responseSuccess] !=null && response.data[ApiKeys.responseSuccess]==1) {
        return response;
      }

      else  {

        if(response.data['message'] !=null && tokenMessages.contains( response.data['message'] ) ){

         // await logUserOut();


          // buildFailedSnackBar(msg: AppStrings.loginRequired.tr);

          // Future.delayed(Duration(seconds: 1),()async{
          //
          //
          // await  Get.toNamed(AppRouteNames.login);
          //   // Get.offAllNamed(AppRouteNames.login);
          //
          // });


          return null;

        }

        else{
          return response;
        }


      }



    }

    else{
      return null;

    }



  }


  Future< Response?> dioPost({  Map<String ,dynamic > body=const{},Map<String,File> files=const {},String endPath='',bool isEndPath=true,}) async {
    _dio.options.headers=requestHeader;

    // logger.d(currentUser!.accessToken);

    var data = FormData.fromMap(body);

// print(body);



    for (var element in files.entries) {

      var bytes=element.value.readAsBytesSync();

      var filename = element.value.path.split('/').last;

      var   file = MultipartFile.fromBytes(bytes, filename: filename,contentType: MediaType('application', '*'));

      data.files.add(MapEntry(element.key, file));

    }










    var url= isEndPath?(AppUrls.baseUrl+ endPath):endPath;

// print(url);
    if(data.files.isNotEmpty){
      _dio.options.headers['content-type']=  "multipart/form-data";

    }


    // print(_dio.options.headers);



    Response response= await  _dio.post(url, data: data);

    print("*****************   after response");
    print(url);
    print(response.statusCode);
    print(response.statusMessage);
    logger.i(response.statusCode);
    logger.i(response.statusMessage);




    if(response.statusCode ==200) {


      // print(response.data);

      if(response.data[ApiKeys.responseSuccess]==1) {
        return response;
      }

      else  {

        if(response.data['message'] !=null && tokenMessages.contains( response.data['message'] ) ){

          await logUserOut();

          return null;

        }

        else{
          return response;
        }


      }



    }

 else if(response.statusCode ==0){

   return response;
    }


    else{
      return null;

    }
  }
  Future< Response?> dioPut({  Map<String ,dynamic > body=const{},Map<String,File> files=const {},String endPath='',bool isEndPath=true,}) async {
    _dio.options.headers=requestHeader;

    // logger.d(currentUser!.accessToken);

    var data = FormData.fromMap(body);

// print(body);



    for (var element in files.entries) {

      var bytes=element.value.readAsBytesSync();

      var filename = element.value.path.split('/').last;

      var   file = MultipartFile.fromBytes(bytes, filename: filename,contentType: MediaType('application', '*'));

      data.files.add(MapEntry(element.key, file));

    }










    var url= isEndPath?(AppUrls.baseUrl+ endPath):endPath;

// print(url);
    if(data.files.isNotEmpty){
      _dio.options.headers['content-type']=  "multipart/form-data";

    }


    // print(_dio.options.headers);



    Response response= await  _dio.put(url, data: data);

    // print("*****************   after response");
    // print(url);
    // print(response.statusCode);
    // print(response.statusMessage);
    // logger.i(response.statusCode);
    // logger.i(response.statusMessage);




    if(response.statusCode ==200) {


      // print(response.data);

      if(response.data[ApiKeys.responseSuccess]==1) {
        return response;
      }

      else  {

        if(response.data['message'] !=null && tokenMessages.contains( response.data['message'] ) ){

          await logUserOut();

          return null;

        }

        else{
          return response;
        }


      }



    }

 else if(response.statusCode ==0){

   return response;
    }


    else{
      return null;

    }
  }



// Future<mydio.Response> httpLogin(String endPath, {query}) async {
  //   //  Uri u=Uri.parse(AppUrls.baseUrl + endPath).replace(queryParameters:query );
  //
  //   //  return https.post(u, headers: header);
  //   return dioPost(endPath, body: query);
  // }

  // Future<http.Response> httpRegister(String endPath, {query}) async {
  //   // Uri url = Uri( host:  AppUrls.baseUrl ,path:AppUrls.endBaseUrl+ endPath,queryParameters: query);
  //
  //   // print(query);
  //   Uri u =
  //       Uri.parse(AppUrls.baseUrl + endPath).replace(queryParameters: query);
  //
  //   return https.post(u, headers: header);
  // }
  //
  // Future<http.Response> httpEditProfile(String endPath, {query}) async {
  //   // Uri url = Uri( host:  AppUrls.baseUrl ,path:AppUrls.endBaseUrl+ endPath,queryParameters: query);
  //
  //   Uri u =
  //       Uri.parse(AppUrls.baseUrl + endPath).replace(queryParameters: query);
  //
  //   return https.post(u, headers: header);
  // }
  //
  // Future<http.Response> httpChangePassword({query}) async {
  //   // Uri url = Uri( host:  AppUrls.baseUrl ,path:AppUrls.endBaseUrl+ endPath,queryParameters: query);
  //
  //   Uri u = Uri.parse(AppUrls.baseUrl + AppUrls.changePassword)
  //       .replace(queryParameters: query);
  //
  //   return https.post(u, headers: header);
  // }
  //
  // mydio.BaseOptions get options {
  //   // var token = '';
  //   // if (currentUser != null) {
  //   //   token = currentUser!.token;
  //   // }
  //   return mydio.BaseOptions(
  //     baseUrl: AppUrls.baseUrl,
  //     // connectTimeout: 5000,
  //     // receiveTimeout: 3000,
  //     headers: {
  //       'token': token,
  //       'content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Cookie': 'http://20.86.58.235',
  //     },
  //   );
  // }
  //
  // Future<http.Response> httpGet(String endPath) async {
  //   Uri url = Uri.parse(AppUrls.baseUrl + endPath);
  //   // var _user = Get.find<SessionService>().currentUser;
  //
  //   return http.get(
  //     url,
  //     headers: header,
  //   );
  // }
  //
  // Future<http.Response> httpGetProfile(String endPath, String token) async {
  //   Uri url = Uri.parse(AppUrls.baseUrl + endPath);
  //
  //   var header = {'token': token};
  //
  //   return http.get(
  //     url,
  //     headers: header,
  //   );
  // }
  //
  // Future<Response> dioPost(String endPath, {Map<String, dynamic>? body}) {
  //
  //
  //   print(AppUrls.baseUrl + endPath);
  //
  //   return _dio.post(AppUrls.baseUrl + endPath, data: FormData.fromMap(body!));
  // }







//   Future<mydio.Response> dioPost2(String endPath,
//       {Map<String, dynamic>? body}) {
//     return mydio.Dio(mydio.BaseOptions(
//       //baseUrl: AppUrls.baseUrl,
//       // connectTimeout: 5000,
//       // receiveTimeout: 3000,
//
//       followRedirects: false,
//       // will not throw errors
//       validateStatus: (status) => true,
//       headers: {
//         'token': token,
//         // 'Content-type': 'application/x-www-form-urlencoded',
//         // 'Accept': 'application/json'
//       },
//     )).post(AppUrls.baseUrl + endPath, data: mydio.FormData.fromMap(body!));
//   }
//
//   Future<mydio.Response> dioPostPayment(String endPath, {required body}) {
//     return mydio.Dio(mydio.BaseOptions(
//       // connectTimeout: 5000,
//       // receiveTimeout: 3000,
//       headers: headerPayment,
//     )).post(endPath, data: mydio.FormData.fromMap(body));
//   }
//
//   Future<mydio.Response> dioPostSMS(String endPath, {required body}) {
//     return mydio.Dio(mydio.BaseOptions(
//       // connectTimeout: 5000,
//       // receiveTimeout: 3000,
//       headers: headerSMS,
//     )).post(endPath, data: (body));
//   }
//
//   Future<http.Response> httpPost(String endPath,
//       {Map<String, dynamic>? body}) async {
//     Uri url = Uri.parse(AppUrls.baseUrl + endPath);
//
//     return http.post(url, body: (body), headers: header);
//   }
//
//   Future<http.Response> httpPostPayment(String endPath, {dynamic body}) async {
//     Uri url = Uri.parse(endPath);
//
//     return http.post(url, body: (body), headers: headerPayment);
//   }
//
//   Future<mydio.Response> uploadFileDio({Map<String, String> body = const {}}) async {
//     var formData = mydio.FormData.fromMap(body);
//
//     var hasAudio = BookingConstants.audioFile != null;
//     var hasAttach = BookingConstants.attachFile != null;
//     var hasCamera = BookingConstants.cameraFile != null;
//     var fileNameAudio = '';
//     var fileNameAttach = '';
//     var fileNameCamera = '';
//
//     Uint8List audioBytes = Uint8List(0);
//     Uint8List attachBytes = Uint8List(0);
//     Uint8List cameraBytes = Uint8List(0);
//     mydio.MultipartFile? audioFile, cameraFile, attachFile;
//
//     if (hasAudio) {
//       audioBytes = BookingConstants.audioFile!.readAsBytesSync();
//
//       fileNameAudio = BookingConstants.audioFile!.path.split('/').last;
//       audioFile = mydio.MultipartFile.fromBytes(audioBytes,
//           filename: fileNameAudio, contentType: MediaType('application', '*'));
//
//       formData.files.add(MapEntry(ApiKeys.attachedFile, audioFile));
//     }
//     if (hasAttach) {
//       attachBytes = BookingConstants.attachFile!.readAsBytesSync();
//
//       fileNameAttach = BookingConstants.attachFile!.path.split('/').last;
//       attachFile = mydio.MultipartFile.fromBytes(attachBytes,
//           filename: fileNameAttach, contentType: MediaType('application', '*'));
//       formData.files.add(MapEntry(ApiKeys.attachedFile2, attachFile));
//     }
//     if (hasCamera) {
//       cameraBytes = BookingConstants.cameraFile!.readAsBytesSync();
//
//       fileNameCamera = BookingConstants.cameraFile!.path.split('/').last;
//
//       cameraFile = mydio.MultipartFile.fromBytes(cameraBytes,
//           filename: fileNameCamera, contentType: MediaType('application', '*'));
//
//       formData.files.add(MapEntry(ApiKeys.attachedFile3, cameraFile));
//     }
//     //logger.i(BookingConstants.appointmentType);
//
//     var url = AppUrls.baseUrl +
//         AppUrls.createHHCAppointment;
//
//     if (BookingConstants.appointmentType == 'phy') {
//       url = AppUrls.baseUrl + AppUrls.createAppointmentPhysiotherapy;
//     }
//     if (BookingConstants.appointmentType == 'hvd') {
//       url = AppUrls.baseUrl + AppUrls.createAppointmentHVD;
//     }
//
//     if (BookingConstants.appointmentType == 'tele') {
//       url = AppUrls.baseUrl + AppUrls.createAppointment;
//     }
//     if (Get.isRegistered<NurseServicesLogic>() && Get.find<NurseServicesLogic>().homeService.code == 'Car') {
//       url = AppUrls.baseUrl + AppUrls.requestCaregiver;
//     }
//     if (Get.isRegistered<NurseServicesLogic>() && Get.find<NurseServicesLogic>().homeService.code == 'SM') {
//       url = AppUrls.baseUrl + AppUrls.requestSleepMedicine;
//     }
//     if (BookingConstants.appointmentType == 'pcr') {
//       url = AppUrls.baseUrl + AppUrls.createAppointmentPcr;
//     }
//
//
//     // logger.i(url);
//     // print(url);
//
//     return await mydio.Dio().post(url,
//         options:
//             mydio.Options(contentType: 'multipart/form-data', headers: header),
//         data: formData);
//     // print(response.data);
//   }
//
//   Future<mydio.Response> updateImage() async {
//     var fileName = EditProfileLogic.profileImage!.path.split('/').last;
//
//     var bytes = await EditProfileLogic.profileImage!.readAsBytes();
//
//     var imageFile = mydio.MultipartFile.fromBytes(bytes,
//         filename: fileName, contentType: MediaType('image', '*'));
//
//     var formData = mydio.FormData.fromMap({'': ''});
//
//     formData.files.add(MapEntry(ApiKeys.profileImage, imageFile));
//
// //formData.fields.addAll(body);
//
//     var url = AppUrls.baseUrl + AppUrls.updateProfilePhoto + currentUser!.id;
//
//     var response = await mydio.Dio().put(url,
//         options:
//             mydio.Options(contentType: 'multipart/form-data', headers: header),
//         data: formData);
//     return response;
//   }





}
