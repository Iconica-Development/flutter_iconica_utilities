// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_iconica_utilities/src/highlighted_text/base.dart';

extension Highlight on Text {
  /// Generic implementation of highlighted text. this is an extension of the regular [Text] widget.
  /// Which allows a different style for certain words of the text input.
  /// Uses a [List] of [String] as highlight matchers, the words are going to be painted in the required [TextStyle] highlightStyle
  /// Other text gets painted in the optional [TextStyle] mainStyle. If no style is given the inherited style is used.
  /// [AssertionError] gets thrown when the given highlight matching [List] of [String] is empty.
  /// ```
  /// ...
  /// child: Text('This is a text demo').highlight(
  ///   ['text'],
  ///   highlightStyle: TextStyle(
  ///     color: Colors.red,
  ///   ),
  /// ...
  /// ```
  /// In the above example, the text 'This is a' and 'demo' will be painted use the default Text theme in black. But the word 'text' will be painted in the color red.
  highlight(
    /// List of string which are going to be painted in the highlightStyle
    /// [AssertionError] gets thrown if the list is empty
    List<String> highlights, {
    /// Required style, highlighted words get painted in this style
    required TextStyle highlightStyle,

    /// Ability to set a tapRecognizer on the highlighted text.
    VoidCallback? onTapRecognizer,

    /// Optional style, if no style given the inherited style is used. Words that are NOT highlighted get painted in this style.
    TextStyle? mainStyle,
  }) {
    assert(highlights.isNotEmpty);
    return HighlightedText(
      text: data ?? '',
      highlighted: highlights,
      highlightedTextStyle: highlightStyle,
      mainStyle: mainStyle ?? style,
      textAlign: textAlign,
      onTapRecognizer: onTapRecognizer,
    );
  }
}
