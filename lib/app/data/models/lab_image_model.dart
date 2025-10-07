import 'file_model.dart';

class LabImageModel {
  LabImageModel(
      {


      this.results=const[],
        this.requests=const[]
  });


  List<FileModel> requests;
  List<FileModel> results;

  factory LabImageModel.fromJson(Map<String, dynamic> json) => LabImageModel(

      requests: json["request"] == null
          ? []
          : List<FileModel>.from(
              json["request"].map((x) => FileModel.fromJson(x))),

    results: json["test"] == null
        ? []
        : List<FileModel>.from(
        json["test"].map((x) => FileModel.fromJson(x))),

      );

}

