import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive_container.dart';

/// Settings and preferences screen demonstrating responsive form design,
/// centering, and width constraints to prevent input stretching on wide screens.
class SettingsView extends StatefulWidget {
  const SettingsView({
    super.key,
    required this.isDarkMode,
    required this.onThemeModeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeModeChanged;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _enableAutoResize = true;
  bool _highContrast = false;
  String _selectedDensity = 'Standard';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Constraining form width to 760 dp for comfortable reading and input reach
    return ResponsiveContainer(
      maxWidth: 760,
      child: ListView(
        children: [
          Text(
            'Layout & Display Settings',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Configure how the adaptive engine handles breakpoints, themes, and input density.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Appearance Card
          Card(
            elevation: 0,
            color: theme.colorScheme.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appearance & Theme',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Toggle between dark and light Material 3 palette'),
                    secondary: Icon(
                      widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: theme.colorScheme.primary,
                    ),
                    value: widget.isDarkMode,
                    onChanged: widget.onThemeModeChanged,
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('High Contrast Outlines'),
                    subtitle: const Text('Increase border visibility on multi-pane layouts'),
                    secondary: Icon(
                      Icons.contrast,
                      color: theme.colorScheme.primary,
                    ),
                    value: _highContrast,
                    onChanged: (val) => setState(() => _highContrast = val),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Form input card using Responsive LayoutBuilder
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= Breakpoints.mediumMinWidth;

              return Card(
                elevation: 0,
                color: theme.colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Device Emulation & Breakpoint Controls',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // If wide: side-by-side inputs; if compact: vertical stacked inputs
                      if (isWide)
                        Row(
                          children: [
                            Expanded(
                              child: _buildDensityDropdown(theme),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildMaxContentField(theme),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            _buildDensityDropdown(theme),
                            const SizedBox(height: 16),
                            _buildMaxContentField(theme),
                          ],
                        ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Auto-adapt Window Resize'),
                        subtitle: const Text('Live re-layout on window size changes without page reload'),
                        value: _enableAutoResize,
                        onChanged: (val) => setState(() => _enableAutoResize = val),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Responsive Save button bar
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Reset Defaults'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preferences saved successfully.')),
                    );
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Apply Settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDensityDropdown(ThemeData theme) {
    return DropdownButtonFormField<String>(
      initialValue: _selectedDensity,
      decoration: InputDecoration(
        labelText: 'Visual Density',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: const [
        DropdownMenuItem(value: 'Comfortable', child: Text('Comfortable (Touch)')),
        DropdownMenuItem(value: 'Standard', child: Text('Standard')),
        DropdownMenuItem(value: 'Compact', child: Text('Compact (Mouse/Desktop)')),
      ],
      onChanged: (val) {
        if (val != null) setState(() => _selectedDensity = val);
      },
    );
  }

  Widget _buildMaxContentField(ThemeData theme) {
    return TextFormField(
      initialValue: '1200',
      decoration: InputDecoration(
        labelText: 'Content Max Width (dp)',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixText: 'dp',
      ),
      keyboardType: TextInputType.number,
    );
  }
}
