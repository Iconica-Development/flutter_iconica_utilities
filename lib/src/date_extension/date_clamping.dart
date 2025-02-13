extension ClampDates on DateTime {
  /// Clamps 2 dates between the given [start] and [end] dates.
  ///
  /// if [this] date is before [start], [start] is returned.
  /// Similar, if [this] is after [end], end is returned.
  ///
  /// The main purpose of this method is to coerce invalid input within the
  /// ranges that are needed, for example for a datetime picker.
  DateTime clamp(DateTime start, DateTime end) {
    if (start.isAfter(this)) {
      return start;
    }
    if (end.isBefore(this)) {
      return end;
    }

    return this;
  }
}
