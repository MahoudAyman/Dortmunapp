import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../models/project_item.dart';
import '../widgets/detail_pane.dart';

/// Implements an Adaptive Master-Detail layout pattern.
/// - On compact screens (maxWidth < 600): Displays single list view and pushes detail view.
/// - On medium and expanded screens (maxWidth >= 600): Displays side-by-side dual pane view.
class MasterDetailView extends StatefulWidget {
  const MasterDetailView({super.key});

  @override
  State<MasterDetailView> createState() => _MasterDetailViewState();
}

class _MasterDetailViewState extends State<MasterDetailView> {
  final List<ProjectItem> _items = ProjectItem.mockItems;
  ProjectItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    // Default select first item on initial load for wide screens
    if (_items.isNotEmpty) {
      _selectedItem = _items.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth >= Breakpoints.mediumMinWidth;

        if (isLargeScreen) {
          return _buildDualPaneLayout(context, constraints);
        } else {
          return _buildSinglePaneLayout(context);
        }
      },
    );
  }

  /// Large Screen / Tablet / Desktop: Side-by-side Master List & Detail Pane
  Widget _buildDualPaneLayout(BuildContext context, BoxConstraints constraints) {
    final theme = Theme.of(context);
    final isDesktop = constraints.maxWidth >= Breakpoints.expandedMinWidth;

    // Adjust list width ratio depending on whether it's tablet or full desktop
    final listWidth = isDesktop ? 360.0 : 300.0;

    return Row(
      children: [
        // Master List Pane
        SizedBox(
          width: listWidth,
          child: Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Projects (${_items.length})',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _items.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      final isSelected = item.id == _selectedItem?.id;

                      return ListTile(
                        selected: isSelected,
                        selectedTileColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                        leading: CircleAvatar(
                          backgroundColor: item.color.withValues(alpha: 0.15),
                          child: Icon(item.icon, color: item.color, size: 20),
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          item.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          '${(item.progress * 100).toInt()}%',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: item.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedItem = item;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1, thickness: 1),

        // Detail Preview Pane
        Expanded(
          child: Scaffold(
            backgroundColor: theme.colorScheme.surfaceContainerLowest,
            body: DetailPane(
              item: _selectedItem,
            ),
          ),
        ),
      ],
    );
  }

  /// Compact Screen / Phone: Single Column List with Route Transition to Detail
  Widget _buildSinglePaneLayout(BuildContext context) {
    return ListView.separated(
      itemCount: _items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = _items[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: item.color.withValues(alpha: 0.15),
            child: Icon(item.icon, color: item.color, size: 20),
          ),
          title: Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(item.category),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text(item.title),
                  ),
                  body: DetailPane(item: item),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
