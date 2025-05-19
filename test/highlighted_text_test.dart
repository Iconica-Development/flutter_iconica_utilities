// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";
import "package:flutter_iconica_utilities/flutter_iconica_utilities.dart";
import "package:flutter_test/flutter_test.dart";

List<TextSpan> retrieveListOfSpans(WidgetTester tester) {
  var text = tester.widget(find.byKey(const Key("highlighted"))) as Text;
  var textSpan = text.textSpan! as TextSpan;
  var result = <TextSpan>[];

  for (InlineSpan? span in textSpan.children!) {
    result.add(span! as TextSpan);
  }

  return result;
}

Map<int, Color> getColor(List<TextSpan> textSpans, String toTest) {
  var color = <int, Color>{};

  for (var i = 0; i < textSpans.length; i++) {
    if (textSpans[i].text != toTest) continue;

    color[i] = textSpans[i].style!.color!;
  }

  return color;
}

void main() {
  group("Highlighted text", () {
    testWidgets("One word color check", (tester) async {
      var highlighted = "data";
      var input = "data";

      Color toTestColor = Colors.red;
      var indexesToTest = <int>[0];

      var text = Text(input).highlight(
        [highlighted],
        highlightStyle: TextStyle(
          color: toTestColor,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: text,
        ),
      );

      var spans = retrieveListOfSpans(tester);
      var colors = getColor(spans, highlighted);
      colors.forEach((key, value) {
        expect(indexesToTest.contains(key), equals(true));
        expect(value, equals(toTestColor));
      });
    });

    testWidgets("Four word color check", (tester) async {
      var highlighted = "data";
      var input = "test data test data";

      Color toTestColor = Colors.red;
      var indexesToTest = <int>[1, 3];

      var text = Text(input).highlight(
        [highlighted],
        highlightStyle: TextStyle(
          color: toTestColor,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: text,
        ),
      );

      var spans = retrieveListOfSpans(tester);
      var colors = getColor(spans, highlighted);
      colors.forEach((key, value) {
        expect(indexesToTest.contains(key), equals(true));
        expect(value, equals(toTestColor));
      });
    });

    testWidgets("Long text color check", (tester) async {
      var highlighted = "beautiful";
      var input =
          """Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, desktop, and embedded devices from a single codebase.""";

      Color toTestColor = Colors.red;
      var indexesToTest = <int>[1];

      var text = Text(input).highlight(
        [highlighted],
        highlightStyle: TextStyle(
          color: toTestColor,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: text,
        ),
      );

      var spans = retrieveListOfSpans(tester);
      var colors = getColor(spans, highlighted);
      colors.forEach((key, value) {
        expect(indexesToTest.contains(key), equals(true));
        expect(value, equals(toTestColor));
      });
    });

    testWidgets("Empty list should throw", (tester) async {
      var input = "test data test data";

      Color toTestColor = Colors.red;

      expect(
        () => Text(input).highlight(
          [],
          highlightStyle: TextStyle(
            color: toTestColor,
          ),
        ),
        throwsAssertionError,
      );
    });
  });
}
