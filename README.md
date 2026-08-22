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

## Feature Notes

- The "Meet WAVE" intro and "Three Modes" onboarding-intro screens are merged into a single view (`lib/core/auth/views/meet_waves_view.dart`). Tapping "Get Started" plays a custom staggered scale + fade transition (`lib/core/auth/widgets/step_reveal_item.dart`) between the two steps instead of navigating to a second route; the header back arrow reverses it. The old `welcomeToFlowView` route and `WelcomeToFlowView` screen were removed since nothing else referenced them.
- Added an "Account Setup" screen (`lib/core/auth/views/auth_view.dart`, route `AppRouter.accountSetup`) between the mode showcase and onboarding. "Skip for Now" still just proceeds to onboarding as a guest. Google and Apple (iOS only, via `Platform.isIOS`) sign-in are now real: `AuthService` (`lib/core/auth/services/auth_service.dart`) signs in through `firebase_auth` (Google via `google_sign_in` v7's `GoogleSignIn.instance`/`.authenticate()`, Apple via `sign_in_with_apple` with a SHA-256-hashed nonce), then reads/creates a `users/{uid}` Cloud Firestore doc to tell new vs. existing users apart and persist the `UserModel`. `AuthViewModel` (`lib/core/auth/view_models/auth_view_model.dart`) exposes per-provider loading flags and an error message, driving `CustomButton`/`CustomOutlinedButton`'s built-in loading/disabled state; a failure shows inline error text above the buttons. On success, the view routes via `AppRouter.routeAfterAuth(user)` — onboarding questions, Connect Wearables, or Home depending on `UserModel.onboardingCompleted`/`answersSubmitted` (see below) — using a new `NavigationService.pushAndRemoveUntil` (clears the back stack). `SplashView` now checks for an existing session the same way before deciding where to land. Notification permission (`FirebaseMessaging.instance.requestPermission`) is requested once `AuthView` loads, and the FCM token is registered into the user's Firestore doc after a successful sign-in. `CustomButton`/`CustomOutlinedButton` gained optional `leading`/`foregroundColor` params to support this screen's icon buttons.
- Built the Home screen (`lib/core/home/views/home_view.dart`, `HomeProvider` in `core/home/providers/`, section widgets in `core/home/widgets/`): Flow Score, Today's Habit, Today's Workout, Nutrition Summary, Apple Health Sync, Today's Progress, and Muscle Recovery cards, plus a conditional "How to Increase Your Flow Score" card (shown only at 0% flow score) and a Wave Insight banner (shown only when present). Ships with populated sample data by default, but every card's empty-state branch is driven by real (currently zero/empty) values, not dead code.
- Added `MuscleRecoveryCard` (`lib/core/home/widgets/muscle_recovery_card.dart`), shown below Today's Progress: front/back anatomical diagrams (`AppImages.muscleFront`/`muscleBack`, rendered as-is via `SvgPicture` — the highlighted-muscle coloring is baked into the SVGs themselves, not applied at runtime) plus a 2×2 stat grid (days since last workout, in recovery, ready muscles, fatigued muscles). Fixed `AppImages.muscleFront`/`muscleBack`, which previously pointed at `assets/icons/` (a non-existent path for these files) — added `AppImages._imagesBase` and repointed them at `assets/images/`, where the files actually live.
- Added the app shell (`lib/navigation/views/main_tab_view.dart`): a floating bottom tab bar over an `IndexedStack` of 5 tabs (Home, Nutrition, Activity, Plans, Stats). `AppBottomNavBar` (`lib/navigation/widgets/app_bottom_nav_bar.dart`) renders the 5 tabs as a pill with a circular selection indicator that slides between tabs via `AnimatedAlign`, plus a per-icon color crossfade. `WaveOrbButton` (`lib/navigation/widgets/wave_orb_button.dart`) is a press-animated stub for the floating WAVE AI orb — `onTap` is currently a no-op placeholder; wiring it to a real voice/AI screen is a follow-up. Nutrition/Activity/Plans/Stats currently render a shared `FeaturePlaceholderView` (`lib/config/widgets/placeholders/feature_placeholder_view.dart`) with a "Coming soon" message until those features are built. `AppRouter.home` now routes to `MainTabView` instead of `HomeView` directly.
- Onboarding now actually submits: `OnboardingDetailsEntity` (`lib/config/entities/onboarding_details_entity.dart`, previously unused) is built from the answers map and written to a new `onboarding_details/{uid}` Cloud Firestore collection (`AppCollection.onboardingDetails`) by the new `OnboardingService` (`lib/core/onboarding/services/onboarding_service.dart`), branching into exactly one of the gym/calisthenics/yoga detail blocks based on the selected training type. `OnboardingProvider.nextQuestion` is now async: completing the last question (`summary_screen`) submits the answers, sets `UserModel.answersSubmitted = true`, and — on success — `OnboardingQuestionView` navigates to a new `ConnectWearablesView` (`lib/core/onboarding/views/connect_wearables_view.dart`, route `AppRouter.connectWearables`). "Connect wearables" was removed from the question data entirely (was `apple_health` in `phase_5`) so it's a genuine final step outside the questionnaire; `HealthIntegrationWidget` was decoupled from `OnboardingProvider` (now takes `isConnected`/`onToggle`) so it's reusable standalone there. Finishing that screen sets `UserModel.onboardingCompleted = true` and goes to Home. `AppRouter.routeAfterAuth(user)` is the single place `SplashView`/`AuthView` use to decide between onboarding questions, Connect Wearables, and Home based on those two flags — so closing the app between submission and finishing the wearables step resumes exactly there instead of replaying the questionnaire.
- Added `HapticManager` (`lib/config/utils/haptics/haptic_manager.dart`), a static wrapper around the `haptic_feedback` package. Call `HapticManager.success()/.warning()/.error()/.light()/.medium()/.heavy()/.rigid()/.soft()/.selection()` from anywhere — each checks (and caches) `Haptics.canVibrate()` first and no-ops silently on unsupported platforms/devices. Not yet wired into any interaction; hook it into buttons/taps as needed.

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
- Please update README.md file each time after any feature updations and max size of CLAUDE.md should be 160 lines, add in README to follow