import 'package:flutter/material.dart';

class HighlightModel {
  HighlightModel(
    this.highlightedTexts, {
    required this.highlightStyle,
    this.onTapRecognizer,
  }) : assert(highlightedTexts.isNotEmpty);

  /// List of string which are going to be painted in the highlightStyle
  /// [AssertionError] gets thrown if the list is empty
  final List<String> highlightedTexts;

  /// Required style, highlighted words get painted in this style
  final TextStyle highlightStyle;

  /// Ability to set a tapRecognizer on the highlighted text.
  final VoidCallback? onTapRecognizer;
}
