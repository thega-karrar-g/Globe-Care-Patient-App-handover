import 'model_helper.dart';

class Observation {
  final int id;
  final String nutritionalStatus,sleepingPattern,comment,date;

  Observation({
    this.id = 0,
    this.nutritionalStatus = '',this.sleepingPattern='',this.comment='',this.date=''
  });


  factory Observation.fromJson(Map<String, dynamic> json) => Observation(
    id:ModelHelper.checkInt( json["id"]) ,
    nutritionalStatus:ModelHelper.checkString( json["nutritional_status"]) ,
    sleepingPattern:ModelHelper.checkString( json["sleeping_pattern"]) ,
    comment:ModelHelper.checkString( json["progress_noted"]) ,
    date:ModelHelper.checkString( json["date"]??'2023-02-12') ,

  );
}
