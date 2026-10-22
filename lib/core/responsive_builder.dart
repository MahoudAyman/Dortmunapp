import 'package:flutter/material.dart';
import 'breakpoints.dart';

typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
  WindowSizeClass sizeClass,
);

/// A reusable layout widget that evaluates parent constraints using [LayoutBuilder]
/// and selects the appropriate widget builder for mobile, tablet, or desktop form factors.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Builder invoked for compact form factors (< 600 dp).
  final ResponsiveWidgetBuilder mobile;

  /// Optional builder invoked for medium form factors (600 - 1023 dp).
  /// Falls back to [desktop] or [mobile] if null.
  final ResponsiveWidgetBuilder? tablet;

  /// Optional builder invoked for expanded form factors (>= 1024 dp).
  /// Falls back to [tablet] or [mobile] if null.
  final ResponsiveWidgetBuilder? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sizeClass = getWindowSizeClass(constraints.maxWidth);

        switch (sizeClass) {
          case WindowSizeClass.compact:
            return mobile(context, constraints, sizeClass);

          case WindowSizeClass.medium:
            if (tablet != null) {
              return tablet!(context, constraints, sizeClass);
            }
            if (desktop != null) {
              return desktop!(context, constraints, sizeClass);
            }
            return mobile(context, constraints, sizeClass);

          case WindowSizeClass.expanded:
          case WindowSizeClass.large:
            if (desktop != null) {
              return desktop!(context, constraints, sizeClass);
            }
            if (tablet != null) {
              return tablet!(context, constraints, sizeClass);
            }
            return mobile(context, constraints, sizeClass);
        }
      },
    );
  }
}
