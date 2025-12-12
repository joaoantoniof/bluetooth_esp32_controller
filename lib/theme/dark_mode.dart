import 'package:flutter/material.dart';


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 22, 22, 22),
    primary: Colors.grey.shade300,
    secondary: const Color.fromARGB(255, 26, 26, 26),
    primaryContainer:Color.fromARGB(255, 46, 38, 65),
    secondaryContainer:Color.fromARGB(255, 61, 52, 85),
    inversePrimary: Colors.grey.shade300
    ),

textTheme: 
  ThemeData.dark().textTheme.apply(
        bodyColor: Colors.grey[300],
        displayColor: Colors.white),
);
// text styling for headlines, titles, bodies of text, and more.
