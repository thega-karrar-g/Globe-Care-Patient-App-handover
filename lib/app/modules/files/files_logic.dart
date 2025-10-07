import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:globcare/app/data/models/user_model.dart';
import 'package:intl/intl.dart';

import '../../base_controller/base_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../data/models/home_service.dart';
import '../../data/models/file_model.dart';
import '../../data/repositories/files_repository.dart';
import '../../data/api/app_urls.dart';
import '../../utils/ext_storage.dart';

class FilesLogic extends BaseController {
  var dir = '';
  final FilesRepository _filesRepository = FilesRepository();
  HomeService homeService=Get.arguments;
  var title ='';
  String code ='';
 late AppUser  user ;

  bool isRequest = true;

  bool isLabOrImage = false;
  bool isLab = false;



  GlobalKey key = GlobalKey();

  List<FileModel> files = [],currentFiles=[];
  List<MyFileGroup> filesGroup=[];

  var granted = false;
  var url = AppUrls.prescriptionUrls;

  @override
  void onInit() async {
    super.onInit();
    user=homeService.user!;
    url=homeService.url;
    title=homeService.name;
    code=homeService.code;


    isLabOrImage=[AppUrls.imageTestsRequestsUrls,AppUrls.labTestsRequestsUrls].contains(url);
    isLab= AppUrls.labTestsRequestsUrls==url;

    if (await ExtStorage.getStoragePermission()==true) {
      setGranted(true);

      dir = (await ExtStorage.getDir()).path;

      // Either the permission was already granted before or the user just granted it.

    } else {
      setGranted(false);
    }

      getFiles(code: code);

  }

  setGranted(bool status) {
    granted = status;
    update();
  }

  getFiles({String code = 'R'}) async {
    setBusy(true);
    files = await _filesRepository.getFileList(id: user.id, url: url);

    print(files.length);
    if (url==AppUrls.prescriptionUrls || code == 'IC') {
      var instantConFiles = await _filesRepository.getFileList(
          id: user.id, url: AppUrls.getInstantConsultation);

      files = [
        ...instantConFiles.where((element) => element.state == 'completed'),
        ...files
      ];
// print(files.length);
    }
    currentFiles.clear();

    // currentFiles.addAll(files);

    files=files.toSet().toList();

    currentFiles.addAll(files);
    //print(currentFiles.length);

    filesGroup= groupFilesByData(currentFiles);
   // print(filesGroup.length);


   // for (var element in filesGroup) {
   //
   //
   //   print("files length ${element.files.length }");
   //
   // }


    if([AppUrls.labTestsRequestsUrls,AppUrls.imageTestsRequestsUrls].contains(url)) {
      updateLabImageStatus(isRequestValue: true);
    }

    setBusy(false);
  }


  updateLabImageStatus({required  bool isRequestValue}){

    isRequest=isRequestValue;

    currentFiles=files.where((f)=>f.isRequest ==isRequest).toList();
    filesGroup= groupFilesByData(currentFiles);

    update();
  }



  List< MyFileGroup> groupFilesByData(List<FileModel> files) {
    final groups = groupBy(files, (FileModel e) {
      var d=DateTime.parse(e.date);
      return DateTime(d.year,d.month,d.day);
    });
    filesGroup.clear();
    groups.forEach((key, value) {

      filesGroup.add(MyFileGroup(dateTime: key,files: value));

    });
     filesGroup.sort((a, b) =>  a.dateTime .compareTo(b.dateTime));
    return  filesGroup.reversed.toList();
  }

  String dateConverter(DateTime myDate) {
    String date='Today';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = myDate;
    final checkDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (checkDate == today) {
      date = AppStrings.today;
    } else if (checkDate == yesterday) {
      date = AppStrings.yesterday;
    }
    else {
      date = DateFormat("d MMM yyyy",Get.locale.toString()).format(myDate);
    }
    return date;
  }



}
