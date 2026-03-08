import 'package:flutter/material.dart';

abstract class AppTheme {
  // ── Brand Colors ──────────────────────────────────────────
  static const Color primary = Color(0xFF6C2BEE);
  static const Color primaryLight = Color(0xFF8B5CF6);
  static const Color primaryContainer = Color(0xFFEDE9FE);
  static const Color background = Color(0xFFF4F3FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8F7FF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1C1B2E);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color divider = Color(0xFFE8E5F5);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'DMSans',
        colorScheme: const ColorScheme.light(
          primary: primary,
          onPrimary: onPrimary,
          primaryContainer: primaryContainer,
          surface: surface,
          onSurface: textPrimary,
          surfaceContainerHighest: surfaceVariant,
        ).copyWith(error: error),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: textPrimary,
          titleTextStyle: TextStyle(
            fontFamily: 'Syne',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: onPrimary,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontFamily: 'DMSans',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            elevation: 0,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 1.5),
          ),
          hintStyle: const TextStyle(color: textHint, fontSize: 14),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        cardTheme: CardThemeData(
          color: surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: divider),
          ),
        ),
        dividerTheme:
            const DividerThemeData(color: divider, thickness: 1, space: 1),
      );
}

// ── Text Styles ──────────────────────────────────────────────
abstract class AppTextStyles {
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Syne',
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: -1,
    color: AppTheme.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Syne',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppTheme.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Syne',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppTheme.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppTheme.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppTheme.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppTheme.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: AppTheme.textSecondary,
  );
}

// ── Spacing ───────────────────────────────────────────────────
abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}
