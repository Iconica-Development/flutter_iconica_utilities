import "package:flutter/widgets.dart";

/// Extension on [CrossFadeState] make alternating easier.
extension CrossFadeStateBool on CrossFadeState {
  /// Returns the other crossfade state
  ///
  /// created as an optimisation on
  /// ```dart
  /// bool ? CrossFadeState.showFirst : CrossFadeState.showSecond
  /// ```
  ///
  /// If you want to have it toggle based on a boolean condition, you can
  /// do the following:
  ///
  /// ```dart
  /// // define the state
  /// bool showSecond = true
  ///
  ///
  /// // in the build
  /// // ...
  /// AnimatedCrossFade(
  ///   ...
  ///   crossFadeState: CrossFadeState.showFirst.toggle(toggle: showSecond,)
  ///   ...
  /// )
  /// // ...
  /// ```
  CrossFadeState toggle({bool toggle = true}) {
    if (!toggle) {
      return this;
    }
    return switch (this) {
      CrossFadeState.showFirst => CrossFadeState.showSecond,
      CrossFadeState.showSecond => CrossFadeState.showFirst,
    };
  }
}
