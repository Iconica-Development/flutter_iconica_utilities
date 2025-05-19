import "package:flutter/material.dart";

/// The model used for highlighting pieces of text in different styles.
class HighlightModel {
  /// [HighlightModel] constructor
  HighlightModel(
    this.highlightedTexts, {
    required this.highlightStyle,
    this.onTapRecognizer,
  }) : assert(
          highlightedTexts.isNotEmpty,
          "highlightedTexts should not be empty",
        );

  /// List of string which are going to be painted in the highlightStyle
  /// [AssertionError] gets thrown if the list is empty
  final List<String> highlightedTexts;

  /// Required style, highlighted words get painted in this style
  final TextStyle highlightStyle;

  /// Ability to set a tapRecognizer on the highlighted text.
  final VoidCallback? onTapRecognizer;
}
