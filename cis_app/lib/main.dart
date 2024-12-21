import 'package:cis_app/FinalResultScreen.dart';
import 'package:cis_app/upload.dart';
import 'package:flutter/material.dart';
import 'details.dart';
import 'gender.dart';
import 'market.dart';
import 'FinalResultScreen.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'Dashboard.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

final ValueNotifier<ThemeData> themeNotifier = ValueNotifier(ThemeData.light());
final ValueNotifier<Locale> localeNotifier = ValueNotifier(Locale('en'));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: themeNotifier,
      builder: (context, theme, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (context, locale, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              locale: locale,
              supportedLocales: [
                Locale('en', ''), // Anglais
                Locale('fr', ''), // Français
              ],
              localizationsDelegates: [
                // Ajoutez ici les délégations de localisation nécessaires
              ],
              initialRoute: '/login',
              routes: {
                '/signup': (context) => SignUpScreen(),
                '/login': (context) => LoginScreen(),
                '/gender': (context) => GenderSelectionScreen(),
                '/upload': (context) => FileUploadScreen(),
                '/market': (context) => MarketPage(),
                '/dashboard': (context) => DashboardApp(),
                '/settings': (context) => SettingsPage(), // Nouvelle route
                '/final': (context) => FinalResultScreen(),

              },
            );
          },
        );
      },
    );
  }
}
