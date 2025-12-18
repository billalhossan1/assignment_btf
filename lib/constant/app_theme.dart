import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';

class AppTheme {
  AppTheme._privateConstructor();
  static final AppTheme _instance = AppTheme._privateConstructor();
  static AppTheme get instance => _instance;

  // Light Theme
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.instance.primary,
      scaffoldBackgroundColor: AppColors.instance.white100,
      colorScheme: ColorScheme.light(
        primary: AppColors.instance.primary,
        secondary: AppColors.instance.green500,
        surface: AppColors.instance.white50,
        error: AppColors.instance.error,
        onPrimary: AppColors.instance.white50,
        onSecondary: AppColors.instance.white50,
        onSurface: AppColors.instance.dark500,
        onError: AppColors.instance.white50,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.instance.white50,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.instance.dark500),
        titleTextStyle: TextStyle(
          color: AppColors.instance.dark500,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.instance.white50,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.instance.white50,
        selectedItemColor: AppColors.instance.primary,
        unselectedItemColor: AppColors.instance.dark200,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.instance.primary,
        foregroundColor: AppColors.instance.white50,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.instance.white200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.instance.primary, width: 2),
        ),
      ),
    );
  }

  // Dark Theme
  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.instance.primary,
      scaffoldBackgroundColor: AppColors.instance.dark900,
      colorScheme: ColorScheme.dark(
        primary: AppColors.instance.primary,
        secondary: AppColors.instance.green500,
        surface: AppColors.instance.dark800,
        error: AppColors.instance.error,
        onPrimary: AppColors.instance.white50,
        onSecondary: AppColors.instance.white50,
        onSurface: AppColors.instance.white200,
        onError: AppColors.instance.white50,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.instance.dark800,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.instance.white200),
        titleTextStyle: TextStyle(
          color: AppColors.instance.white200,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.instance.dark800,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.instance.dark800,
        selectedItemColor: AppColors.instance.primary,
        unselectedItemColor: AppColors.instance.dark200,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.instance.primary,
        foregroundColor: AppColors.instance.white50,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.instance.dark700,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.instance.primary, width: 2),
        ),
      ),
    );
  }
}
