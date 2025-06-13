import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Lufga',
  primaryColor: LightColors.primary,
  scaffoldBackgroundColor: LightColors.bgWhite,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: LightColors.text, fontSize: 16),
    bodyMedium: TextStyle(color: LightColors.text, fontSize: 14),
    bodySmall: TextStyle(color: LightColors.text, fontSize: 12),
    displayLarge: TextStyle(color: LightColors.purple, fontSize: 16),
    displayMedium: TextStyle(color: LightColors.purple, fontSize: 14),
    displaySmall: TextStyle(color: LightColors.purple, fontSize: 12),
    titleLarge: TextStyle(
        color: LightColors.text, fontSize: 16, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        color: LightColors.text, fontSize: 14, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        color: LightColors.text, fontSize: 12, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
        color: LightColors.purple, fontSize: 16, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        color: LightColors.purple, fontSize: 14, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
        color: LightColors.purple, fontSize: 12, fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme.light(
    primary: LightColors.primary,
    secondary: LightColors.secondary,
    surface: LightColors.bgWhite,
    surfaceTint: LightColors.lightPrimary,
    primaryFixed: LightColors.purple,
    secondaryFixed: DarkColors.primaryLight,
    surfaceDim: LightColors.black,
    surfaceBright: LightColors.successGreen,
    error: LightColors.alert,
    tertiary: AppColors.blue,
    shadow: Colors.black26,
    outline: LightColors.lightGray,
  ),
  useMaterial3: true,
  tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: DarkColors.primary,
  scaffoldBackgroundColor: DarkColors.bgWhite,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: DarkColors.text, fontSize: 16),
    bodyMedium: TextStyle(color: DarkColors.text, fontSize: 14),
    bodySmall: TextStyle(color: DarkColors.text, fontSize: 12),
    displayLarge: TextStyle(color: DarkColors.purple, fontSize: 16),
    displayMedium: TextStyle(color: DarkColors.purple, fontSize: 14),
    displaySmall: TextStyle(color: DarkColors.purple, fontSize: 12),
    titleLarge: TextStyle(
        color: DarkColors.text, fontSize: 16, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        color: DarkColors.text, fontSize: 14, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        color: DarkColors.text, fontSize: 12, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
        color: DarkColors.purple, fontSize: 16, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        color: DarkColors.purple, fontSize: 14, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(
        color: DarkColors.purple, fontSize: 12, fontWeight: FontWeight.bold),
  ),
  colorScheme: const ColorScheme.dark(
    primary: DarkColors.primary,
    secondary: DarkColors.secondary,
    surface: DarkColors.bgWhite,
    surfaceTint: DarkColors.lightPrimary,
    primaryFixed: DarkColors.purple,
    secondaryFixed: DarkColors.primaryLight,
    surfaceDim: DarkColors.white,
    surfaceBright: DarkColors.successGreen,
    error: DarkColors.alert,
    tertiary: AppColors.blue,
    shadow: Colors.white24,
    outline: DarkColors.lightGray,
  ),
  fontFamily: 'Lufga',
  useMaterial3: true,
  tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
);
