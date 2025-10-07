import 'package:flutter/material.dart';

class SharedStyle {
  SharedStyle._();

  static BoxDecoration containerBoxDecoration({
    double radius = 8,
    Color color = Colors.white,
    // Color borderColor = Colors.white,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      // border: Border.all(color: Colors.black54),
    );
  }

  static RoundedRectangleBorder roundedRectangleBorderShape(
      {double radius = 8}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static const BoxDecoration boxDecorationWithRadiusAndShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0.7, 0.7),
        blurRadius: 8.0,
      ),
    ],
  );

//var kMaskTextInputFormatter = MaskTextInputFormatter(
//  mask: "+967 ### ### ###",
//  filter: {"#": RegExp(r'[0-9]')},
//);

  static BoxDecoration disabledFieldDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);

  static formBuilderWidgetDecoration({
    bool filled = true,
    String? label,
    BorderRadius? borderRadius,
    BorderSide borderSide = BorderSide.none,
    Color fillColor = Colors.white,
  }) {
    return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      filled: filled,
      fillColor: fillColor,
      isDense: true,
      border: OutlineInputBorder(
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(8)),
        borderSide: borderSide,
      ),
    );
  }
}
