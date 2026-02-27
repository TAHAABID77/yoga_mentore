import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_mentore/Providers/user_provider.dart';

/// App ke notifications ko control krne ke liye page
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool pushNotify = true;
  bool emailNotify = false;
  bool reminders = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: theme.textTheme.titleLarge?.color),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.iconTheme.color),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSwitch(
              'Dark Mode',
              userProvider.isDarkMode,
              (v) => userProvider.toggleTheme(),
              theme,
            ),
            const Divider(),
            _buildSwitch(
              'Push Notifications',
              pushNotify,
              (v) => setState(() => pushNotify = v),
              theme,
            ),
            _buildSwitch(
              'Email Notifications',
              emailNotify,
              (v) => setState(() => emailNotify = v),
              theme,
            ),
            _buildSwitch(
              'Daily Reminders',
              reminders,
              (v) => setState(() => reminders = v),
              theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
    ThemeData theme,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
      ),
      value: value,
      onChanged: onChanged,
      activeTrackColor: const Color(0xFF13EC37).withValues(alpha: 0.5),
      activeThumbColor: const Color(0xFF13EC37),
    );
  }
}
