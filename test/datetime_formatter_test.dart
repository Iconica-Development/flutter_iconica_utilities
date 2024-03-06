import 'package:flutter_iconica_utilities/src/date_extension/datetime_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DateTimeFormatter", () {
    test('should return dd-MM-yyyy format', () {
      var expected = "06/03/2024";

      var result = formatDayMonthYear(DateTime(2024, 3, 6));

      expect(result, expected);
    });

    test('should return dd-MM-yyyy format with custom separator', () {
      var expected = "06-03-2024";

      var result = formatDayMonthYear(DateTime(2024, 3, 6), separator: "-");

      expect(result, expected);
    });

    test('should return HH:mm format', () {
      var expected = "13:30";

      var result = formatHourMinute(DateTime(2024, 3, 6, 13, 30));

      expect(result, expected);
    });

    test('should return HH:mm:ss format', () {
      var expected = "13:30:00";

      var result = formatHourMinuteSecond(DateTime(2024, 3, 6, 13, 30));

      expect(result, expected);
    });
  });
}
