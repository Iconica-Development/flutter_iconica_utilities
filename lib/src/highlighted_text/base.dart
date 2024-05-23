// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final TextStyle? mainStyle;
  final List<String> highlighted;
  final TextStyle? highlightedTextStyle;
  final TextAlign? textAlign;
  final VoidCallback? onTapRecognizer;
  const HighlightedText({
    Key? key,
    required this.text,
    required this.mainStyle,
    required this.highlighted,
    required this.highlightedTextStyle,
    this.textAlign,
    this.onTapRecognizer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> brokenDown = _getHighlightedList(text);
    return Text.rich(
      TextSpan(children: [
        for (String s in brokenDown) ...[
          if (highlighted.contains(s)) ...[
            TextSpan(
                text: s,
                style: highlightedTextStyle,
                recognizer: onTapRecognizer != null
                    ? getTapRecognizer(onTapRecognizer!)
                    : null),
          ] else ...[
            TextSpan(text: s, style: mainStyle)
          ]
        ]
      ]),
      textAlign: textAlign,
      key: const Key("highlighted"),
    );
  }

  String _findNextIndex(String remaining) {
    int index = -1;
    String word = 'not-to-detected-by-anything....!';
    for (var element in highlighted) {
      var found = remaining.indexOf(element);
      if (found != -1 && (found < index || index == -1)) {
        index = found;
        word = element;
      }
    }
    return word;
  }

  List<String> _getHighlightedList(String remaining,
      {List<String>? cumulative}) {
    cumulative ??= [];
    String highlightedWord = _findNextIndex(remaining);
    int nextIndex = remaining.indexOf(highlightedWord);
    if (nextIndex == -1) {
      cumulative.add(remaining);
      return cumulative;
    } else {
      if (nextIndex != 0) {
        String prefix = remaining.substring(0, nextIndex);
        cumulative.add(prefix);
      }
      cumulative.add(highlightedWord);
      return _getHighlightedList(
          remaining.substring(nextIndex + highlightedWord.length),
          cumulative: cumulative);
    }
  }

  GestureRecognizer getTapRecognizer(VoidCallback onTap) {
    var rec = TapGestureRecognizer();
    rec.onTap = onTap;
    return rec;
  }
}
