import 'package:flutter/material.dart';


ThemeData darkMode = ThemeData(
brightness: Brightness.dark,
colorScheme: ColorScheme.dark(
  surface: const Color.fromARGB(255, 43, 43, 43),
  primary: Colors.grey.shade300,
  secondary: const Color.fromARGB(255, 26, 26, 26),
  // secondary: const Color.fromARGB(255, 54, 43, 85),
  secondaryContainer:Color.fromARGB(255, 92, 80, 122),
  inversePrimary: Colors.grey.shade300
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[300],
    displayColor: Colors.white)
  );
