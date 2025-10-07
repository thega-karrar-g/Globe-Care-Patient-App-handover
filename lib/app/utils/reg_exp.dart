class RegExps {
  //r"^[\u0621-\u064Aa-zA-Z\d\-_\s]+"
  static const String isName = r"^[\u0621-\u064Aa-zA-Z\s]+";
  static const String isSSN = r'^[12][0-9]*$';
  static const String nonStartZero = r'^[123456789][0-9]*$';
  static const String isPhone = r'^[5][0-9]*$';
  static const String hasSpace = r"\s\b|\b\s";
  static const String alphanumeric = r'^[a-zA-Z0-9]+';
}
