import 'dart:convert';




import 'package:globcare/app/data/api/base_api.dart';
import 'package:globcare/app/data/models/record_model.dart';

import '../api/api_keys.dart';
import '../api/app_urls.dart';
import '../api/caregiver_api.dart';
import '../models/nurse_service.dart';
import '../models/observation.dart';
import '../models/pain_present.dart';
import '../models/prescribed_medicine.dart';
import '../models/vital_signs.dart';

class CaregiverRepository extends BaseApi{
  static final _caregiverRepository = CaregiverRepository._internal();

  factory CaregiverRepository() {
    return _caregiverRepository;
  }



  var errorMsg={
    ApiKeys.responseSuccess: 0,
    ApiKeys.responseMessage: 'Failed \ntry again'
  };

  var successMsg={
    ApiKeys.responseSuccess: 1,
    ApiKeys.responseMessage: 'successfully'
  };

  CaregiverRepository._internal();

  final CaregiverApi _caregiverApi = CaregiverApi();

  Future<RecordModel?> getRecordFile(String patientId) async {


   try{
     var response = await api.dioGet(AppUrls.getRecordFile+patientId);

// print(response!.statusCode);
// print(response!.data);
    var jsonData=response!.data!;


    var d = jsonData['data'] ;

      return RecordModel.fromJson(d);








    }catch(e){

     print(e.toString());
      return null;
    }

  }


  Future<List<PrescribedMedicine>> getMedicineSlots() async {


   try{
     var response = await _caregiverApi.getMedicineSlots();


    var jsonData=response!.data!;


    var d = jsonData['data'] as List ;



//print(d);



    List<PrescribedMedicine> dd = d.map((dr) {

      return PrescribedMedicine.fromJson((dr));

    }).toList();

    print(dd.length);
    return dd;
    }catch(e){

     print(e.toString());
      return [];
    }

  }





  Future<dynamic> addPainPresent(Map<String, dynamic> data) async {



    try{
      var response = await _caregiverApi.addPainPresent(data);
      print("****************************  ${response!.data}");


      var jsonData=response.data!;


      var d = jsonData[ApiKeys.responseSuccess] ;


      if(response.statusCode==200){


        if(d==1){

          return successMsg;

        }

      }
      else{

        return errorMsg;
      }





      // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
      return errorMsg;


    }catch(e){

      print(e.toString());
      return errorMsg;
    }

  }


  Future<dynamic> updateMedicineStatus(Map<String, dynamic> data) async {



    try{

      var response = await _caregiverApi.updateMedicineStatus(data);

      var jsonData=response!.data!;


      var d = jsonData[ApiKeys.responseSuccess] ;


      if(response.statusCode==200){


        if(d==1){

          return successMsg;

        }

      }
      else{

        return errorMsg;
      }





      // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
      return null;


    }catch(e){

      print(e.toString());
      return null;
    }

  }


  Future<dynamic> addVital(Map<String, dynamic> data) async {



    try{
      var response = await _caregiverApi.addVital(data);


      var jsonData=response!.data!;


      var d = jsonData[ApiKeys.responseSuccess] ;


      if(response.statusCode==200){


        if(d==1){

          return successMsg;

        }

      }
      else{

        return errorMsg;
      }





      // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
      return null;


    }catch(e){

      print(e.toString());
      return null;
    }

  }
  Future<dynamic> addObservation(Map<String, dynamic> data) async {



    try{

      var response = await _caregiverApi.addObservation(data);

      var jsonData=response!.data!;


      var d = jsonData[ApiKeys.responseSuccess] ;


      if(response.statusCode==200){


        if(d==1){

          return successMsg;

        }

      }
      else{

        return errorMsg;
      }





      // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
      return null;


    }catch(e){

      print(e.toString());
      return null;
    }

  }




  Future<List<VitalSigns>> getVitalList() async {


   try{
     var response = await _caregiverApi.getVitalList();

    var jsonData=response!.data;

    // print(jsonData);

    var d = jsonData['data'] as List;


    var dd = d.map((dr) {

        return VitalSigns.fromJson((dr));

    }).toList();



   // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
return dd;


    }catch(e){

     print(e.toString());
      return [];
    }

  }
  Future<List<Observation>> getObservationList() async {


   try{
     var response = await _caregiverApi.getObservationList();


    var jsonData=response!.data;

// print(jsonData);
    var d = jsonData['data'] as List;


    var dd = d.map((dr) {

        return Observation.fromJson((dr));

    }).toList();



   // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
return dd;


    }catch(e){

     print(e.toString());
      return [];
    }

  }



  Future<List<PainPresent>> getPainPresentList() async {

   try{
     var response = await _caregiverApi.getPainPresentList();


    var jsonData=response!.data;

    // print(jsonData);

    var d = jsonData['data'] as List;


    var dd = d.map((dr) {

        return PainPresent.fromJson((dr));

    }).toList();



   // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
return dd;


    }catch(e){

     print(e.toString());
      return [];
    }

  }



  Future<List<NurseService>> getServicesList() async {


   try{

     var response = await _caregiverApi.getServices();

    var jsonData= response!.data;


    var d = jsonData['data'] as List;


    var dd = d.map((dr) {

        return NurseService.fromJson((dr));

    }).toList();



   // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
return dd;


    }catch(e){

     print(e.toString());
      return [];
    }

  }


  Future<List<PrescribedMedicine>> getPrescribedMedicineList() async {


    try{

      var response = await _caregiverApi.getPrescribedMedicineList();

      var jsonData=response!.data;

// print(jsonData);
      var d = jsonData['data'] as List;


      var dd = d.map((dr) {

        return PrescribedMedicine.fromJson((dr));

      }).toList();



      // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
      return dd;


    }catch(e){

      print(e.toString());
      return [];
    }

  }
  Future<List<PrescribedMedicine>> getPrescribedMedicineTimesList({String medicineId=''}) async {
    var response = await _caregiverApi.getPrescribedMedicineTimesList(medicineId:medicineId);


    try{


      var jsonData=response!.data;


      var d = jsonData['data'] as List;


      var dd = d.map((dr) {

        return PrescribedMedicine.fromJsonTime((dr));

      }).toList();



      // return dd.where((element) => element.code=='N'||element.code=='V'||element.code=='GCP'||element.code=='MH'||element.code=='IVT'||element.code=='WBSDFC'||element.code=='SM').toList();
      return dd;


    }catch(e){

      print(e.toString());
      return [];
    }

  }




}
