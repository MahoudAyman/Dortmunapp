import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Wraps children in a [Center] and [ConstrainedBox] with a specified [maxWidth].
/// This ensures content remains readable and does not stretch unnaturally
/// across large desktop or widescreen monitors.
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = Breakpoints.maxContentWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
