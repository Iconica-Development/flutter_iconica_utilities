// ignore_for_file: Generated using data class generator
import 'package:flutter_iconica_utilities/src/serialization/map_data.dart';
import 'package:flutter_test/flutter_test.dart';

class TestModel {
  final int number;
  final String text;
  TestModel({
    required this.number,
    required this.text,
  });

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      number: (map['number'] ?? 0) as int,
      text: (map['text'] ?? '') as String,
    );
  }

  @override
  bool operator ==(covariant TestModel other) {
    if (identical(this, other)) return true;

    return other.number == number && other.text == text;
  }

  @override
  int get hashCode => number.hashCode ^ text.hashCode;
}

main() {
  group('MapOrNull', () {
    group('getMappedOrNull', () {
      var sut = <String, dynamic>{
        'map': {
          'text': 'some text',
          'number': 1,
        },
        'invalid_type': 'test',
      };

      test('should return an object if a map exists', () {
        expect(
          sut.getMappedOrNull('map', TestModel.fromMap),
          equals(TestModel(
            number: 1,
            text: 'some text',
          )),
        );
      });

      test('should return null if the value is not a map', () {
        expect(sut.getMappedOrNull('invalid_type', TestModel.fromMap), isNull);
      });

      test('should return null if the value does not exist', () {
        expect(sut.getMappedOrNull('invalid_key', TestModel.fromMap), isNull);
      });
    });
  });
}
