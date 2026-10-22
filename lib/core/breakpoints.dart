/// Standard Material Design 3 and Adaptive Layout Breakpoints.
class Breakpoints {
  Breakpoints._();

  /// Maximum width for compact (phone portrait) layouts.
  static const double compactMaxWidth = 599.0;

  /// Minimum width for medium (tablet / foldable / half desktop) layouts.
  static const double mediumMinWidth = 600.0;

  /// Maximum width for medium layouts.
  static const double mediumMaxWidth = 1023.0;

  /// Minimum width for expanded (desktop / laptop) layouts.
  static const double expandedMinWidth = 1024.0;

  /// Minimum width for large desktop (wide screens / multi-pane).
  static const double largeMinWidth = 1440.0;

  /// Maximum content readable width to prevent awkward stretching on ultra-wide screens.
  static const double maxContentWidth = 1200.0;
}

/// Categorization of window width sizes.
enum WindowSizeClass {
  /// < 600 dp: Handsets in portrait, split screens on phones
  compact,

  /// 600 - 1023 dp: Tablets in portrait, large unfolded foldables, half desktop windows
  medium,

  /// >= 1024 dp: Tablets in landscape, desktop windows, laptops
  expanded,

  /// >= 1440 dp: Ultra-wide desktop screens, multi-pane productivity layouts
  large,
}

/// Helper methods to evaluate size classes from width constraints.
extension WindowSizeClassExtension on WindowSizeClass {
  bool get isCompact => this == WindowSizeClass.compact;
  bool get isMedium => this == WindowSizeClass.medium;
  bool get isExpanded => this == WindowSizeClass.expanded;
  bool get isLarge => this == WindowSizeClass.large;

  /// Returns true if layout has sufficient room for multi-column / side-by-side content.
  bool get isTabletOrLarger => this != WindowSizeClass.compact;
}

/// Calculates [WindowSizeClass] based on available width.
WindowSizeClass getWindowSizeClass(double width) {
  if (width < Breakpoints.mediumMinWidth) {
    return WindowSizeClass.compact;
  } else if (width < Breakpoints.expandedMinWidth) {
    return WindowSizeClass.medium;
  } else if (width < Breakpoints.largeMinWidth) {
    return WindowSizeClass.expanded;
  } else {
    return WindowSizeClass.large;
  }
}
