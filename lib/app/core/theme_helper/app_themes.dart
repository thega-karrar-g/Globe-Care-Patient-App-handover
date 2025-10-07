import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppThemes {
  AppThemes._();

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
    scaffoldBackgroundColor: AppColors.darkAccentColor,
    brightness: Brightness.dark,
    focusColor: AppColors.darkFocusedColor,
    cardColor: AppColors.darkFocusedColor,
    iconTheme: IconThemeData(color: AppColors.primaryColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkFocusedColor),
   // bottomAppBarColor: AppColors.darkFocusedColor,
    hintColor: AppColors.white,
    hoverColor: AppColors.grandiant2,
    splashColor: AppColors.darkAccentColor,
    //  toggleableActiveColor: Ui.parseColor(setting.value.mainDarkColor),
  //  toggleableActiveColor: AppColors.grandiant2,
    fontFamily: AppFonts.mainFontFamily,
    unselectedWidgetColor: AppColors.subTitleColor,
    textTheme: TextTheme(
      // headline6: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: AppColors.grandiant2, height: 1.3),
      // headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppColors.subtitleColor, height: 1.3),
      // headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: AppColors.subtitleColor, height: 1.3),
      // headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: AppColors.subtitleColor, height: 1.3),
      // headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: AppColors.subtitleColor, height: 1.4),
      // headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: AppColors.subtitleColor, height: 1.4),
      // subtitle2: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold, color:  AppColors.primaryColor, height: 1.2),
      // subtitle1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color:  AppColors.subtitleColor, height: 1.2),
      // bodyText2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color:  AppColors.bodyText2Color, height: 1.2),
      // bodyText1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color:  AppColors.subtitleColor, height: 1.2),
      // caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color:  AppColors.primaryColor, height: 1.2),
      //


    ),
    //  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor)
  );

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,

    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    hintColor: AppColors.hintColor,
    brightness: Brightness.light,
   // bottomAppBarColor: AppColors.white,
    cardColor: AppColors.white,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: AppColors.white),
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
    ),

   // errorColor: AppColors.failedColor,
    //backgroundColor: AppColors.scaffoldBackgroundColor,
    // cardColor: AppColors.cardBackgroundColor,
    // cardTheme: CardTheme(
    //   clipBehavior: Clip.antiAlias,
    //   elevation: 0,
    //   margin: EdgeInsets.zero,
    //   shape: SharedStyle.roundedRectangleBorderShape(),
    //   color: AppColors.cardBackgroundColor,
    // ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.inputFillColor,
      isDense: true,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.primaryColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.accentColor, side: const BorderSide(
          color: AppColors.primaryColor,
          style: BorderStyle.solid,
          width: 1,
        ),
        shape: const StadiumBorder(),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.scaffoldBackgroundColor, backgroundColor: AppColors.primaryColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        // onPrimary: AppColors.scaffoldBackgroundColor,
      ),
    ),
    // radioTheme: RadioThemeData(
    //   // fillColor:MaterialStateProperty.all(Colors.green),
    //   overlayColor: MaterialStateProperty.all(Colors.green),
    // ),
    fontFamily: AppFonts.mainFontFamily,
    // textTheme: const TextTheme(
    //   subtitle2: TextStyle(
    //     color: AppColors.subtitle2Color,
    //   ),
    //   subtitle1: TextStyle(
    //     color: AppColors.white,
    //   ),
    //   bodyText1: TextStyle(
    //     color: AppColors.body1Color,
    //     // fontWeight: FontWeight.normal,
    //   ),
    //   bodyText2: TextStyle(
    //     color: AppColors.body2Color,
    //     // fontWeight: FontWeight.normal,
    //   ),
    //   headline3: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
    //   headline6:
    //       TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
    //   headline5: TextStyle(
    //     color: AppColors.primaryColor,
    //   ),
    //   // overline: TextStyle(
    //   //   color: Colors.grey.shade300,
    //   // ),
    // ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: AppColors.white,
      elevation: 2,
    ),
    snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(
      fontFamily: AppFonts.mainFontFamily,
    )),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // colorScheme: const ColorScheme.light(secondary: AppColors.accentColor).copyWith(secondary: AppColors.accentColor),
  );
}
