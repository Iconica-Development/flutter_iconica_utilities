// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_iconica_utilities/src/highlighted_text/highlight_model.dart";

/// Widget for highlighting parts of a text.
class HighlightedText extends StatelessWidget {
  /// [HighlightedText] constructor
  const HighlightedText({
    required this.text,
    required this.mainStyle,
    required this.highlighted,
    required this.highlightedTextStyle,
    super.key,
    this.textAlign,
    this.onTapRecognizer,
  });

  /// The text
  final String text;

  /// The default style
  final TextStyle? mainStyle;

  /// The values in the text that are highlighted
  final List<String> highlighted;

  /// The style used for highlighting
  final TextStyle? highlightedTextStyle;

  /// The text alignment
  final TextAlign? textAlign;

  /// The callback fired when a highlighted piece of text is pressed
  final VoidCallback? onTapRecognizer;

  @override
  Widget build(BuildContext context) {
    var brokenDown = _getHighlightedList(text);
    var textSpans = brokenDown.map((substring) {
      if (highlighted.contains(substring)) {
        return TextSpan(
          text: substring,
          style: highlightedTextStyle,
          recognizer: onTapRecognizer != null
              ? _getTapRecognizer(onTapRecognizer!)
              : null,
        );
      }

      return TextSpan(
        text: substring,
        style: mainStyle,
      );
    }).toList();

    return Text.rich(
      TextSpan(children: textSpans),
      textAlign: textAlign,
      key: const Key("highlighted"),
    );
  }

  String _findNextIndex(String remaining) {
    var index = -1;
    var word = "not-to-detected-by-anything....!";
    for (var element in highlighted) {
      var found = remaining.indexOf(element);
      if (found != -1 && (found < index || index == -1)) {
        index = found;
        word = element;
      }
    }
    return word;
  }

  List<String> _getHighlightedList(
    String remaining, {
    List<String>? cumulative,
  }) {
    cumulative ??= [];

    var highlightedWord = _findNextIndex(remaining);
    var nextIndex = remaining.indexOf(highlightedWord);

    if (nextIndex == -1) {
      cumulative.add(remaining);
      return cumulative;
    }

    if (nextIndex != 0) {
      var prefix = remaining.substring(0, nextIndex);
      cumulative.add(prefix);
    }

    cumulative.add(highlightedWord);

    return _getHighlightedList(
      remaining.substring(nextIndex + highlightedWord.length),
      cumulative: cumulative,
    );
  }
}

/// Widget for highlighting parts of a text in different ways.
class MultiHighlightedText extends StatelessWidget {
  /// [MultiHighlightedText] constructor
  const MultiHighlightedText({
    required this.text,
    required this.highlights,
    required this.mainStyle,
    super.key,
    this.textAlign,
  });

  /// The text
  final String text;

  /// A list of [HighlightModel]s
  final List<HighlightModel> highlights;

  /// The text alignment
  final TextAlign? textAlign;

  /// The default style
  final TextStyle? mainStyle;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: [
            ..._getChildren(),
          ],
        ),
        textAlign: textAlign,
        key: const Key("highlighted"),
      );

  List<InlineSpan> _getChildren() {
    var brokenDown = _getHighlightedList(text);

    var result = <InlineSpan>[];

    for (var substring in brokenDown) {
      var highlightFound = false;
      for (var highlight in highlights) {
        if (highlight.highlightedTexts.contains(substring) && !highlightFound) {
          highlightFound = true;
          result.add(
            TextSpan(
              text: substring,
              style: highlight.highlightStyle,
              recognizer: highlight.onTapRecognizer != null
                  ? _getTapRecognizer(highlight.onTapRecognizer!)
                  : null,
            ),
          );
        }
      }

      if (!highlightFound) {
        result.add(TextSpan(text: substring, style: mainStyle));
      }
    }

    return result;
  }

  String _findNextIndex(String remaining) {
    var index = -1;
    var word = "not-to-detected-by-anything....!";
    for (var highlight in highlights) {
      for (var element in highlight.highlightedTexts) {
        var found = remaining.indexOf(element);
        if (found != -1 && (found < index || index == -1)) {
          index = found;
          word = element;
        }
      }
    }
    return word;
  }

  List<String> _getHighlightedList(
    String remaining, {
    List<String>? cumulative,
  }) {
    cumulative ??= [];
    var highlightedWord = _findNextIndex(remaining);
    var nextIndex = remaining.indexOf(highlightedWord);
    if (nextIndex == -1) {
      cumulative.add(remaining);
      return cumulative;
    } else {
      if (nextIndex != 0) {
        var prefix = remaining.substring(0, nextIndex);
        cumulative.add(prefix);
      }
      cumulative.add(highlightedWord);
      return _getHighlightedList(
        remaining.substring(nextIndex + highlightedWord.length),
        cumulative: cumulative,
      );
    }
  }
}

GestureRecognizer _getTapRecognizer(VoidCallback onTap) {
  var rec = TapGestureRecognizer();
  rec.onTap = onTap;
  return rec;
}
