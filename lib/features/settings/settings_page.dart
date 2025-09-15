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
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Notification switch (local state only)
            SwitchListTile(
              title: const Text('알림 사용'),
              value: _notificationsEnabled,
              onChanged: (v) => setState(() => _notificationsEnabled = v),
            ),
            const SizedBox(height: 16),

            // Backup / Restore buttons
            Text('백업 및 복원', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
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

            const SizedBox(height: 24),

            // App info
            Text('앱 정보', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.info_outline),
              title: Text('버전'),
              subtitle: Text('1.0.0 (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}

