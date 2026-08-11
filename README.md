# floww

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



## Strict Coding Rules every time to follow

- Follow current coding style 
- Dont ever try to write comments in any conditions, so writing comments is strickly pohibited
- No hardcoded values until only screen specific or components specific and not available in config — colors, spacing, dimensions, font sizes, radii, etc. Always pull from `config/constants` or `config/themes`.
- Use EdgeInsets.symmetric instead of EdgeInsets.fromLTRB or others until its important at all places.
- No hardcoded images — any image asset a screen needs must first be added to `assets/images/` (or `assets/icons/` for icon assets), then declared as a named constant in `AppImages` (`lib/config/constants/app_images.dart`), and only then referenced from that constant in a View/widget. Never reference an asset path string directly in a View.
- No inline `TextStyle` — every text (only until its screen or component specific) widget uses the global text theme (`app_text_theme.dart`).
- Reuse before creating — check `config/widgets` and the feature's own `widgets/` folder before building something new.
- Shared widgets (buttons, text fields, cards, loaders, dialogs used across features) go in `config/widgets`; single-feature widgets go in `core/<feature>/widgets/`.
- No duplicate UI — if the same element appears in two or more places, extract it into a reusable widget.
- No UI built inline inside variables — extract non-trivial widget trees into proper widget classes.
- Never rebuild native system UI — no custom status bar, home indicator, or gesture area; that's the OS's responsibility.
- Strict MVVM — Views render UI only, ViewModels own logic and state, Services own data/IO. No business logic in Views.
- All features live under `core/<feature>/{services,view_models,views,widgets}`; new features follow this structure automatically.
- Pixel-perfect UI — the provided images of design is the source of truth for spacing, color, typography, sizing, alignment, shadows, and layout.
- Every color, gradient, and text style must be pulled from the app theme system (`Theme.of(context)` + custom `ThemeExtension`s). Never hardcode raw `Color(0x...)` / `LinearGradient(...)` values inside a screen, widget, or component. If a value isn't in the token set, add it to the token set — don't inline it.
- Extract design tokens (colors, spacing, typography, radius, dimensions, shadows) into constants/themes instead of hardcoding them in widgets.
- Keep code modular, readable, and small — prefer composition over duplication.
- Consistent naming across files, classes, methods, and widgets.
- Prefer `const` constructors/widgets wherever possible.
- No new packages or architectural patterns without approval — reuse the existing stack and conventions.
- Please update README.md file each time after any feature updations and max size of CLAUDE.md should be 160 lines