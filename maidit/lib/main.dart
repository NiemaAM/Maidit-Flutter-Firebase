// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:maidit/Pages/Login%20and%20SignIn/SplashScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //This is the colors theme of the app
  final ThemeData myTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    primaryColorDark: Colors.indigo,
    primaryColorLight: Colors.lightBlue[100],
    cardColor: Colors.grey[100],
    dividerColor: Colors.grey,
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: const MaterialColor(
      0xFF0069F2,
      <int, Color>{
        50: Color(0xFFE5F0FF),
        100: Color(0xFFB8D5FF),
        200: Color(0xFF8ABAFF),
        300: Color(0xFF5D9FFF),
        400: Color(0xFF387CFF),
        500: Color(0xFF0069F2),
        600: Color(0xFF005EDF),
        700: Color(0xFF0052CC),
        800: Color(0xFF0048B8),
        900: Color(0xFF00308C),
      },
    ))
        .copyWith(background: Colors.lightBlue[100])
        .copyWith(error: Colors.red)
        .copyWith(secondary: Colors.pink),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaidIt',
      theme: myTheme,
      home: const SplashScreen(),
    );
  }
}
