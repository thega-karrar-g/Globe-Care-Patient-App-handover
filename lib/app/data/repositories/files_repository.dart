import 'package:globcare/app/base_controller/base_controller.dart';
import 'package:globcare/app/data/api/base_api.dart';

import '../api/api_keys.dart';
import '../api/app_urls.dart';
import '../api/files_api.dart';
import '../models/file_model.dart';

class FilesRepository extends BaseApi{
  static final _filesRepository = FilesRepository._internal();

  factory FilesRepository() {
    return _filesRepository;
  }

  FilesRepository._internal();

  // final FilesApi _prescriptionApi = FilesApi();

  Future<List<FileModel>> getFileList(
      {String id = '', String url = AppUrls.prescriptionUrls}) async {
    // try {
      var response = await api.dioGet(url+id);
List<FileModel> files=[];
      var jsonData = response!.data;
      // print(jsonData);
      if (jsonData[ApiKeys.responseSuccess] == 1) {


        var data = jsonData['data'];

        if(data is List) {

          for (var e in data) {
          files.add(  FileModel.fromJson(e));

          }


        }

        else if(data is Map ){

          var requests=data['request'] as List;
          var tests=data['test'] as List;

          for (var req in requests) {

            var request= FileModel.fromJson(req);

            request.isRequest=true;

            files.add(request);


          }
          for (var t in tests) {

            var test= FileModel.fromJson(t);

            test.isRequest=false;

            files.add(test);


          }


        }



        return files;
      } else {
        return [];
      }
    // } catch (_) {
    //   return [];
    // }
  }

  var d = [
    {
      "id": 3,
      "name": "PR0003",
      "patient": "[HP0002] Ahmed Ali ",
      "doctor": "فياض القصير جدا",
      "date": "2021-10-11 05:34:59",
      "info": "",
      "prescription_line": [
        {
          "name": "acetazolamide",
          "indication": "Cholera",
          "dose": "1",
          "start_treatment": "2021-10-02 10:58:15",
          "end_treatment": ""
        }
      ]
    },
    {
      "id": 2,
      "name": "PR0002",
      "patient": "[HP0002] Ahmed Ali ",
      "doctor": "عمر الطويل",
      "date": "2021-10-11 05:34:59",
      "info": "",
      "prescription_line": []
    },
    {
      "id": 1,
      "name": "PR0001",
      "patient": "[HP0002] Ahmed Ali ",
      "doctor": "فياض القصير جدا",
      "date": "2021-10-11 05:34:59",
      "info": "",
      "prescription_line": []
    }
  ];
}
