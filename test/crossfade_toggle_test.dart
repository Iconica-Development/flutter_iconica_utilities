import 'package:flutter/widgets.dart';
import 'package:flutter_iconica_utilities/src/crossfade_toggle/crossfade_toggle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CrossFade', () {
    group('toggle', () {
      test('should return showSecond if called on showFirst', () {
        expect(
          CrossFadeState.showFirst.toggle(),
          equals(CrossFadeState.showSecond),
        );
      });
      test('should return showFirst if called on showSecond', () {
        expect(
          CrossFadeState.showSecond.toggle(),
          equals(CrossFadeState.showFirst),
        );
      });

      test('should return the same if toggled with toggle false', () {
        var first = CrossFadeState.showFirst;
        var second = CrossFadeState.showSecond;
        expect(first.toggle(toggle: false), equals(first));
        expect(second.toggle(toggle: false), equals(second));
      });

      test('should return showFirst if called on showSecond', () {
        expect(
          CrossFadeState.showSecond.toggle(),
          equals(CrossFadeState.showFirst),
        );
      });
    });
  });
}
