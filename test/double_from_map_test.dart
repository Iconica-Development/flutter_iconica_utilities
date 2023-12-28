import 'package:flutter_iconica_utilities/iconica_utilities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JsonDoubleParsing', () {
    group('parseToDoubleOr', () {
      Map<String, dynamic> sut = {
        'value': 1.0,
      };
      test('should return value if value exists', () {
        expect(sut.parseToDoubleOr('value'), equals(1.0));
      });
      test(
        'should return 0.0 if no value exists while no default is provided',
        () {
          expect(sut.parseToDoubleOr('no_value'), equals(0.0));
        },
      );
      test('should return defaultvalue if no value exists', () {
        expect(sut.parseToDoubleOr('no_value', defaultValue: 2.0), equals(2.0));
      });
    });

    group('parseToDouble', () {
      Map<String, dynamic> sut = {
        'string': '1.0',
        'string_int': '1',
        'int': 1,
        'empty_string': '',
        'object': {},
        'null': null,
        'double': 1.0,
      };

      test(
        'should properly parse strings to doubles',
        () {
          expect(sut.parseToDouble('string'), equals(1.0));
          expect(sut.parseToDouble('string_int'), equals(1.0));
          expect(sut.parseToDouble('empty_string'), isNull);
        },
      );

      test(
        'should properly parse ints to doubles',
        () {
          expect(sut.parseToDouble('int'), equals(1.0));
        },
      );

      test(
        'should properly retrieve doubles',
        () {
          expect(sut.parseToDouble('double'), equals(1.0));
        },
      );

      test(
        'should return null if result does not exist',
        () {
          expect(sut.parseToDouble('does_not_exist'), isNull);
          expect(sut.parseToDouble('null'), isNull);
        },
      );

      test(
        'should return null if result is not parseable',
        () {
          expect(sut.parseToDouble('object'), isNull);
        },
      );
    });
  });
}
