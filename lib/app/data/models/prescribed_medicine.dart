import 'model_helper.dart';

class PrescribedMedicine {
  final int id;
  final String dose,doseUnit,frequency,medicine,comment,date,time,status,image,doseRoute;


 List< PrescribedMedicine> prescribedMedicineSlots=[];

  PrescribedMedicine({
    this.id = 0,
    this.prescribedMedicineSlots=const[],
    this.medicine='',this.frequency='',this.doseUnit='',
    this.dose = '',this.comment='',this.date='',this.time='',this.status='',this.image='',this.doseRoute=''
  });


  factory PrescribedMedicine.fromJson(Map<String, dynamic> json) => PrescribedMedicine(
    id:ModelHelper.checkInt( json["id"]) ,
    medicine:ModelHelper.checkString( json["medicine"]) ,
    dose:ModelHelper.checkDouble( json["dose"]) ,
    doseUnit:ModelHelper.checkString( json["dose_unit"]) ,
    doseRoute:ModelHelper.checkString( json["dose_route"]) ,
    frequency:ModelHelper.checkString( json["frequency"],) ,
    image:ModelHelper.checkString( json["image_url"]) ,
    comment:ModelHelper.checkString( json["comment"]) ,
    date:ModelHelper.checkString( json["date"]) ,
      prescribedMedicineSlots: json["slots"] == null ? [] :
      List<PrescribedMedicine>.from(json["slots"].map((x) => PrescribedMedicine.fromJsonTime(x)))

  );
  factory PrescribedMedicine.fromJsonTime(Map<String, dynamic> json) => PrescribedMedicine(
    id:ModelHelper.checkInt( json["id"]) ,
    medicine:ModelHelper.checkString( json["medicine"]) ,

    date:ModelHelper.checkString( json["date"]) ,
    time:ModelHelper.checkString( json["time"]) ,
    status:ModelHelper.checkString( json["state"]) ,

  );

  static List<DateTime> dates=[

    DateTime(2022,8,29,8,0),
    DateTime(2022,8,29,13,0),
    DateTime(2022,8,29,20,0),
    DateTime(2022,8,30,8,0),
    DateTime(2022,8,30,13,0),
    DateTime(2022,8,30,20,0),
    DateTime(2022,8,31,9,0),
    DateTime(2022,8,31,15,0),
    DateTime(2022,8,31,21,0),
  ];

}
class PrescribedMedicineGroup{

  PrescribedMedicineGroup({required this.dateTime,this.items=const[]});
  DateTime dateTime;
  List<PrescribedMedicine> items=[];



}
