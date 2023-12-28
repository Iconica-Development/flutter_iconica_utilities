extension JsonDoubleParsing on Map<String, dynamic> {


  /// Tries to fetch a double from the map, or null if none is found
  double? parseToDouble(String key) {
    var value = this[key];
    if (value != null) {
      if (value is String) {
        return double.tryParse(value);
      }
      if (value is num) {
        return value.toDouble();
      }
    }
    return null;
  }


  /// Uses [parseToDouble] to fetch a value or returns [defaultValue]
  double parseToDoubleOr(String key, {double defaultValue = 0.0}) =>
      parseToDouble(key) ?? defaultValue;
}
