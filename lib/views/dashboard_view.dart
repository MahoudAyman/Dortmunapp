import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive_container.dart';
import '../models/project_item.dart';
import '../widgets/summary_card.dart';

/// Dashboard view highlighting responsive grid layout, window metrics display,
/// and content constraints on large displays.
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final windowSize = MediaQuery.sizeOf(context);
    final projects = ProjectItem.mockItems;

    return ResponsiveContainer(
      child: ListView(
        children: [
          // Screen diagnostic header banner
          Card(
            elevation: 0,
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final activeClass = getWindowSizeClass(constraints.maxWidth);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Active Window Diagnostics',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildDiagnosticBadge(
                            'Width: ${constraints.maxWidth.toStringAsFixed(0)} dp',
                            theme,
                          ),
                          _buildDiagnosticBadge(
                            'Height: ${windowSize.height.toStringAsFixed(0)} dp',
                            theme,
                          ),
                          _buildDiagnosticBadge(
                            'Class: ${activeClass.name.toUpperCase()}',
                            theme,
                            highlight: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Resize your application window horizontally to observe layout transitions '
                        'between Compact (<600dp), Medium (600-1023dp), and Expanded (>=1024dp).',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Overview Title
          Text(
            'System Metrics',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Adaptive Summary Grid: adjusts columns automatically via maxCrossAxisExtent
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 260,
              mainAxisExtent: 180,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return const SummaryCard(
                    title: 'Active Tasks',
                    value: '18',
                    subtitle: '6 pending review',
                    icon: Icons.task_alt_outlined,
                    color: Colors.blue,
                    trend: '+12%',
                  );
                case 1:
                  return const SummaryCard(
                    title: 'Adaptive Breakpoints',
                    value: '4 Tiers',
                    subtitle: 'Compact to Ultra-Wide',
                    icon: Icons.aspect_ratio_outlined,
                    color: Colors.purple,
                  );
                case 2:
                  return const SummaryCard(
                    title: 'Layout Stability',
                    value: '99.8%',
                    subtitle: 'Zero render overflows',
                    icon: Icons.verified_outlined,
                    color: Colors.green,
                    trend: '+2.4%',
                  );
                case 3:
                default:
                  return const SummaryCard(
                    title: 'Devices Tested',
                    value: '12+',
                    subtitle: 'Mobile, Tablet, Desktop',
                    icon: Icons.devices_other_outlined,
                    color: Colors.amber,
                  );
              }
            },
          ),
          const SizedBox(height: 32),

          // Projects Section Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Responsive Modules',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${projects.length} Total',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Responsive Project Grid: adapts column count to space
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 380,
              mainAxisExtent: 195,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final project = projects[index];

              return Card(
                elevation: 0,
                color: theme.colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: project.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(project.icon, color: project.color, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  project.category,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        project.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Completion',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                              Text(
                                '${(project.progress * 100).toInt()}%',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: project.progress,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(4),
                            valueColor: AlwaysStoppedAnimation<Color>(project.color),
                            backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDiagnosticBadge(String text, ThemeData theme, {bool highlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: highlight
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: highlight
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
