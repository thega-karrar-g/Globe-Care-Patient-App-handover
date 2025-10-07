import 'dart:ui';

class TypesConversion {
  TypesConversion._();

  static double valueTypeToDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    }

    if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  static int valueTypeToInt(dynamic value) {
    if (value is String) {
      return int.parse(value);
    }

    if (value is int) {
      return value.toInt();
    }

    return value;
  }

  static bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  static bool valueTypeToBool(dynamic value) {
    bool newValue = false;
    if (value is String) {
      newValue = value == '0' ? false : true;
    }

    if (value is int) {
      newValue = value == 0 ? false : true;
    }

    if (value is bool) {
      newValue = value;
    }

    return newValue;
  }

  static double roundIntoNDecimal(dynamic value) {
    return double.parse((value).toStringAsFixed(2));
  }

  static Color getColorFromHex(dynamic hexColor) {
    if (hexColor is String) {
      hexColor = hexColor.replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
    }
    return Color(int.parse("0x$hexColor"));
  }

  static String getHexFromColor(Color color, {bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }
}
