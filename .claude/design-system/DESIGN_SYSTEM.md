# floww Design System — extracted from Figma

Source: `fileKey VmhbW21J1vTn9Ak6vdU4Kd`, page "Page 1" (single page, no separate style-guide page). Extracted via 6 `use_figma` calls in total (spent under an explicit budget constraint — see Extraction Notes). Node names throughout this file (Heart Rate Container, Flow Score, Wave Note Card, Apple Health Sync, Checkpoints) match the earlier "floww" FLOW Mode extraction almost exactly — this is the same design system, not a distinct one.

## Extraction notes (read before trusting a number below)

- **Colors — solids**: complete. 120 distinct solid fill/stroke colors, fully captured.
- **Colors — gradients**: **partial only**. 2 gradients fully captured; the true total is unknown (the response was truncated before finishing). Treat the gradient list here as a sample, not exhaustive.
- **Typography**: complete. 108 distinct family/weight/size/line-height/letter-spacing combinations.
- **Spacing**: complete. 48 distinct values.
- **Corner radius**: complete. 29 distinct values.
- **Effects/shadows**: complete. 39 distinct shadow/blur definitions.
- **Components**: this page has **zero** local `COMPONENT`/`COMPONENT_SET` definitions — every component usage found is an `INSTANCE` referencing a component defined in an external library file not covered by this extraction. There is no variant/component-properties table to document from this file. A representative sample of key instance/icon sizes was captured instead (see Key Sizes).

Role groupings below (background/text/brand/semantic/etc., and H1-H6/Body/Caption/Button) are **inferred** from each color's/style's usage context (sample node name, size ranking, fill-vs-stroke counts) — not values Figma itself labels. Where a classification is a judgment call, it's noted.

---

## Color Palette

### Backgrounds / Surfaces (dark neutral base)
| Hex | Sample usage |
|---|---|
| `#0a0a0a` | base app background |
| `#14110b` | elevated surface |
| `#181818` | elevated surface (also doubles as inverse/dark text on light fills) |
| `#1f1f1f` | elevated surface |
| `#191919`, `#1b1b1b` | elevated surface variants |
| `#2d2d2d` | elevated surface (cards) |
| `#221c18`, `#23221a` | warm-tinted surface (overlay, workout-related cards) |

### Tinted surfaces (mode-colored card backgrounds)
| Hex | Tint family |
|---|---|
| `#26361c`, `#1f2218`, `#18221b` | green tint (recovery/success cards) |
| `#182122` | cyan tint (info cards) |

### Text
| Hex/opacity | Role |
|---|---|
| `#ffffff` @ 100% | primary text/icons on dark |
| `#ffffff` @ 67%, 60%, 50%, 45%, 40%, 35%, 30%, 25%, 20%, 15%, 10%, 7%, 0.2% | secondary/tertiary text, dividers, scrims — full opacity ladder, reuse exactly, don't approximate to a nearby step |
| `#181818` | inverse text (on lime/light fills) |
| `#000000` | pure black (status bar glyphs only) |
| `#919191`, `#aaaaaa`, `#767676`, `#999999`, `#838072`, `#c0caae`, `#d4d4d4`, `#e0e0e0`, `#bdbdbd` | muted/disabled text & icon tones |

### Brand — lime (the app's signature accent)
| Hex | Note |
|---|---|
| `#c3ff3d` | primary brand color — also appears at opacities 7%, 8%, 9.4%, 12%, 20%, 24%, 26.7%, 30% for tints/strokes/fills — reuse the exact opacity, they are not interchangeable |
| `#a9f500`, `#baff1f`, `#93d500`, `#84b814`, `#659100` | darker lime shades — gradient stops / pressed-state variants |

### Semantic — Success / Recovery (green)
`#4ade80`, `#16a34a`, `#22e55b`, `#00d540`, `#00f076`, `#22c55e`

### Semantic — Info (cyan)
`#22cde6` (+ 8%/24% opacity variants), `#28d5e6`, `#00c4d5`, `#008591`

### Semantic — Warning / Energy (orange)
`#f59e0b` (+ 6.3%/24%/33% opacity), `#f97316` (+ 7%/8%/9.4%/12%/20%/26.7% opacity), `#fb923c`, `#ea580c`, `#d55900`, `#cc6216`

### Semantic — Danger (red)
`#f87171`, `#ef4444`, `#dc2626` (+ 40% opacity), `#fca5a5`, `#ff0000` (single icon-only use — verify before treating as a UI color)

### Category accents
Purple: `#8b5cf6`, `#8b5cff`, `#a855f7` — Blue: `#60a5fa`, `#2563eb`, `#141b34`

### Third-party brand marks (icons only — not part of the app's own palette)
`#4285f4` / `#34a853` / `#fbbc05` / `#ea4335` — Google "G" logo (Sign in with Google button). `#fc5200` — Strava-orange (integration icon).

### Light-mode outliers
`#e0ebe2`, `#e6e9ed`, `#ebe5e0`, `#e0eaeb` — light backgrounds seen only on "Card Button" instances; possibly a light-theme card variant. Worth confirming with design before treating as part of the core dark-theme palette.

### Gradients (partial — see Extraction Notes)
1. Linear, ~-90°, `#14110b → #0a0a0a` — used on "V7_Home (Full View)" background
2. Linear, ~-90°, `#c3ff3d → #a9f500` — used on "Ellipse 7473" (brand glow/orb)

---

## Typography

Two font families carry the whole system: **Plus Jakarta Sans** (headings, labels, UI copy) and **Hanken Grotesk** (stats/numbers/data). SF Pro / SF Compact appear only on native iOS chrome (status bar, system keypad) — not part of the app's own type ramp.

| Role | Family | Weight | Size | Line-height | Letter-spacing | Example |
|---|---|---|---|---|---|---|
| Display/Hero | Plus Jakarta Sans | Bold | 72px | 88px | -0.8px | "87" |
| Display/Hero | Plus Jakarta Sans | ExtraBold Italic | 48px | 58px | -0.4px | "Meet WAVE." |
| Display/Hero | Hanken Grotesk | Bold | 40px | 48px | -0.3px | "4.2" |
| H1 | Plus Jakarta Sans | SemiBold/Bold | 32px | 38px | -0.2px | "What should we call you?" |
| H1 | Hanken Grotesk | Black | 32px | 48px | 0 | "₹499" |
| H2 | Hanken Grotesk | ExtraBold | 30px | 30px | 0 | "74" (flow score) |
| H2 | Plus Jakarta Sans | SemiBold | 28px | 36px | -0.2px | "Delete Account?" |
| H2 | Plus Jakarta Sans / Hanken Grotesk | ExtraBold Italic / Bold | 24px | 30px | -0.15px | "Sarah Mitchell", "79" |
| H3 | Plus Jakarta Sans | SemiBold/Medium | 20px | 24px | 0 | "Get Started" |
| H4 | Plus Jakarta Sans | SemiBold | 18px | 28px | 0 | "Good morning," |
| Body | Plus Jakarta Sans / Hanken Grotesk | Medium/SemiBold/Bold/Regular | 16px | 22-24px | -0.18px | most card titles/values — the default body size |
| Body-Small | Plus Jakarta Sans / Hanken Grotesk | SemiBold/Regular/Bold | 14px | 20px | -0.16px | "Workout", "Slept 8h last night" |
| Caption | Plus Jakarta Sans / Hanken Grotesk | SemiBold/Regular/Medium/Bold | 12-13px | 16-19.5px | -0.12px | "Recovery is High", "Category Amount" |
| Label/Eyebrow | Plus Jakarta Sans / Hanken Grotesk | SemiBold/Medium/Regular | 9-10px | 10-15px | 0 | "RECOVERY", "FLOW SCORE", "+50 XP" |
| Button | Plus Jakarta Sans | SemiBold | 16-20px | 22-28px | 0 to -0.18px | primary CTAs |
| System (native) | SF Pro / SF Compact | Semibold/Regular/Medium | 13-25px | varies | varies | status bar, keypad — not app-authored |

Full 108-entry raw list (every distinct combination with exact line-height/letter-spacing/sample text) lives in `design-tokens.json` under `typography.raw`.

---

## Spacing Scale

Core 4px-grid values (highest-frequency): **0, 4, 8, 12, 16, 20, 24, 32, 40, 48px**.

Full deduplicated set with occurrence counts, sorted: 0, 1, 1.5, 2, 3, 4, 4.55, 5, 6, 6.06, 6.19, 6.67, 7, 7.67, 8, 9, 10, 11, 12, 13, 13.33, 14, 15, 16, 19, 20, 21, 23, 24, 26, 28, 31, 32, 34, 37, 39, 40, 48, 56, 60, 68, 70, 74, 80, 95, 120, 154, 341px. Non-4px-grid values are real, intentional one-offs from specific compositions — not noise; use the literal value if targeting a specific node.

## Corner Radius Scale

Core: **0, 4, 8, 12, 16, 20, 24, 32, 100, 999(pill)px**.

Full set: 0, 2.5, 3, 4, 4.3, 6, 8, 8.5, 10, 12, 14, 16, 20, 24, 26, 32, 40, 41, 42, 45, 66.5, 75, 75.76, 95, 100, 110, 157, 999px. (999 = 7,616 occurrences — the standard "fully rounded" pill value used throughout; the file does not exhibit the corrupted-sentinel radius bug seen in the earlier floww extraction.)

## Effects / Shadows

39 distinct definitions. Key ones:

| Type | Offset | Blur | Spread | Color | Alpha | Usage |
|---|---|---|---|---|---|---|
| Layer Blur | — | 180px | — | — | — | brand glow ellipse (large) |
| Layer Blur | — | 200px | — | — | — | brand glow ellipse (variant) |
| Inner Shadow | 0,4 | 4px | 0 | `#000000` | 25% | Heart Rate Container |
| Drop Shadow | 0,0 | 8px | 0 | `#4ae183` | 80% | success glow (Background+Shadow) |
| Drop Shadow | 0,4 | 6px | -4 | `#baff1f` | 10% | button shadow (lime, near) |
| Drop Shadow | 0,10 | 15px | -3 | `#baff1f` | 10% | button shadow (lime, far) |
| Inner Shadow | 0,0 | 8px | 0 | `#c3ff3d` | 40% | Wave Note Card inner glow |
| Background Blur | — | 12px | — | — | — | Home glass/blur backdrop |
| Inner Shadow | 0,0 | 8px | 0 | `#ffffff` | 20% | Frame 235 inner highlight |
| Inner Shadow | 0,0 | 4px | 0 | `#ffffff` | 12% | Chip Button inner highlight |

The same button-shadow / inner-glow pattern repeats per mode-accent color (lime, orange `#f97316`, cyan `#28d5e6`) — confirms a shared "Wave Note Card" / "Button:shadow" / "Floting Action Button" component pattern reused across the app's mode themes. Full 39-entry list in `design-tokens.json` under `effects.raw`.

## Components

No local component or component-set definitions exist on this page — every button/card/icon instance references a component from an external library file. Nothing to document here beyond usage; **do not** fabricate a variant table.

## Key Sizes (sampled, capped at 150 matches)

| Name | Type | Common sizes |
|---|---|---|
| Icons (generic instance) | INSTANCE | 12×12, 16×16, 20×20, 24×24 |
| Icon | FRAME | 8×6, 26×20 |
| Avatar / Image-40 | INSTANCE | 36×36 |
| Card Button | INSTANCE | 311×32 |
| Chip Button | INSTANCE | 69×26 to 95×26 (width varies with label) |
| Button | FRAME | 32×32 (icon button), 52×52 (large icon button) |
