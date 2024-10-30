extension CastFromMap on Map {
  T? castOrNull<T>(String key) {
    var value = this[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  T cast<T>(String key) {
    return this[key] as T;
  }
}
