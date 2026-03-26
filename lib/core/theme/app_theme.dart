import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── COLORS ───────────────────────────────────────────────

class AppColors {
  AppColors._();

  // Primary (Rouge vif)
  static const Color primary = Color(0xFFFF4B4B);
  static const Color primaryLight = Color(0xFFFF7A7A);
  static const Color primaryDark = Color(0xFFFF2A2A);

  // Secondary (Jaune vif)
  static const Color secondary = Color(0xFFFFE600);
  static const Color secondaryForeground = Color(0xFF1A1A1E);

  // Accent (Cyan néon)
  static const Color accent = Color(0xFF00E5FF);
  static const Color accentForeground = Color(0xFF1A1A1E);

  // Semantic
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFE600);
  static const Color error = Color(0xFFFF2A2A);

  // Chart / Team colors
  static const Color chart1 = Color(0xFFFF4B4B);
  static const Color chart2 = Color(0xFFFFE600);
  static const Color chart3 = Color(0xFF00E5FF);
  static const Color chart4 = Color(0xFFB554FF);
  static const Color chart5 = Color(0xFF00E676);

  // Surfaces — Dark
  static const Color background = Color(0xFF1A1A1E);
  static const Color foreground = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFF27272F);
  static const Color surfaceVariant = Color(0xFF1E1E24);
  static const Color surfaceLight = Color(0xFF3A3A45);
  static const Color border = Color(0xFF3A3A45);
  static const Color input = Color(0xFF1E1E24);
  static const Color ring = Color(0xFFFFE600);

  // Text
  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFA1A1AA);
  static const Color textLight = Color(0xFF6A6A75);

  // Misc
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}

// ─── SPACING ──────────────────────────────────────────────

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Pre-built EdgeInsets
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const EdgeInsets paddingHorizontalMd =
      EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLg =
      EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingVerticalSm =
      EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMd =
      EdgeInsets.symmetric(vertical: md);
}

// ─── RADIUS ───────────────────────────────────────────────

class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

// ─── RESPONSIVE ───────────────────────────────────────────

class AppBreakpoints {
  AppBreakpoints._();

  static const double small = 360;
  static const double large = 430;
}

class AppResponsive {
  final double screenWidth;
  final double screenHeight;

  // Reference: iPhone 14 — 390×844
  static const double _refWidth = 390;
  static const double _refHeight = 844;

  AppResponsive({required this.screenWidth, required this.screenHeight});

  double get _widthFactor => screenWidth / _refWidth;
  double get _heightFactor => screenHeight / _refHeight;

  /// Scaled font size (clamped ±15%)
  double sp(double size) {
    final scaled = size * _widthFactor;
    final min = size * 0.85;
    final max = size * 1.15;
    return scaled.clamp(min, max);
  }

  /// Scaled width
  double w(double size) => size * _widthFactor;

  /// Scaled height
  double h(double size) => size * _heightFactor;

  /// Scaled radius / symmetric dimension
  double r(double size) => size * _widthFactor;

  bool get isSmallPhone => screenWidth < AppBreakpoints.small;
  bool get isMediumPhone =>
      screenWidth >= AppBreakpoints.small && screenWidth < AppBreakpoints.large;
  bool get isLargePhone => screenWidth >= AppBreakpoints.large;
}

// ─── FONTS ────────────────────────────────────────────────

/// Header font: Bricolage Grotesque
/// Body font: Rubik
class AppFonts {
  AppFonts._();

  static TextStyle headerStyle({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.textPrimary,
  }) =>
      GoogleFonts.bricolageGrotesque(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle bodyStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textPrimary,
  }) =>
      GoogleFonts.rubik(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
}

// ─── EXTENSIONS ───────────────────────────────────────────

extension ResponsiveContext on BuildContext {
  AppResponsive get r {
    final mq = MediaQuery.of(this);
    return AppResponsive(
      screenWidth: mq.size.width,
      screenHeight: mq.size.height,
    );
  }
}

extension TextStyleContext on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
}

extension TextStyleExtensions on TextStyle? {
  TextStyle? get bold => this?.copyWith(fontWeight: FontWeight.w700);
  TextStyle? get semiBold => this?.copyWith(fontWeight: FontWeight.w600);
  TextStyle? withColor(Color color) => this?.copyWith(color: color);
  TextStyle? withSize(double size) => this?.copyWith(fontSize: size);
}

// ─── THEME ────────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    // Body text uses Rubik
    final bodyTextTheme = GoogleFonts.rubikTextTheme().apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    // Override display/headline/title styles with Bricolage Grotesque
    final textTheme = bodyTextTheme.copyWith(
      displayLarge: GoogleFonts.bricolageGrotesque(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      displayMedium: GoogleFonts.bricolageGrotesque(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      displaySmall: GoogleFonts.bricolageGrotesque(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      headlineLarge: GoogleFonts.bricolageGrotesque(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.bricolageGrotesque(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineSmall: GoogleFonts.bricolageGrotesque(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: GoogleFonts.bricolageGrotesque(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.bricolageGrotesque(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleSmall: GoogleFonts.bricolageGrotesque(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.bricolageGrotesque(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: GoogleFonts.bricolageGrotesque(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: GoogleFonts.bricolageGrotesque(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        margin: AppSpacing.paddingSm,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.input,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: TextStyle(
          color: AppColors.textLight,
          fontFamily: GoogleFonts.rubik().fontFamily,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
      dividerColor: AppColors.border,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textLight;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.3);
          }
          return AppColors.surfaceLight;
        }),
      ),
    );
  }
}
