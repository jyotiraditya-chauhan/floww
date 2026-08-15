# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Floww — a Flutter fitness/coaching app ("WAVE", an AI fitness coach). Dark-themed, mobile-first, with three visual modes (`flow`/lime, `steady`/orange, `restore`/cyan) selectable at runtime.

## Commands

```bash
flutter pub get                 # install dependencies
flutter run                     # run on connected device/simulator
flutter analyze                 # static analysis (flutter_lints)
flutter test                    # run all tests
flutter test test/widget_test.dart   # run a single test file
flutter test --plain-name "app renders with the selected visual mode"  # run a single test by name
```

No CI config, no custom lint rules beyond the default `flutter_lints/flutter.yaml` — see `analysis_options.yaml`.

## Architecture

**Strict MVVM.** Views render UI only; ViewModels/Providers own logic and state; Services own data/IO. No business logic in Views (note: some existing screens, e.g. `meet_waves_view.dart`, predate this and inline styles/logic — don't copy that pattern into new code).

**Feature module layout** — every feature lives under `lib/core/<feature>/`:
```
core/<feature>/
  services/       # data/IO
  view_models/ or providers/   # state, ChangeNotifier-based
  views/          # screens (StatelessWidget/StatefulWidget, UI only)
  widgets/        # widgets local to this feature only
```
Existing features: `core/auth` (splash, welcome, meet-waves onboarding-intro screens), `core/onboarding` (dynamic multi-phase questionnaire), `core/home` (in progress).

**Shared code** lives under `lib/config/`:
- `config/constants/` — `AppSizes`, `AppSpacing`, `AppRadius`, `AppImages` (asset path constants — never reference an asset path string directly in a View)
- `config/theme/` — `AppTheme` (builds `ThemeData` per `AppThemeMode`), `AppColorTokens`/`AppGradientTokens` (`ThemeExtension`s holding all colors/gradients per mode), `app_theme_tokens.dart` also defines the `context.colors` / `context.gradients` / `context.scheme` / `context.textTheme` `BuildContext` extension — use these instead of `Theme.of(context)` directly. `AppTypography` holds the raw text styles wired into `ThemeData.textTheme`.
- `config/widgets/` — shared widgets used across 2+ features (buttons, text fields, headers, animations). Feature-specific widgets go in `core/<feature>/widgets/` instead.
- `config/utils/` — e.g. shared background painters.

**Navigation**: simple named-route system, not a router package. `lib/navigation/app_router.dart` declares route name constants (`AppRouter`); `lib/navigation/router_config.dart` (`AppRouterConfig.generateRoute`) maps names to `MaterialPageRoute`s via a switch; `lib/navigation/services/navigation_service.dart` (`NavigationService.instance`) wraps a global `navigatorKey` so navigation can be triggered outside the widget tree (`.push`, `.pushReplacement`, `.pop`). Adding a screen means: add the route constant, add the case in `generateRoute`, create the view under the feature's `views/`.

**Theming**: `AppThemeMode` (`flow`/`steady`/`restore`) is chosen once and drives both `AppColorTokens` and `AppGradientTokens`, injected into `ThemeData.extensions`. The active mode is a `ChangeNotifierProvider<ThemeModeController>` (`config/theme/theme_controller.dart`) at the app root, persisted to `SharedPreferences` under key `app_theme_mode`, read back in `main.dart` before `runApp`.

**Onboarding flow** (`core/onboarding/`) is dynamic and phase-based, not a fixed page count:
- `OnboardingProvider` (ChangeNotifier) tracks `_currentPhaseIndex`/`_currentQuestionIndex` and an answers map.
- `activePhases` is a *computed* getter: it always includes `OnboardingData.corePhases`, then conditionally injects one specialized phase (`gymPhase`/`calisthenicsPhase`/`yogaPhase`) based on the `training_type` answer, then appends `OnboardingData.finalPhases`. This makes the flow branch by answer without any special-casing in the view.
- Global progress and page-controller navigation flatten `(phaseIndex, questionIndex)` into one continuous index across all currently-active phases — see `_animateToCurrentPage` in `onboarding_provider.dart` for the exact math before touching phase ordering.
- `canContinue` validates the current question's answer per `InputType` to gate the Continue button.

## Coding rules (strict — enforced by convention, not lint)

- **No comments** in code, under any circumstance.
- **No hardcoded design values** — colors, spacing, radii, font sizes, dimensions must come from `config/constants` or `config/theme` (`context.colors`, `context.gradients`, theme text styles). If a needed value doesn't exist yet, add it to the token set rather than inlining it. Only screen/component-truly-specific one-off values are exempt.
- **No raw `Color(0x...)` / `LinearGradient(...)`** in a screen or widget — pull from `AppColorTokens`/`AppGradientTokens` via `context.colors`/`context.gradients`.
- **No inline `TextStyle`** — use the global text theme (`context.textTheme`, styles from `app_typography.dart`), except for truly screen/component-specific text.
- Use `EdgeInsets.symmetric` over `EdgeInsets.fromLTRB`/other constructors unless a asymmetric case is genuinely required.
- **No hardcoded image paths** — add the asset under `assets/images/` or `assets/icons/`, declare it in `AppImages` (`lib/config/constants/app_images.dart`), reference only the constant.
- **Reuse before creating** — check `config/widgets` and the feature's own `widgets/` folder before building a new widget. Duplicate UI must be extracted into a reusable widget.
- No non-trivial widget trees built inline inside variables/methods — extract to a proper widget class.
- Never rebuild native system UI (status bar, home indicator, gesture area).
- Prefer `const` constructors wherever possible.
- No new packages or architectural patterns without approval — reuse the existing stack (`provider` for state, `shared_preferences` for persistence, `flutter_svg` for SVG assets).
- Pixel-perfect UI — when a design/image is provided it is the source of truth for spacing, color, typography, sizing, alignment, shadows, layout.
- Update `README.md` after any feature change.

## Design tokens reference

- `AppSpacing` (`config/constants/app_spacing.dart`): `xxs`(2) `xs`(4) `sm`(6) `md`(8) `lg`(12) `xl`(16) `xl2`(20) `xl3`(24) `xl4`(32) `xl5`(40)
- `AppSizes`/`AppRadius` (`config/constants/app_sizes.dart`): `AppSizes.s2`..`s96` (step scale), `AppRadius.xs/sm/md/lg/xl/xl2/xl3/full`
- Fonts: `HankenGrotesk` (theme default) and `PlusJakartaSans` (used for display/hero text in auth screens), both loaded as variable fonts with italic variants.

A fuller Figma-extracted palette/typography/spacing reference (with usage notes and caveats about partial extraction) lives in `.claude/design-system/DESIGN_SYSTEM.md` — treat it as background reference, not a source of truth over the actual token files above.
