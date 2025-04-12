import 'package:flicknest/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColorsLight.primaryColor,
  scaffoldBackgroundColor: AppColorsLight.backgroundColor,
  canvasColor: AppColorsLight.backgroundColor,
  cardColor: AppColorsLight.cardColor,
  hintColor: AppColorsLight.greyColor,
  fontFamily: AppConstants.fontRaleway,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsLight.primaryColor,
    elevation: 2,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: AppColorsLight.primary2,
    elevation: 0,
    scrimColor: Colors.black45,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColorsLight.textFieldColor,
    hintStyle: TextStyle(color: AppColorsLight.greyColor),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(color: AppColorsLight.textColor),
    displayMedium: TextStyle(color: AppColorsLight.textColor),
    displaySmall: TextStyle(color: AppColorsLight.textColor),
    headlineLarge: TextStyle(color: AppColorsLight.textColor),
    headlineMedium: TextStyle(color: AppColorsLight.textColor),
    headlineSmall: TextStyle(color: AppColorsLight.textColor),
    titleLarge: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    titleSmall: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: AppColorsLight.textColor),
    bodyMedium: TextStyle(color: AppColorsLight.textColor, fontSize: 16),
    bodySmall: TextStyle(color: AppColorsLight.textColor),
    labelLarge: TextStyle(color: AppColorsLight.textColor),
    labelMedium: TextStyle(color: AppColorsLight.textColor),
    labelSmall: TextStyle(color: AppColorsLight.textColor),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColorsLight.primaryColor,
    brightness: Brightness.light,
    primary: AppColorsLight.primaryColor,
    secondary: AppColorsLight.secondaryColor,
    surface: AppColorsLight.backgroundColor,
  ),
  indicatorColor: AppColorsLight.secondaryColor,
  searchBarTheme: SearchBarThemeData(
    constraints: const BoxConstraints(maxWidth: double.infinity, minHeight: 50, maxHeight: 50),
    textStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    backgroundColor: WidgetStatePropertyAll(AppColorsLight.primaryColor),
    side: WidgetStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(WidgetState.focused)) {
        return BorderSide(color: AppColorsLight.secondaryColor);
      }
      return const BorderSide(color: Colors.transparent);
    }),
    shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    elevation: const WidgetStatePropertyAll(1),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
  ),
);

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: Colors.transparent,
  canvasColor: AppColors.backgroundColor,
  cardColor: AppColors.primary2,
  hintColor: AppColors.greyColor,
  fontFamily: AppConstants.fontRaleway,
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: AppColors.primary2,
    elevation: 0,
    scrimColor: Colors.transparent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.textFieldColor,
    hintStyle: TextStyle(color: Colors.white70),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
    bodySmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    surface: AppColors.backgroundColor,
  ),
  indicatorColor: AppColors.secondaryColor,
  searchBarTheme: SearchBarThemeData(
    constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 50, maxHeight: 50),
    textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    hintStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
    side: WidgetStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(WidgetState.focused)) {
        return BorderSide(color: AppColors.secondaryColor);
      }
      return BorderSide(color: Colors.transparent);
    }),
    shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    elevation: const WidgetStatePropertyAll(1),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
  ),
);
