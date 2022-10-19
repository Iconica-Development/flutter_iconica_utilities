import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_iconica_utilities/iconica_utilities.dart';
import 'package:flutter_iconica_utilities/src/highlighted_text/base.dart';

List<TextSpan> retrieveListOfSpans(WidgetTester tester) {
  Text txt = tester.widget(find.byKey(const Key("highlighted")));
  TextSpan ts = txt.textSpan as TextSpan;
  List<TextSpan> result = [];
  for (InlineSpan? span in ts.children!) {
    result.add(span as TextSpan);
  }
  return result;
}

Map<int, Color> getColor(List<TextSpan> spans, String toTest) {
  Map<int, Color> color = {};
  for (int i = 0; i < spans.length; i++) {
    if (spans[i].text == toTest) {
      color[i] = (spans[i].style!.color!);
    }
  }
  return color;
}

void main() {
  group('Highlighted text', () {
    testWidgets("One word color check", (tester) async {
      String highlighted = "data";
      String input = "data";

      Color toTestColor = Colors.red;
      List<int> indexesToTest = [0];

      HighlightedText text = Text(input).highlight(
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

      List<TextSpan> spans = retrieveListOfSpans(tester);
      Map<int, Color> colors = getColor(spans, highlighted);
      colors.forEach((key, value) {
        expect(indexesToTest.contains(key), equals(true));
        expect(value, equals(toTestColor));
      });
    });

    testWidgets("Four word color check", (tester) async {
      String highlighted = "data";
      String input = "test data test data";

      Color toTestColor = Colors.red;
      List<int> indexesToTest = [1, 3];

      HighlightedText text = Text(input).highlight(
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

      List<TextSpan> spans = retrieveListOfSpans(tester);
      Map<int, Color> colors = getColor(spans, highlighted);
      colors.forEach((key, value) {
        expect(indexesToTest.contains(key), equals(true));
        expect(value, equals(toTestColor));
      });
    });

    testWidgets("Long text color check", (tester) async {
      String highlighted = "beautiful";
      String input =
          "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, desktop, and embedded devices from a single codebase.";

      Color toTestColor = Colors.red;
      List<int> indexesToTest = [1];

      HighlightedText text = Text(input).highlight(
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

      List<TextSpan> spans = retrieveListOfSpans(tester);
      Map<int, Color> colors = getColor(spans, highlighted);
      colors.forEach((key, value) {
        expect(indexesToTest.contains(key), equals(true));
        expect(value, equals(toTestColor));
      });
    });

    testWidgets("Empty list should throw", (tester) async {
      String input = "test data test data";

      Color toTestColor = Colors.red;

      expect(
          () => Text(input).highlight(
                [],
                highlightStyle: TextStyle(
                  color: toTestColor,
                ),
              ),
          throwsAssertionError);
    });
  });
}
