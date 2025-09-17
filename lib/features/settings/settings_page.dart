import 'package:devicenote/responsive_layout.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false; // Local state only

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: AppBar(title: const Text('설정')),
      builder: (context, layout) {
        final sectionWidth = layout.columns > 1
            ? layout.columnWidth(span: 2)
            : layout.columnWidth(span: layout.columns);
        final fullWidth = layout.columnWidth(span: layout.columns);

        return Wrap(
          spacing: layout.gutter,
          runSpacing: layout.gutter,
          children: [
            SizedBox(
              width: sectionWidth,
              child: Card(
                child: SwitchListTile(
                  title: const Text('알림 사용'),
                  value: _notificationsEnabled,
                  onChanged: (v) => setState(() => _notificationsEnabled = v),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            SizedBox(
              width: sectionWidth,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '백업 및 복원',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement backup logic
                              },
                              child: const Text('백업'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement restore logic
                              },
                              child: const Text('복원'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: fullWidth,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('버전'),
                  subtitle: const Text('1.0.0 (placeholder)'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
