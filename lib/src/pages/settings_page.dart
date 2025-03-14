import 'package:flutter/material.dart';

enum ThemeOptions { system, dark, light }

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String path = '/settings';
  static const String name = 'Settings';

  static const borderStyle = Border(
    bottom: BorderSide(
      color: Color.fromARGB(255, 233, 231, 231),
    ),
  );

  Widget _renderMenu(BuildContext context, String title, {Widget? trailing}) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(left: 10, right: 10),
      title: Text(title),
      trailing: trailing ?? Icon(Icons.navigate_next),
      onTap: () async {
        await _showSelection(context, "Theme");
      },
      shape: borderStyle,
    );
  }

  Future<bool?> _showSelection(BuildContext context, String title) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  dense: true,
                  title: Text('System(Default)'),
                  leading: Radio<ThemeOptions>(
                    value: ThemeOptions.system,
                    onChanged: (ThemeOptions? value) {},
                    groupValue: ThemeOptions.system,
                  ),
                ),
                ListTile(
                  dense: true,
                  title: Text('Light'),
                  leading: Radio<ThemeOptions>(
                    value: ThemeOptions.light,
                    onChanged: (ThemeOptions? value) {},
                    groupValue: ThemeOptions.light,
                  ),
                ),
                ListTile(
                  dense: true,
                  title: Text('Dark'),
                  leading: Radio<ThemeOptions>(
                    value: ThemeOptions.dark,
                    onChanged: (ThemeOptions? value) {},
                    groupValue: ThemeOptions.dark,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          _renderMenu(context, "Storage"),
          _renderMenu(context, "Language", trailing: Text("English")),
          _renderMenu(context, "Theme", trailing: Text("Default(System)")),
          _renderMenu(context, "Change master password"),
          _renderMenu(context, "Unlock with Biometrics"),
          _renderMenu(context, "Session timeout"),
          _renderMenu(context, "Clear clipboard"),
          _renderMenu(context, "Allow screen capture"),
        ],
      ),
    );
  }
}
