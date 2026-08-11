import 'package:flutter/material.dart';

extension FlowwThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get scheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  AppColorTokens get colors => theme.extension<AppColorTokens>()!;

  AppGradientTokens get gradients => theme.extension<AppGradientTokens>()!;
}

class _AppPalette {
  const _AppPalette._();

  static const backgroundPrimary = Color(0xFF0A0A0A);
  static const backgroundSecondary = Color(0xFF181818);
  static const backgroundSurface = Color(0xFF1F1F1F);
  static const backgroundElevated = Color(0xFF2D2D2D);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0x80FFFFFF);
  static const textTertiary = Color(0x33FFFFFF);
  static const textMuted = Color(0xFF999999);

  static const borderSubtle = Color(0x1AFFFFFF);
  static const borderMedium = Color(0x33FFFFFF);

  static const destructive = Color(0xFFDC2626);
  static const destructiveBorder = Color(0xFFEF4444);
}

@immutable
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  const AppColorTokens({
    required this.primary,
    required this.primaryDeep,
    required this.primaryAlt,
    required this.tint,
    required this.tintStrong,
    required this.borderGlow,
    required this.bgTinted,
    required this.bgWarm,
    required this.accentOrange,
    this.backgroundPrimary = _AppPalette.backgroundPrimary,
    this.backgroundSecondary = _AppPalette.backgroundSecondary,
    this.backgroundSurface = _AppPalette.backgroundSurface,
    this.backgroundElevated = _AppPalette.backgroundElevated,
    this.textPrimary = _AppPalette.textPrimary,
    this.textSecondary = _AppPalette.textSecondary,
    this.textTertiary = _AppPalette.textTertiary,
    this.textMuted = _AppPalette.textMuted,
    this.borderSubtle = _AppPalette.borderSubtle,
    this.borderMedium = _AppPalette.borderMedium,
    this.destructive = _AppPalette.destructive,
    this.destructiveBorder = _AppPalette.destructiveBorder,
    this.glassSurface = _AppPalette.textSecondary,
  });

  final Color primary;
  final Color primaryDeep;
  final Color primaryAlt;
  final Color tint;
  final Color tintStrong;
  final Color borderGlow;
  final Color bgTinted;
  final Color bgWarm;
  final Color accentOrange;

  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundSurface;
  final Color backgroundElevated;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textMuted;
  final Color borderSubtle;
  final Color borderMedium;
  final Color destructive;
  final Color destructiveBorder;
  final Color glassSurface;

  static const flow = AppColorTokens(
    primary: Color(0xFFC3FF3D),
    primaryDeep: Color(0xFF84CC16),
    primaryAlt: Color(0xFFBAFF1F),
    tint: Color(0x14C3FF3D),
    tintStrong: Color(0x14C3FF3D),
    borderGlow: Color(0x3DC3FF3D),
    bgTinted: Color(0xFF1F2218),
    bgWarm: Color(0xFF23221A),
    accentOrange: Color(0xFFF97316),
  );

  static const steady = AppColorTokens(
    primary: Color(0xFFF97316),
    primaryDeep: Color(0xFFD55900),
    primaryAlt: Color(0xFFF59E0B),
    tint: Color(0x14F97316),
    tintStrong: Color(0x14F97316),
    borderGlow: Color(0x3DF59E0B),
    bgTinted: Color(0xFF221C18),
    bgWarm: Color(0xFF23221A),
    accentOrange: Color(0xFFF97316),
  );

  static const restore = AppColorTokens(
    primary: Color(0xFF28D5E6),
    primaryDeep: Color(0xFF00C4D5),
    primaryAlt: Color(0xFF22CDE6),
    tint: Color(0x1422CDE6),
    tintStrong: Color(0x1728D5E6),
    borderGlow: Color(0x3D22CDE6),
    bgTinted: Color(0xFF182122),
    bgWarm: Color(0xFF182122),
    accentOrange: Color(0xFFF97316),
  );

  @override
  AppColorTokens copyWith({
    Color? primary,
    Color? primaryDeep,
    Color? primaryAlt,
    Color? tint,
    Color? tintStrong,
    Color? borderGlow,
    Color? bgTinted,
    Color? bgWarm,
    Color? accentOrange,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundSurface,
    Color? backgroundElevated,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textMuted,
    Color? borderSubtle,
    Color? borderMedium,
    Color? destructive,
    Color? destructiveBorder,
    Color? glassSurface,
  }) {
    return AppColorTokens(
      primary: primary ?? this.primary,
      primaryDeep: primaryDeep ?? this.primaryDeep,
      primaryAlt: primaryAlt ?? this.primaryAlt,
      tint: tint ?? this.tint,
      tintStrong: tintStrong ?? this.tintStrong,
      borderGlow: borderGlow ?? this.borderGlow,
      bgTinted: bgTinted ?? this.bgTinted,
      bgWarm: bgWarm ?? this.bgWarm,
      accentOrange: accentOrange ?? this.accentOrange,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundSurface: backgroundSurface ?? this.backgroundSurface,
      backgroundElevated: backgroundElevated ?? this.backgroundElevated,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textMuted: textMuted ?? this.textMuted,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderMedium: borderMedium ?? this.borderMedium,
      destructive: destructive ?? this.destructive,
      destructiveBorder: destructiveBorder ?? this.destructiveBorder,
      glassSurface: glassSurface ?? this.glassSurface,
    );
  }

  @override
  AppColorTokens lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDeep: Color.lerp(primaryDeep, other.primaryDeep, t)!,
      primaryAlt: Color.lerp(primaryAlt, other.primaryAlt, t)!,
      tint: Color.lerp(tint, other.tint, t)!,
      tintStrong: Color.lerp(tintStrong, other.tintStrong, t)!,
      borderGlow: Color.lerp(borderGlow, other.borderGlow, t)!,
      bgTinted: Color.lerp(bgTinted, other.bgTinted, t)!,
      bgWarm: Color.lerp(bgWarm, other.bgWarm, t)!,
      accentOrange: Color.lerp(accentOrange, other.accentOrange, t)!,
      backgroundPrimary: Color.lerp(
        backgroundPrimary,
        other.backgroundPrimary,
        t,
      )!,
      backgroundSecondary: Color.lerp(
        backgroundSecondary,
        other.backgroundSecondary,
        t,
      )!,
      backgroundSurface: Color.lerp(
        backgroundSurface,
        other.backgroundSurface,
        t,
      )!,
      backgroundElevated: Color.lerp(
        backgroundElevated,
        other.backgroundElevated,
        t,
      )!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderMedium: Color.lerp(borderMedium, other.borderMedium, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructiveBorder: Color.lerp(
        destructiveBorder,
        other.destructiveBorder,
        t,
      )!,
      glassSurface: Color.lerp(glassSurface, other.glassSurface, t)!,
    );
  }
}

@immutable
class AppGradientTokens extends ThemeExtension<AppGradientTokens> {
  const AppGradientTokens({
    required this.primary,
    required this.bright,
    required this.ramp,
    required this.full,
    required this.darkGlow,
    required this.reversed,
    required this.amber,
    required this.subtle,
    required this.orange,
    required this.glowRadial,
  });

  final Gradient primary;
  final Gradient bright;
  final Gradient ramp;
  final Gradient full;
  final Gradient darkGlow;
  final Gradient reversed;
  final Gradient amber;
  final Gradient subtle;
  final Gradient orange;
  final Gradient glowRadial;

  static const flow = AppGradientTokens(
    primary: LinearGradient(colors: [Color(0xFFC3FF3D), Color(0xFF87B26B)]),
    bright: LinearGradient(colors: [Color(0xFFC3FF3D), Color(0xFFA9F500)]),
    ramp: LinearGradient(colors: [Color(0xFF84CC16), Color(0xFFC3FF3D)]),
    full: LinearGradient(
      colors: [Color(0xFF84B814), Color(0xFFC3FF3D), Color(0xFFFFFFFF)],
    ),
    darkGlow: LinearGradient(
      colors: [Color(0xFF1C2218), Color(0xFF93D500)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
    reversed: LinearGradient(colors: [Color(0xFF87B26B), Color(0xFFC3FF3D)]),
    amber: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFF59E0B)]),
    subtle: LinearGradient(colors: [Color(0xFFC3FF3D), Color(0xFFC3FF3D)]),
    orange: LinearGradient(colors: [Color(0xFFD55900), Color(0xFFF97316)]),
    glowRadial: RadialGradient(
      colors: [Color(0x17C3FF3D), Color(0xFF000000)],
      stops: [0, 0.7],
    ),
  );

  static const steady = AppGradientTokens(
    primary: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFD55900)]),
    bright: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFF97316)]),
    ramp: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFF97316)]),
    full: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFF97316)]),
    darkGlow: LinearGradient(
      colors: [Color(0xFF221C18), Color(0xFFD55900)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
    reversed: LinearGradient(colors: [Color(0xFFD55900), Color(0xFFF97316)]),
    amber: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFF59E0B)]),
    subtle: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFF97316)]),
    orange: LinearGradient(colors: [Color(0xFFD55900), Color(0xFFF97316)]),
    glowRadial: RadialGradient(
      colors: [Color(0x17F97316), Color(0xFF000000)],
      stops: [0, 0.7],
    ),
  );

  static const restore = AppGradientTokens(
    primary: LinearGradient(colors: [Color(0xFF28D5E6), Color(0xFF00C4D5)]),
    bright: LinearGradient(colors: [Color(0xFF28D5E6), Color(0xFF28D5E6)]),
    ramp: LinearGradient(colors: [Color(0xFF28D5E6), Color(0xFF28D5E6)]),
    full: LinearGradient(colors: [Color(0xFF28D5E6), Color(0xFF28D5E6)]),
    darkGlow: LinearGradient(
      colors: [Color(0xFF182122), Color(0xFF00C4D5)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
    reversed: LinearGradient(colors: [Color(0xFF00C4D5), Color(0xFF28D5E6)]),
    amber: LinearGradient(colors: [Color(0xFFF97316), Color(0xFFF59E0B)]),
    subtle: LinearGradient(colors: [Color(0xFF28D5E6), Color(0xFF22CDE6)]),
    orange: LinearGradient(colors: [Color(0xFFD55900), Color(0xFFF97316)]),
    glowRadial: RadialGradient(
      colors: [Color(0x1728D5E6), Color(0xFF000000)],
      stops: [0, 0.7],
    ),
  );

  @override
  AppGradientTokens copyWith({
    Gradient? primary,
    Gradient? bright,
    Gradient? ramp,
    Gradient? full,
    Gradient? darkGlow,
    Gradient? reversed,
    Gradient? amber,
    Gradient? subtle,
    Gradient? orange,
    Gradient? glowRadial,
  }) {
    return AppGradientTokens(
      primary: primary ?? this.primary,
      bright: bright ?? this.bright,
      ramp: ramp ?? this.ramp,
      full: full ?? this.full,
      darkGlow: darkGlow ?? this.darkGlow,
      reversed: reversed ?? this.reversed,
      amber: amber ?? this.amber,
      subtle: subtle ?? this.subtle,
      orange: orange ?? this.orange,
      glowRadial: glowRadial ?? this.glowRadial,
    );
  }

  @override
  AppGradientTokens lerp(ThemeExtension<AppGradientTokens>? other, double t) {
    if (other is! AppGradientTokens) return this;
    return AppGradientTokens(
      primary: Gradient.lerp(primary, other.primary, t)!,
      bright: Gradient.lerp(bright, other.bright, t)!,
      ramp: Gradient.lerp(ramp, other.ramp, t)!,
      full: Gradient.lerp(full, other.full, t)!,
      darkGlow: Gradient.lerp(darkGlow, other.darkGlow, t)!,
      reversed: Gradient.lerp(reversed, other.reversed, t)!,
      amber: Gradient.lerp(amber, other.amber, t)!,
      subtle: Gradient.lerp(subtle, other.subtle, t)!,
      orange: Gradient.lerp(orange, other.orange, t)!,
      glowRadial: Gradient.lerp(glowRadial, other.glowRadial, t)!,
    );
  }
}
