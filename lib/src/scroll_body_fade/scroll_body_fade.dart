import 'package:flutter/material.dart';

/// Creates edge fading for a scroll view.
///
/// The [child] should be a [Scrollable] or a widget containing a [Scrollable].
///
/// The [controller] is a [ScrollController] that should be provided to both
/// this widget and the provided [Scrollable].
///
/// This widget does not do anything, unless at least [endFadeLength] or
/// [startFadeLength] is provided.
///
/// If you use this widget in combination with a horizontal scroll view, set
/// the [axis] to [Axis.horizontal].
class ScrollBodyFade extends StatefulWidget {
  const ScrollBodyFade({
    required this.child,
    required this.controller,
    this.endFadeLength,
    this.startFadeLength,
    this.fadeColor,
    this.axis = Axis.vertical,
    super.key,
  });

  /// Used to detect changes in the scroll position to determine the fade
  final ScrollController controller;

  /// The maximum length at the end of the scroll view
  final double? endFadeLength;

  /// The maximum length of the fade at the start of the scroll view
  final double? startFadeLength;

  /// The [Color] of the fade, defaults to [ColorScheme.surface].
  final Color? fadeColor;

  /// Change the side at which the fades appear
  final Axis axis;

  /// The [Scrollable] or container with a [Scrollable] to apply a fade to.
  final Widget child;

  @override
  State<ScrollBodyFade> createState() => _ScrollBodyFadeState();
}

class _ScrollBodyFadeState extends State<ScrollBodyFade> {
  ValueNotifier<double> startFadeSize = ValueNotifier(0);
  ValueNotifier<double> endFadeSize = ValueNotifier(0);

  void _onScroll() {
    var controller = widget.controller;

    var endFadeLength = widget.endFadeLength;
    if (endFadeLength != null) {
      endFadeSize.value =
          (controller.position.maxScrollExtent - controller.position.pixels)
                  .clamp(0, endFadeLength) /
              endFadeLength;
    }

    var startFadeLength = widget.startFadeLength;
    if (startFadeLength != null) {
      startFadeSize.value =
          controller.position.pixels.clamp(0, startFadeLength) /
              startFadeLength;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onScroll();
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant ScrollBodyFade oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
    }
  }

  Widget _getAnimatedFadeSize({
    required ValueNotifier<double> fade,
    required double fadeLength,
    required AlignmentGeometry relativePosition,
    required AlignmentGeometry begin,
    required AlignmentGeometry end,
    required Color fadeColor,
  }) {
    return Align(
      alignment: relativePosition,
      child: AnimatedBuilder(
        animation: fade,
        builder: (context, _) {
          var length = fadeLength * fade.value;
          var breadth = double.infinity;

          var size = switch (widget.axis) {
            Axis.horizontal => Size(length, breadth),
            Axis.vertical => Size(breadth, length),
          };

          return IgnorePointer(
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  colors: [
                    fadeColor,
                    // TODO(Joey): migrate to flutter 3.27
                    // ignore: deprecated_member_use
                    fadeColor.withOpacity(0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var fadeColor = widget.fadeColor ?? theme.colorScheme.surface;

    var startAlignment = switch (widget.axis) {
      Axis.horizontal => Alignment.centerLeft,
      Axis.vertical => Alignment.topCenter,
    };

    var endAlignment = switch (widget.axis) {
      Axis.horizontal => Alignment.centerRight,
      Axis.vertical => Alignment.bottomCenter,
    };

    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        if (widget.startFadeLength != null) ...[
          Positioned.fill(
            child: _getAnimatedFadeSize(
              fadeLength: widget.startFadeLength!,
              fade: startFadeSize,
              relativePosition: startAlignment,
              begin: startAlignment,
              end: endAlignment,
              fadeColor: fadeColor,
            ),
          )
        ],
        if (widget.endFadeLength != null) ...[
          Positioned.fill(
            child: _getAnimatedFadeSize(
              fadeLength: widget.endFadeLength!,
              fade: endFadeSize,
              relativePosition: endAlignment,
              begin: endAlignment,
              end: startAlignment,
              fadeColor: fadeColor,
            ),
          ),
        ],
      ],
    );
  }
}
