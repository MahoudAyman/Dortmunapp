import 'package:flutter/material.dart';
import '../models/project_item.dart';

/// Renders detailed information for a selected [ProjectItem].
/// Used either as a standalone page on compact screens or as the right-hand pane on medium/large screens.
class DetailPane extends StatelessWidget {
  const DetailPane({
    super.key,
    required this.item,
    this.onClose,
  });

  final ProjectItem? item;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (item == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.touch_app_outlined,
              size: 64,
              color: theme.colorScheme.outlineVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Select an item to view details',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    final currentItem = item!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: currentItem.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  currentItem.icon,
                  color: currentItem.color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentItem.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currentItem.category,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              if (onClose != null)
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose,
                ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // Progress section
          Text(
            'Implementation Progress',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: currentItem.progress,
                    minHeight: 10,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(currentItem.color),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(currentItem.progress * 100).toInt()}%',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Overview
          Text(
            'Architecture Overview',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentItem.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Tags
          Text(
            'Relevant Concepts',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: currentItem.tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: theme.colorScheme.surfaceContainerLow,
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),

          // Actions
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: const Text('Execute Layout Test'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.code),
                label: const Text('Inspect Widget Tree'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
