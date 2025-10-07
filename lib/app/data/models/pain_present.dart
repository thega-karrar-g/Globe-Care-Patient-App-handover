import 'model_helper.dart';

class PainPresent {
  final int id;
  final String score,comment,date,scale,recordId,caregiverId;

  PainPresent({
    this.id = 0,this.recordId='',this.caregiverId='',
    this.score = '',this.comment='',this.date='',this.scale=''
  });


  factory PainPresent.fromJson(Map<String, dynamic> json) => PainPresent(
    id:ModelHelper.checkInt( json["id"]) ,
    score:ModelHelper.checkString( json["pain_score"]) ,
    scale:ModelHelper.checkString( json["scale_used"]) ,
    comment:ModelHelper.checkString( json["comment"]) ,
    date:ModelHelper.checkString( json["date"]) ,

  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "record_id": recordId,
    "caregiver_id": caregiverId,
    "pain_score": score,
    "scale_used": scale,
    "comment": comment,


  };

}
