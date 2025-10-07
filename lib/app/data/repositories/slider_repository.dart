
import 'package:dio/dio.dart';

import '../api/api_keys.dart';
import '../api/app_urls.dart';
import '../api/base_api.dart';
import '../api/files_api.dart';
import '../models/file_model.dart';
import '../models/notification_model.dart';
import '../models/slides_model.dart';

class SliderRepository extends BaseApi{
  static final _sliderRepository = SliderRepository._internal();

  factory SliderRepository() {
    return _sliderRepository;
  }

  SliderRepository._internal();


  Future<List<SliderModel>> getSliderList() async {
    try {
      var response = await api.dioGet(AppUrls.sliders);

      if(response ==null){
        return [];
      }

      var jsonData = response.data;
      if (jsonData[ApiKeys.responseSuccess] == 1) {
        var data = jsonData['data'] as List;
        return data.map((s) {
          return SliderModel.fromJson(s);
        }).toList();

      } else {
        return [];
      }
    } on DioException catch (e) {

      logger.e(e.message);

      return [];
    }
  }

}
