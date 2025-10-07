import 'dart:io';
import 'dart:math';

import 'package:fc_native_image_resize/fc_native_image_resize.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:globcare/app/modules/booking_home_modules/nurse_services/nurse_services_logic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' ;
import 'package:reactive_forms/reactive_forms.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/models/branch.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../routes/app_route_names.dart';
import '../../../data/api/api_keys.dart';
import '../appointment_base_controllers/booking_base_controller.dart';
import '../choose_date_period/choose_date_period_logic.dart';
import '../pcr/choose_date/choose_date_logic.dart';

class PatientDataLogic extends BaseController {

  String defaultBranch="riyadh";
  static ChooseDateType chooseDateType = ChooseDateType.other;
  static String previousRoute ='';
  final nativeImgUtilPlugin = FcNativeImageResize();

  final ProfileRepository _profileRepository = ProfileRepository();

bool isCaregiverOrSleep=false,showCaregiverContractDetails=false;

  List<String> nationalityList=["African","Philippine","Indonesia","Other"];
  // List<Branch> branchList=[
  //   Branch(id: 1,nameAr: 'الرياض',nameEn: 'Riyadh',code: 'riyadh'),
  //   Branch(id: 2,nameAr: 'الدمام',nameEn: 'Dammam',code: 'dammam'),
  //
  //
  // ];

  String requiredNationality='';
  GlobalKey periodsKey = GlobalKey();
  List<AppUser> members = [];

  final ImagePicker _picker = ImagePicker();

  List<File> cameraFiles = [];
  List<PlatformFile> files = [];

  static List<File> uploadFiles = [];

  bool isSend = false;

  late FormGroup form;

  Future<void> pickFiles() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
      ],
    );

    if (result != null) {
      //   uploadFiles.addAll(  result.files.map((f) => File(f.path!)).toList());
      // files.addAll(result.files);

      print(result.files.first.path);

      var f = File(result.files.first.path!);

      int sizeInBytes = await f.length();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      if (sizeInMb > 1) {
        buildFailedSnackBar(msg: AppStrings.fileErrorMsg.tr);
        // This file is Longer the
      } else {
        BookingConstants.attachFile = File(result.files.first.path!);
        // currentFile=result.files.first;
        update();
      }
    } else {
      // User canceled the picker
    }
  }

  Future<void> pickCamera() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (photo != null) {
      var dt = DateTime.now();
      var name = dt
          .toString()
          .replaceAll(' ', '')
          .replaceAll(':', '')
          .replaceAll('-', '')
          .replaceAll('.', '');
      String dir = dirname(photo.path);
      String newPath = join(dir, '$name.jpg');
      //photo.renameSync(newPath);
      var f = File(photo.path);
      BookingConstants.cameraFile = await f.copy(newPath);

      // ImageProperties properties = await FlutterNativeImage.getImageProperties(
      //     BookingConstants.cameraFile!.path);

      // BookingConstants.cameraFile = await FlutterNativeImage.compressImage(
      //     BookingConstants.cameraFile!.path,
      //     quality: 70,
      //     targetWidth: 600,
      //     targetHeight: (properties.height! * 600 / properties.width!).round());


      await nativeImgUtilPlugin.resizeFile(
          srcFile: BookingConstants.cameraFile!.path,
          destFile: BookingConstants.cameraFile!.path,
          width: 300,
          height: 300,
          keepAspectRatio: true,
          format: 'jpg',
          quality: 90);

//cameraFile=File(ff.path);

      //    uploadFiles.add(ff);
      //  files.add(PlatformFile(path: ff.path,name: ff.path.split('/').last, size: size.toInt(),bytes: await ff.readAsBytes(),));
      update();
    }
  }

  double getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return 0;
    //const suffixes = [" Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    var d = ((bytes / pow(1024, i)));
    return d;
  }

  String getFileSize(int bytes, int decimals) {
    //var file = File(filepath);
    //int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();

    var d =
        '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';

    return d;
  }

  var fileRequired = false;

  AppUser? selectedPatient;

  void updateSelectedPatient(AppUser user) {
    selectedPatient = user;
    BookingConstants.patient = user;

    update();
  }
  bool  isDateTimeHidden=[ChooseDateType.doctor,ChooseDateType.sleepMedicine,ChooseDateType.caregiver,ChooseDateType.hide].contains(PatientDataLogic.chooseDateType);

  @override
  void onInit()  {
    super.onInit();


    init();

  }

  void init(){
    previousRoute=Get.previousRoute;

    BookingConstants.branch=null;

    if(Get.isRegistered<NurseServicesLogic>()){


      if(['Car','SM'].contains(Get.find<NurseServicesLogic>().homeService.code)){

        if(Get.find<NurseServicesLogic>().homeService.code=="Car"){

          showCaregiverContractDetails=true;
        }

        isCaregiverOrSleep=true;
        // branchList.removeLast();
        // selectedBranch=branchList.first;

        BookingConstants.branch=defaultBranch;
      }
      else{
        BookingConstants.branch=null;
      }

    }



    selectedPatient = null;
    BookingConstants.patient = null;
    if(BookingConstants.service.name ==AppStrings.homeVisitDoctor){
      // selectedBranch =BookingConstants.branch;
    }

    if (checkUserSignIn) {

      if(Get.arguments == 'Car'){
        selectedPatient=currentUser;
        BookingConstants.patient = currentUser;

      }
      else {
        fetch();
      }
    }

    if (BookingConstants.serviceCode.isNotEmpty) {
      fileRequired = true;
    } else {
      fileRequired = false;
    }

    if (Get.arguments == 'Car') {
      isSend = true;
      selectedPatient=currentUser;

      form = FormGroup({
        ApiKeys.patientKey:
        FormControl<String>(validators: [Validators.required]),
        ApiKeys.formMobile:
        FormControl<String>(validators: [Validators.required]),
      });
    } else {
      isSend = false;
    }
  }


  void updateNationality(String n){
    requiredNationality=n;

    update();
  }

  Future<void> fetch() async {
    members.clear();
    members.add(currentUser!);
    setBusy(true);
    var list = await _profileRepository.getMemberList();
    members.addAll(list);
    setBusy(false);
    update();
  }

  void navToNext() {
    //print(PatientDataLogic.service.toJson());
    print("****************  from nav patient data type: ${BookingConstants.appointmentType}");

    if (currentUser != null) {

      if(BookingConstants.branch !=null) {
        if (selectedPatient != null) {
          // if (isSend) {
          //   if (requiredNationality.isNotEmpty) {
          //     BookingConstants.appointmentType = 'Car';
          //     // soonMessage();
          //     Map<String, String> data = {
          //       ApiKeys.patientKey: BookingConstants.patient!.id,
          //       ApiKeys.formMobile: currentUser!.phone,
          //       ApiKeys.nationalityKey: currentUser!.nationality.toString(),
          //       ApiKeys.serviceId: '${BookingConstants.service.id}',
          //       ApiKeys.patientComment: BookingConstants.patientComment.text
          //           .toString(),
          //       ApiKeys.location: BookingConstants.location,
          //       ApiKeys.caregiverNationality: requiredNationality,
          //     };
          //     AppointmentBaseController().requestCareGiver(data);
          //   }
          //
          //   else {
          //     buildFailedSnackBar(
          //         msg: AppStrings.selectCaregiverNationalityMsg.tr);
          //   }
          // }
          // else if (Get.arguments == 'SM') {
          //   Get.toNamed(AppRouteNames.sleepQuestionnaire);
          // }
          // else

          {
            if (Get.previousRoute == AppRouteNames.doctorSchedule) {
              Get.toNamed(AppRouteNames.invoicePage);
            } else if (Get.previousRoute == AppRouteNames.fillData) {
              try {

            if (ChooseDateLogic.selectedSlot.isNotEmpty) {
                  Get.toNamed(
                    AppRouteNames.invoicePage,
                  );



                } else {
                  buildFailedSnackBar(msg: AppStrings.selectTimeMsg.tr);


                }
              } catch (e) {
                buildFailedSnackBar(msg: AppStrings.selectTimeMsg.tr);
              }
            } else {


              bool isRegistered=Get.isRegistered<NurseServicesLogic>();


              if(isRegistered && ['Car','SM'].contains(Get.find<NurseServicesLogic>().homeService.code)){


                BookingConstants.appointmentDate=DateTime.now();
                Get.toNamed(AppRouteNames.invoicePage,);


              }

              else if (ChooseDatePeriodLogic.selectedPeriod.isNotEmpty) {
                BookingConstants.period = ChooseDatePeriodLogic.selectedPeriod;
                BookingConstants.appointmentDate =
                    ChooseDatePeriodLogic.selectedTime;

                // print(BookingVars.period);
                // print(BookingVars.appointmentDate);

                Get.toNamed(AppRouteNames.invoicePage);
              }
              else {
                buildFailedSnackBar(msg: AppStrings.selectPeriodMsg.tr);
              }
            }

            // if (PatientDataLogic.serviceCode.isNotEmpty) {
            //   if (PatientDataLogic.attachFile==null&&PatientDataLogic.cameraFile==null) {
            //     buildFailedSnackBar(
            //         msg: AppStrings.attachmentRequiredMsg.tr);
            //   }
            //   else {
            //     // PatientDataLogic.paymentType = 'cash';
            //
            //
            //     Get.toNamed(AppRouteNames.invoicePage);
            //   }
            // }
            // else {
            //   Get.toNamed(AppRouteNames.invoicePage);
            // }
          }
        }
        else {
          buildFailedSnackBar(msg: AppStrings.selectPatientMsg.tr);
        }
      }
      else{
        buildFailedSnackBar(msg: AppStrings.selectBranchMsg.tr);

      }


    } else {
      Get.toNamed(AppRouteNames.login);
    }
  }
}
