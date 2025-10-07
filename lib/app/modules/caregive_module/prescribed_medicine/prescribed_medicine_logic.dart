
import '../../../base_controller/base_controller.dart';
import '../../../data/models/prescribed_medicine.dart';
import '../../../data/repositories/caregiver_repository.dart';



class PrescribedMedicineLogic extends BaseController {

  CaregiverRepository caregiverRepository=CaregiverRepository();

  String medicineStatus='wait';
  List<String> states=['wait','given','canceled','missed'];

  List<PrescribedMedicine> currentMedicines=[];
  List<PrescribedMedicine> allMedicines=[

    PrescribedMedicine(medicine: 'VIDROP ORAL DROPS',dose: '4.00',doseUnit: '	Drops',frequency: 'After breakfast',comment: 'given to both babies ', date: '2022-07-12 15:20:53',status: 'wait'),
    PrescribedMedicine(medicine: 'Dicoflor',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'given to both babies at 6:10am', date: '2022-07-12 17:20:53',status: 'wait'),
    PrescribedMedicine(medicine: 'Dicoflor',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'given to both babies at 6:10am', date: '2022-07-12 17:20:53',status: 'wait'),


    PrescribedMedicine(medicine: 'Dicoflor',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'given to both babies at 6:10am', date: '2022-07-12 17:20:53',status: 'given'),
    PrescribedMedicine(medicine: 'Dicoflor',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'given to both babies at 6:10am', date: '2022-07-12 17:20:53',status: 'given'),
    PrescribedMedicine(medicine: 'Dicoflor',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'given to both babies at 6:10am', date: '2022-07-12 17:20:53',status: 'given'),
    PrescribedMedicine(medicine: 'Dicoflor',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'given to both babies at 6:10am', date: '2022-07-12 17:20:53',status: 'given'),
    PrescribedMedicine(medicine: 'Dicoflor',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'given to both babies at 6:10am', date: '2022-07-12 17:20:53',status: 'given'),
    PrescribedMedicine(medicine: 'Dicoflor',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'given to both babies at 6:10am', date: '2022-07-12 17:20:53',status: 'given'),



    PrescribedMedicine(medicine: 'VIDROP',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'patient cant take it', date: '2022-07-12 17:20:53',status: 'canceled'),
    PrescribedMedicine(medicine: 'VIDROP',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'patient cant take it', date: '2022-07-12 17:20:53',status: 'canceled'),
    PrescribedMedicine(medicine: 'VIDROP',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'patient cant take it', date: '2022-07-12 17:20:53',status: 'canceled'),
    PrescribedMedicine(medicine: 'VIDROP',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'patient cant take it', date: '2022-07-12 17:20:53',status: 'canceled'),

    PrescribedMedicine(medicine: 'VIDROP',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'patient cant take it', date: '2022-07-12 17:20:53',status: 'missed'),
    PrescribedMedicine(medicine: 'VIDROP',frequency: 'After breakfast',dose: '3.00',doseUnit: '	Drops',comment: 'patient cant take it', date: '2022-07-12 17:20:53',status: 'missed'),


  ];



  updateMedicineStatus(String _status){

    medicineStatus=_status;

    currentMedicines=allMedicines.where((element) => element.status==_status).toList();
    update();


  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

getData();



    // updateMedicineStatus(states[0]);
  }


  getData()async{
    setBusy(true);
    currentMedicines =await caregiverRepository.getPrescribedMedicineList();

        setBusy(false);

  }

}
