import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.lightBackground,
      error: AppColors.errorRed,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ).apply(
      bodyColor: AppColors.lightText,
      displayColor: AppColors.lightText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColors.iconGrey),
    dividerColor: AppColors.borderGrey,
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.darkBackground,
      error: AppColors.errorRed,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    dividerColor: AppColors.darkGrey,
  );
}
