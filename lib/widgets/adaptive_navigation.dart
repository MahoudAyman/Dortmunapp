import 'package:flutter/material.dart';
import '../core/breakpoints.dart';

/// Navigation item description used across all form factors.
class NavigationDestinationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const NavigationDestinationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

/// Adaptive scaffold shell that automatically switches between:
/// - Bottom [NavigationBar] on compact screens (< 600 dp)
/// - Compact [NavigationRail] on medium screens (600 - 1023 dp)
/// - Extended [NavigationRail] / Side Drawer on expanded screens (>= 1024 dp)
class AdaptiveScaffoldShell extends StatelessWidget {
  const AdaptiveScaffoldShell({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.body,
    this.title = 'Adaptive Flutter',
    this.actions,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestinationItem> destinations;
  final Widget body;
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    // Measure parent allocated constraints using LayoutBuilder
    return LayoutBuilder(
      builder: (context, constraints) {
        final sizeClass = getWindowSizeClass(constraints.maxWidth);

        if (sizeClass.isCompact) {
          return _buildMobileScaffold(context);
        } else if (sizeClass.isMedium) {
          return _buildTabletScaffold(context);
        } else {
          return _buildDesktopScaffold(context);
        }
      },
    );
  }

  /// Compact / Phone Scaffold: Bottom NavigationBar
  Widget _buildMobileScaffold(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: destinations.map((d) {
          return NavigationDestination(
            icon: Icon(d.icon),
            selectedIcon: Icon(d.selectedIcon),
            label: d.label,
          );
        }).toList(),
      ),
    );
  }

  /// Medium / Tablet Scaffold: Compact NavigationRail + Body
  Widget _buildTabletScaffold(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            backgroundColor: theme.colorScheme.surfaceContainerLow,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Icon(
                Icons.dashboard_customize_outlined,
                color: theme.colorScheme.primary,
                size: 28,
              ),
            ),
            destinations: destinations.map((d) {
              return NavigationRailDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: Text(d.label),
              );
            }).toList(),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(title),
                elevation: 0,
                backgroundColor: theme.colorScheme.surface,
                actions: actions,
              ),
              body: body,
            ),
          ),
        ],
      ),
    );
  }

  /// Expanded / Desktop Scaffold: Extended NavigationRail with Branding + Body
  Widget _buildDesktopScaffold(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 240,
            child: Material(
              color: theme.colorScheme.surfaceContainerLow,
              child: Column(
                children: [
                  // App branding header
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.devices_outlined,
                            color: theme.colorScheme.onPrimaryContainer,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Multi-Platform',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Destination list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: destinations.length,
                      itemBuilder: (context, index) {
                        final d = destinations[index];
                        final isSelected = index == selectedIndex;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: ListTile(
                            selected: isSelected,
                            selectedTileColor: theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: Icon(
                              isSelected ? d.selectedIcon : d.icon,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                            title: Text(
                              d.label,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface,
                              ),
                            ),
                            onTap: () => onDestinationSelected(index),
                          ),
                        );
                      },
                    ),
                  ),

                  // Desktop footer info
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: theme.colorScheme.primary,
                            child: const Text('AG', style: TextStyle(fontSize: 12, color: Colors.white)),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Developer Mode', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                Text('Window: Desktop', style: TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(title),
                elevation: 0,
                backgroundColor: theme.colorScheme.surface,
                actions: actions,
              ),
              body: body,
            ),
          ),
        ],
      ),
    );
  }
}
