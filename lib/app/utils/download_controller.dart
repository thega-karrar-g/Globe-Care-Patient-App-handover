import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/shared/different_dialogs.dart';

import '../base_controller/base_controller.dart';
import 'ext_storage.dart';

class DownloadController extends BaseController {
  double progress = 0.0;
  final ext = '.pdf';

  bool downloaded = false;

  downloadFile({String url = '', String fileName = ''}) async {
    var exist = await ExtStorage.fileExist(fileName + ext);
    var savePath = await ExtStorage.savePathFile(fileName + ext);
    if (!exist) {
   //   print('    ***************************************  start download');

      try {
        downloaded = false;
        progress = 0;
        //   setBusy(true);
        // DifferentDialog.showProgressDownloadDialog();
     var res=   await Dio().download(url, savePath,
            onReceiveProgress: (received, total) {
          if (total != -1) {
            print("${(received / total * 100).toStringAsFixed(0)}%");
            //you can build progressbar feature too

            progress =
                double.parse((received / total * 100).toStringAsFixed(0));
            //print('****************  $progress');
            update();
          }
        });


     // print("*******************************   ${res.statusCode}");

        if (progress == 100) {
          downloaded = true;
        }

       // progress=0;
        // setBusy(false);
      //  print("File is saved to download folder.");
      } catch (e) {
      //  print("******************************* this is from catch ");
      //  print(e.toString());
        Get.back();

    Future.delayed(Duration(milliseconds: 500),(){
      buildFailedSnackBar(msg: "Sorry Can't download this  file now");


    });
        //DifferentDialog.hideProgressDialog();
      }
    }

    else{
      print('    ***************************************  exist');

    }

  }
}
