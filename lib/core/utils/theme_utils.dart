import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryWhite,
        secondary: AppColors.accent,
        surface: AppColors.darkGray,
        // background: AppColors.primaryBlack,
        error: AppColors.error,
        onPrimary: AppColors.primaryBlack,
        onSecondary: AppColors.primaryBlack,
        onSurface: AppColors.textPrimary,
        // onBackground: AppColors.textPrimary,
        onError: AppColors.primaryWhite,
      ),
      scaffoldBackgroundColor: AppColors.primaryBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkGray,
        foregroundColor: AppColors.textPrimary,
        elevation: AppSizes.appBarElevation,
        centerTitle: true,
        toolbarHeight: AppSizes.appBarHeight,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.darkGray,
        elevation: AppSizes.cardElevation,
        margin: const EdgeInsets.all(AppSizes.cardMargin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          side: const BorderSide(color: AppColors.borderGray, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.mediumGray,
        contentPadding: const EdgeInsets.all(AppSizes.textFieldPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.borderGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.primaryWhite, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textTertiary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryWhite,
          foregroundColor: AppColors.primaryBlack,
          elevation: AppSizes.fabElevation,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightL),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.buttonPaddingHorizontalL,
            vertical: AppSizes.buttonPaddingVerticalL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryWhite,
          side: const BorderSide(color: AppColors.primaryWhite, width: 2),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightL),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.buttonPaddingHorizontalL,
            vertical: AppSizes.buttonPaddingVerticalL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryWhite,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600),
        titleMedium: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        titleSmall: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.textPrimary, fontSize: 14),
        bodySmall: TextStyle(color: AppColors.textPrimary, fontSize: 12),
        labelLarge: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        labelMedium: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        labelSmall: TextStyle(color: AppColors.textSecondary, fontSize: 10),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderGray,
        thickness: AppSizes.dividerThickness,
        space: AppSizes.spacingS,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.mediumGray,
        labelStyle: const TextStyle(color: AppColors.textPrimary),
        side: const BorderSide(color: AppColors.borderGray),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.chipPaddingHorizontal,
          vertical: AppSizes.chipPaddingVertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusS),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlack,
        secondary: AppColors.primaryBlack,
        surface: AppColors.lightSurface,
        // background: AppColors.lightBackground,
        error: AppColors.error,
        onPrimary: AppColors.primaryWhite,
        onSecondary: AppColors.primaryWhite,
        onSurface: AppColors.lightTextPrimary,
        // onBackground: AppColors.lightTextPrimary,
        onError: AppColors.primaryWhite,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: AppSizes.appBarElevation,
        centerTitle: true,
        toolbarHeight: AppSizes.appBarHeight,
        titleTextStyle: TextStyle(
          color: AppColors.lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.lightSurface,
        elevation: AppSizes.cardElevation,
        margin: const EdgeInsets.all(AppSizes.cardMargin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: const EdgeInsets.all(AppSizes.textFieldPadding),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.primaryBlack, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: const TextStyle(color: AppColors.lightTextSecondary),
        hintStyle: const TextStyle(color: AppColors.lightTextSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlack,
          foregroundColor: AppColors.primaryWhite,
          elevation: AppSizes.fabElevation,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightL),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.buttonPaddingHorizontalL,
            vertical: AppSizes.buttonPaddingVerticalL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBlack,
          side: const BorderSide(color: AppColors.primaryBlack, width: 2),
          minimumSize: const Size(double.infinity, AppSizes.buttonHeightL),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.buttonPaddingHorizontalL,
            vertical: AppSizes.buttonPaddingVerticalL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlack,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600),
        titleMedium: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        titleSmall: TextStyle(
            color: AppColors.lightTextPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColors.lightTextPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.lightTextPrimary, fontSize: 14),
        bodySmall: TextStyle(color: AppColors.lightTextPrimary, fontSize: 12),
        labelLarge:
            TextStyle(color: AppColors.lightTextSecondary, fontSize: 14),
        labelMedium:
            TextStyle(color: AppColors.lightTextSecondary, fontSize: 12),
        labelSmall:
            TextStyle(color: AppColors.lightTextSecondary, fontSize: 10),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: AppSizes.dividerThickness,
        space: AppSizes.spacingS,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurface,
        labelStyle: const TextStyle(color: AppColors.lightTextPrimary),
        side: const BorderSide(color: AppColors.lightBorder),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.chipPaddingHorizontal,
          vertical: AppSizes.chipPaddingVertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusS),
        ),
      ),
    );
  }
}
