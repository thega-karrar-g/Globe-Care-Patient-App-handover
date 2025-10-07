import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../global_widgets/shared/different_dialogs.dart';

class ViewFileItem extends StatelessWidget {
  const ViewFileItem({Key? key, required this.file, required this.onTab})
      : super(key: key);
  final File file;

  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        file.path.split('.').last.toLowerCase() != 'pdf'
            ? GestureDetector(
                onTap: () {
                  DifferentDialog.showImageDialog(file: file);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      //  borderRadius: BorderRadius.circular(1000),

                      ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        file,
                        width: 60,
                        height: 80,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      )),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.primaryColor.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                width: 100,
                //    height: 60,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(file.path.split('.').last.toString().toLowerCase() ==
                            'pdf'
                        ? FontAwesomeIcons.filePdf
                        : FontAwesomeIcons.fileImage),
                    Text(
                      file.path.split('/').last,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10),
                    ),

                    // Icon(Icons.clear,color: AppColors.red,),
                  ],
                ),
              ),
        Positioned.fill(
            child: GestureDetector(
          onTap: () {
            onTab();
            // logic.removeItem(index);
          },
          child: Align(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.remove_circle_outlined,
                color: AppColors.red,
              )),
        ))
      ],
    );
  }
}
