extension GetNullableDateTime on Map<String, dynamic> {
  DateTime? getDateTime(String key) {
    var stringRepresentation = this[key];
    if (stringRepresentation == null || stringRepresentation is! String) {
      return null;
    }

    return DateTime.tryParse(stringRepresentation);
  }
}
