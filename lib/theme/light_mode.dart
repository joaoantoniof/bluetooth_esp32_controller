import 'package:flutter/material.dart';


ThemeData lightMode = ThemeData(
brightness: Brightness.light,
colorScheme: ColorScheme.light(
  surface: const Color.fromARGB(255, 212, 212, 200),
  primary: Colors.grey.shade200,
  secondary: const Color.fromARGB(255, 49, 39, 71),
  primaryContainer:Color.fromARGB(255, 74, 67, 94),
  secondaryContainer:const Color.fromARGB(255, 90, 77, 124),
  inversePrimary: Colors.grey.shade800
  ),
    textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey.shade700,
    displayColor: Colors.black)
  );
