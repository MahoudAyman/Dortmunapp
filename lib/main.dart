import 'package:flutter/material.dart';
import 'core/breakpoints.dart';
import 'views/dashboard_view.dart';
import 'views/master_detail_view.dart';
import 'views/settings_view.dart';
import 'widgets/adaptive_navigation.dart';

void main() {
  runApp(const ResponsiveAdaptiveApp());
}

class ResponsiveAdaptiveApp extends StatefulWidget {
  const ResponsiveAdaptiveApp({super.key});

  @override
  State<ResponsiveAdaptiveApp> createState() => _ResponsiveAdaptiveAppState();
}

class _ResponsiveAdaptiveAppState extends State<ResponsiveAdaptiveApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive & Adaptive Flutter Layout',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResponsiveHomeScreen(
        themeMode: _themeMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

class ResponsiveHomeScreen extends StatefulWidget {
  const ResponsiveHomeScreen({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<ResponsiveHomeScreen> createState() => _ResponsiveHomeScreenState();
}

class _ResponsiveHomeScreenState extends State<ResponsiveHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.themeMode == ThemeMode.dark ||
        (widget.themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    final destinations = const [
      NavigationDestinationItem(
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        label: 'Dashboard',
      ),
      NavigationDestinationItem(
        icon: Icons.view_sidebar_outlined,
        selectedIcon: Icons.view_sidebar,
        label: 'Master-Detail',
      ),
      NavigationDestinationItem(
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: 'Settings',
      ),
    ];

    // Build the active screen based on selected navigation index
    Widget activeBody;
    switch (_currentIndex) {
      case 0:
        activeBody = const DashboardView();
        break;
      case 1:
        activeBody = const MasterDetailView();
        break;
      case 2:
      default:
        activeBody = SettingsView(
          isDarkMode: isDark,
          onThemeModeChanged: widget.onThemeChanged,
        );
        break;
    }

    return AdaptiveScaffoldShell(
      title: 'Adaptive Workspace',
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      destinations: destinations,
      actions: [
        // Live Screen Size Class Badge in AppBar
        LayoutBuilder(
          builder: (context, constraints) {
            final windowWidth = MediaQuery.sizeOf(context).width;
            final sizeClass = getWindowSizeClass(windowWidth);

            IconData icon;
            switch (sizeClass) {
              case WindowSizeClass.compact:
                icon = Icons.smartphone;
                break;
              case WindowSizeClass.medium:
                icon = Icons.tablet_mac;
                break;
              case WindowSizeClass.expanded:
              case WindowSizeClass.large:
                icon = Icons.desktop_windows;
                break;
            }

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(
                child: Chip(
                  avatar: Icon(icon, size: 14),
                  label: Text(
                    sizeClass.isCompact
                        ? '${windowWidth.toInt()}dp'
                        : '${sizeClass.name.toUpperCase()} (${windowWidth.toInt()}dp)',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: theme.colorScheme.secondaryContainer.withValues(alpha: 0.6),
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            );
          },
        ),
      ],
      body: activeBody,
    );
  }
}
