import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globcare/app/data/models/file_model.dart';
// import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_app_file/open_app_file.dart';

import '../modules/pdf_page/pdf_page_view.dart';

class ExtStorage {
  static Future<Directory> getDir() async {
    Directory? ex, directory;

    ex = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();

    //directory=Directory(ex!.path+'/Globcare');
    directory = ex!;

    if (!await ex.exists()) {
      directory = await Directory(directory.path).create(
        recursive: true,
      );
      return directory;
    } else {
      return directory;
    }
  }

  static Future<bool> checkGranted() async {
    return (await Permission.storage.request().isGranted);
  }

  static Future<bool> fileExist(String path) async {


    if(await Permission.storage.isDenied){


    }

    else{

     await Permission.storage.request();

    }

    var exist = false;
    var d = Directory('${(await getDir()).path}/$path');

    var s = await getDir();
    var ss = s.listSync();
    for (var element in ss) {
      if (element.path == d.path) {
        exist = true;
        break;
      }
    }
    return exist;
  }

  static Future<String> savePathFile(fileName) async {
    var dir = await getDir();
    return "${dir.path}/$fileName";
  }

  static downloadFile({String url = '', String fileName = ''}) async {
    var savePath = await savePathFile(fileName);

    try {
   //   print('*********************   $savePath');

      await Dio().download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
         // print("${(received / total * 100).toStringAsFixed(0)}%");
          //you can build progressbar feature too
        }
      });
    } on DioError catch (_) {
    }
  }

  static Future<void> openFile(String filePath) async {
    var d = await getDir();
   final result = await OpenAppFile.open("${d.path}/$filePath");


    // Get.toNamed(PdfPage.routeName,arguments: '${d.path}/$filePath');


  }




 static Future<bool?> getStoragePermission() async {
    // bool permissionGranted=false;
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    // IosDeviceInfo ios = await plugin.iosInfo;


    if(Platform.isAndroid) {
      AndroidDeviceInfo android = await plugin.androidInfo;

      if (android.version.sdkInt < 33) {
        if (await Permission.storage
            .request()
            .isGranted) {
          return true;
        } else if (await Permission.storage
            .request()
            .isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.audio
            .request()
            .isDenied) {
          return false;
        }
      } else {
        if (await Permission.photos
            .request()
            .isGranted) {
          return true;
        } else if (await Permission.photos
            .request()
            .isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.photos
            .request()
            .isDenied) {
          return false;
        }
      }
    }
    else{
      if (await Permission.storage
          .request()
          .isGranted) {
        return true;
      } else if (await Permission.storage
          .request()
          .isPermanentlyDenied) {
        await openAppSettings();
      }
    }

  }

}
