import 'package:flutter/material.dart';

/// Represents a work item or project for demonstrating Master-Detail and Dashboard layouts.
class ProjectItem {
  final String id;
  final String title;
  final String category;
  final String description;
  final double progress;
  final IconData icon;
  final Color color;
  final DateTime updatedAt;
  final List<String> tags;

  const ProjectItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.progress,
    required this.icon,
    required this.color,
    required this.updatedAt,
    required this.tags,
  });

  static List<ProjectItem> get mockItems => [
        ProjectItem(
          id: '1',
          title: 'Design System Migration',
          category: 'UI/UX Architecture',
          description:
              'Migrating mobile-only layouts to cross-platform responsive patterns with fluid typography and dynamic spacing constraints.',
          progress: 0.85,
          icon: Icons.palette_outlined,
          color: Colors.indigo,
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
          tags: ['Material 3', 'LayoutBuilder', 'Design Tokens'],
        ),
        ProjectItem(
          id: '2',
          title: 'Foldable Device Support',
          category: 'Hardware Adapters',
          description:
              'Adding two-pane support for hinge postures, book mode, and tabletop mode without locking screen orientation.',
          progress: 0.60,
          icon: Icons.devices_fold_outlined,
          color: Colors.teal,
          updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
          tags: ['Foldables', 'TwoPane', 'Hinge'],
        ),
        ProjectItem(
          id: '3',
          title: 'Multi-Window & Split Screen',
          category: 'Desktop Optimization',
          description:
              'Verifying responsive grid transitions when the user resizes the desktop window or activates split screen on tablets.',
          progress: 0.95,
          icon: Icons.window_outlined,
          color: Colors.deepOrange,
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
          tags: ['Desktop', 'Resize', 'SliverGrid'],
        ),
        ProjectItem(
          id: '4',
          title: 'Keyboard & Mouse Interop',
          category: 'Input Methods',
          description:
              'Configuring hover states, keyboard shortcuts (Ctrl+K search, arrows navigation), and high precision cursor interactions.',
          progress: 0.40,
          icon: Icons.keyboard_outlined,
          color: Colors.purple,
          updatedAt: DateTime.now().subtract(const Duration(days: 2)),
          tags: ['A11y', 'Shortcuts', 'FocusNode'],
        ),
        ProjectItem(
          id: '5',
          title: 'Adaptive Navigation Shell',
          category: 'Navigation',
          description:
              'Switching seamlessly between BottomNavigationBar on phones, NavigationRail on tablets, and expanded Drawer on desktop.',
          progress: 1.0,
          icon: Icons.navigation_outlined,
          color: Colors.green,
          updatedAt: DateTime.now().subtract(const Duration(days: 3)),
          tags: ['NavigationRail', 'AdaptiveScaffold'],
        ),
        ProjectItem(
          id: '6',
          title: 'Content Max-Width Enforcer',
          category: 'Styling',
          description:
              'Centering readable content areas with ConstrainedBox on ultra-wide 4K monitors to prevent strained eye tracking.',
          progress: 0.70,
          icon: Icons.fit_screen_outlined,
          color: Colors.blueGrey,
          updatedAt: DateTime.now().subtract(const Duration(days: 4)),
          tags: ['ConstrainedBox', 'Center', 'Readability'],
        ),
      ];
}
