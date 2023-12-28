extension MapOrNull on Map<String, dynamic> {
  T? getMappedOrNull<T>(
    String key,
    T Function(Map<String, dynamic> value) transform,
  ) {
    var mapRepresentation = this[key];
    if (mapRepresentation == null ||
        mapRepresentation is! Map<String, dynamic>) {
      return null;
    }

    return transform(mapRepresentation);
  }
}
