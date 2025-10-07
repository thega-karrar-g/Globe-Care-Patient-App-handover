
import 'dart:developer';

import '../api/doctor_api.dart';
import '../models/m_doctors.dart';
import '../models/schedule_model.dart';

class DoctorRepository {
  static final _doctorRepository = DoctorRepository._internal();

  factory DoctorRepository() {
    return _doctorRepository;
  }

  DoctorRepository._internal();

  final DoctorApi _doctorService = DoctorApi();

  Future<List<Doctor>> getDoctorsList({String drType = 'TD'}) async {
    var response = await _doctorService.getDoctors1(drType: drType);

    try {

    //   var jsonData=json.decode(response!.data.toString());

      var d = response!.data['data'] as List;

      // log(d.toString());
      //  List<Doctor> list=[];
//     for (var element in d) {
//
// if(element['role_type'].toString().contains('T')){
//
//  list.add( Doctor.fromJson((element)));
// }
//
//
//     }

      var dd = d.map((dr) {
        return Doctor.fromJson((dr));
      }).toList();

      return dd;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<ScheduleModel>> getScheduleList({String id = '1'}) async {
    var response = await _doctorService.getScheduleList(id: id);

    try {
      // print(response!.body);

      // var jsonData=json.decode(response!.body.toString());

      var d = response!.data['data'] as List;

      //  List<Doctor> list=[];
//     for (var element in d) {
//
// if(element['role_type'].toString().contains('T')){
//
//  list.add( Doctor.fromJson((element)));
// }
//
//
//     }

      var dd = d.map((dr) {
        return ScheduleModel.fromJson((dr));
      }).toList();

      return dd;
    } catch (_) {
      return [];
    }
  }

  Future<List<Doctor?>> getDoctorsList1() async {
    try {
      var response = await _doctorService.getDoctors1();

      var d = response!.data['data'] as List;

      var dd = d.map((dr) {
        if (dr['role_type'] == 'Telemedicine Doctor') {
          return Doctor.fromJson((dr));
        }
      }).toList();

      return dd;
    } catch (_) {
      return [];
    }
  }
}
