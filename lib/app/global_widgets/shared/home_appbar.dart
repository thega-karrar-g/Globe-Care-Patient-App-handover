import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../core/theme_helper/app_colors.dart';

Widget homeAppBar({String title = '', GlobalKey<ScaffoldState>? key}) {
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0, left: 2.0),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    // onTap: (){
                    //   Get.back();
                    // },
                    onTap: () => key!.currentState!.openDrawer(),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.sort, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title.tr,
                        style: (
                            TextStyle(color: AppColors.white, fontSize: 26)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // GestureDetector(
                      //   // onTap: () => showModalBottomSheet(
                      //   //     context: context,
                      //   //     builder: (context) {
                      //   //       return ModalBottomSheet();
                      //   //     }),
                      //   child: FaIcon(
                      //     FontAwesomeIcons.filter,
                      //     color: Colors.white,
                      //     size: 20,
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 16,
                      // ),
                      GestureDetector(
                        // onTap: () => Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DoctorLocations(doctorList: _con!.doctors),
                        //   ),
                        // ),
                        child: FaIcon(
                          FontAwesomeIcons.search,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // Padding(
            //   padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            //   child: Container(
            //     height: 58,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(8),
            //       boxShadow: [
            //         BoxShadow(
            //           offset: Offset(0, 0),
            //           color: Colors.white,
            //           blurRadius: 1,
            //         ),
            //       ],
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.all(4.0),
            //       child: SearchBarWidget(
            //         onClickFilter: (event) {
            //           // widget.parentScaffoldKey!.currentState!.openEndDrawer();
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ],
  );
}
