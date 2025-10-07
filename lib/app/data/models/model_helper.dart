class ModelHelper {
  static checkInt(data, {int defaultVal = 0}) {
    return (data is int) ? data : defaultVal;
  }

  static checkString(data, {String defaultVal = ''}) {
    return (data != null && data is String) ? data : defaultVal;
  }

  static DateTime checkDate(data, {String defaultVal = ''}) {
    return DateTime.tryParse(data.toString()) ?? DateTime.now();
  }

  static checkDouble(data, {String defaultVal = ''}) {
    return (data != null && data is double) ? '$data' : defaultVal;
  }

  static checkPrice(data, {String defaultVal = '0'}) {
    return (data != null && data is String)
        ? double.parse(data.toString()).toStringAsFixed(0)
        : defaultVal;
  }
  static checkPriceDouble(data, {String defaultVal = '0'}) {
    return (data != null && data is double)
        ? double.parse(data.toString()).toStringAsFixed(0)
        : defaultVal;
  }

  static convertToPrice(data, {String defaultVal = '0'}) {
    return (data != null && data is double)
        ?  data.toStringAsFixed( int.parse( data.toString().split('.')[1])>0? 2:0)
        : defaultVal;
  }

  static checkListString(List<String> data, {String defaultVal = ''}) {
    var value = '';

    for (var element in data) {
      value += element;
      if (element != data.last) {
        value += '-';
      }
    }
    return value;
  }
}
