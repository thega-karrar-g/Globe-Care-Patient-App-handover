import 'package:flutter/material.dart';

class LanguageListModel {
  final int id;

  //final String flag; //  emoji flag are string "🇺🇸" "🇸🇦"
  final String name;
  final String languageCode;

  LanguageListModel(this.id, this.name, this.languageCode);

  static List<LanguageListModel> languageList() {
    return <LanguageListModel>[
      LanguageListModel(1, "English", 'en'),
      LanguageListModel(2, " اَلْعَرَبِيَّةُ‎", 'ar'),
    ];
  }

  static List<DropdownMenuItem> myDropDownMenuItem() {
    return languageList()
        .map<DropdownMenuItem<LanguageListModel>>(
          (e) => DropdownMenuItem<LanguageListModel>(
            value: e,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
//                Text(
//                  e.flag,
//                  style: TextStyle(fontSize: 30),
//                ),
                Text(e.name)
              ],
            ),
          ),
        )
        .toList();
  }
}
