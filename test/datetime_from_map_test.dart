import 'package:flutter_iconica_utilities/src/serialization/datetime_from_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetNullableDateTime', () {
    group('getDateTime', () {
      var sut = <String, dynamic>{
        'parseable': DateTime(2012, 12, 12).toIso8601String(),
        'incorrect': 'incorrect',
        'wrong_type': 1,
      };

      test('should return a datetime if the datetime is parseable', () {
        var datetime = sut.getDateTime('parseable');

        expect(datetime, equals(DateTime(2012, 12, 12)));
      });
      test('should return null if the datetime is not parseable', () {
        expect(sut.getDateTime('incorrect'), null);
      });
      test('should return null if the value is not a string', () {
        expect(sut.getDateTime('wrong_type'), null);
      });
      test('should return null if no value exists', () {
        expect(sut.getDateTime('wrong_key'), null);
      });
    });
  });
}
