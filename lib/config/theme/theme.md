# Floww Theming Architecture

Floww has three visual modes: **Flow**, **Steady**, and **Restore**. The selected mode changes the app colors and gradients globally. Typography, spacing, radii, component structure, and layout behavior stay shared across all modes.

## Golden Rule

Do not hardcode raw colors or gradients in widgets or screens.

Avoid this outside `lib/config/theme/`:

```dart
Color(0xFF...)
Colors.white
LinearGradient(...)
RadialGradient(...)
```

Use the theme accessors from `app_theme_tokens.dart` instead. If a color or gradient does not exist yet, add it to the theme tokens first.

## Imports

Most UI files should only need this import for theme values:

```dart
import 'package:floww/config/theme/app_theme_tokens.dart';
```

## Text Styles

Typography is mode-independent and is already mapped into Flutter's `TextTheme`.

```dart
Text(
  'Welcome Back',
  style: context.textTheme.displayLarge,
)
```

Use `AppTypography` directly only when you need a precise typography token that is not mapped to `TextTheme`.

## Colors

Use `context.scheme` for standard Material colors. These are the best choice for buttons, icons, text on primary backgrounds, errors, outlines, and normal surfaces.

```dart
Container(
  color: context.scheme.surface,
  child: Text(
    'Continue',
    style: context.textTheme.labelLarge?.copyWith(
      color: context.scheme.onSurface,
    ),
  ),
)
```

Use `context.colors` for Floww-specific color tokens and shared app tokens.

```dart
Container(
  color: context.colors.backgroundSurface,
  decoration: BoxDecoration(
    border: Border.all(color: context.colors.borderMedium),
  ),
  child: Icon(Icons.check, color: context.colors.primary),
)
```

Current useful color paths:

```dart
context.scheme.primary
context.scheme.onPrimary
context.scheme.surface
context.scheme.onSurface
context.scheme.error
context.scheme.outline

context.colors.primary
context.colors.primaryDeep
context.colors.primaryAlt
context.colors.tint
context.colors.tintStrong
context.colors.borderGlow
context.colors.bgTinted
context.colors.bgWarm
context.colors.backgroundPrimary
context.colors.backgroundSurface
context.colors.backgroundElevated
context.colors.textPrimary
context.colors.textSecondary
context.colors.borderSubtle
context.colors.borderMedium
context.colors.destructive
context.colors.destructiveBorder
context.colors.glassSurface
```

## Gradients

Use `context.gradients` for all mode-specific gradients.

```dart
Container(
  decoration: BoxDecoration(
    gradient: context.gradients.primary,
    borderRadius: BorderRadius.circular(16),
  ),
)
```

Current gradient paths:

```dart
context.gradients.primary
context.gradients.bright
context.gradients.ramp
context.gradients.full
context.gradients.darkGlow
context.gradients.reversed
context.gradients.amber
context.gradients.subtle
context.gradients.orange
context.gradients.glowRadial
```

## Adding New Colors Or Gradients

1. Add the token to `AppColorTokens` or `AppGradientTokens`.
2. Add values for Flow, Steady, and Restore.
3. Add the token to `copyWith` and `lerp`.
4. Use it through `context.colors` or `context.gradients`.

Shared primitive colors live privately inside `app_theme_tokens.dart`. New widgets should not create their own palette classes or import raw color constants.

## Switching Modes

Theme mode is controlled globally by `ThemeModeController` and persisted with `shared_preferences`.

```dart
import 'package:floww/config/theme/app_theme.dart';
import 'package:floww/config/theme/theme_controller.dart';

context.read<ThemeModeController>().setMode(AppThemeMode.steady);
```

When the mode changes, widgets using `context.scheme`, `context.colors`, or `context.gradients` rebuild with the selected mode automatically.

## Component Checklist

- Use `context.textTheme` for text styles.
- Use `context.scheme` for standard Material colors.
- Use `context.colors` for Floww-specific and shared app colors.
- Use `context.gradients` for gradients.
- Use `app_theme_tokens.dart` as the single token/accessor import in UI files.
- Do not create raw `Color(...)`, `LinearGradient(...)`, or `RadialGradient(...)` values in screens/components.
