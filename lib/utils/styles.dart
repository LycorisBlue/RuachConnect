import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color primary = Color(0xFF2C3E50);
  static const Color secondary = Color(0xFF34495E);
  static const Color accent = Color(0xFF5D6D7E);
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFE67E22);
  static const Color danger = Color(0xFFE74C3C);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF212529);
  static const Color onBackground = Color(0xFF495057);
  static const Color divider = Color(0xFFDEE2E6);
}

class AppTextStyles {
  static TextStyle get h1 => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  static TextStyle get h2 => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static TextStyle get body => TextStyle(
    fontSize: 16.sp,
    color: AppColors.onBackground,
  );

  static TextStyle get caption => TextStyle(
    fontSize: 14.sp,
    color: AppColors.accent,
  );
}

class AppTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.divider),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );
}

class ResponsiveHelper {
  static bool get isMobile => ScreenUtil().screenWidth < 600;
  static bool get isTablet => ScreenUtil().screenWidth >= 600;
  
  static double get cardWidth => isMobile ? 1.sw : 0.4.sw;
  static EdgeInsets get screenPadding => EdgeInsets.all(isMobile ? 16.w : 24.w);
  static int get crossAxisCount => isMobile ? 1 : 2;
}