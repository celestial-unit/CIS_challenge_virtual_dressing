import 'package:flutter/material.dart';
import 'main.dart'; // Pour accéder à themeNotifier et localeNotifier

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkTheme = false;
  String _currentLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Changer le thème
            Text(
              'Theme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: Text('Dark Theme'),
              value: _isDarkTheme,
              onChanged: (value) {
                setState(() {
                  _isDarkTheme = value;
                  // Met à jour le thème global
                  themeNotifier.value =
                  _isDarkTheme ? ThemeData.dark() : ThemeData.light();
                });
              },
            ),
            SizedBox(height: 20),
            // Changer la langue
            Text(
              'Language',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _currentLanguage,
              onChanged: (newValue) {
                setState(() {
                  _currentLanguage = newValue!;
                  // Met à jour la langue globale
                  localeNotifier.value =
                  _currentLanguage == 'English' ? Locale('en') : Locale('fr');
                });
              },
              items: <String>['English', 'Français']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
