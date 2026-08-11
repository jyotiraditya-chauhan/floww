import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';

/// Which mode background renders behind [AppBackground.child].
enum AppBackgroundMode { defaultMode, flow, steady, restore }

/// Full-bleed, theme-token-driven app background.
///
/// Geometry is extracted 1:1 from the design SVGs (flow_main.svg,
/// flow_inner.svg, 375x812 canvas) and stored as fractions of that canvas,
/// so it scales cleanly to any screen size. Colors come entirely from
/// [AppColorTokens] / [AppGradientTokens] -- nothing here hardcodes a
/// mode-specific hex.
///
/// ```dart
/// AppBackground(child: Home())                                       // default
/// AppBackground(mode: AppBackgroundMode.flow, child: FlowHome())      // flow, main
/// AppBackground(mode: AppBackgroundMode.flow, isInner: true, child: FlowSession()) // flow, inner
/// ```
class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.mode = AppBackgroundMode.defaultMode,
    this.isInner = false,
  });

  final Widget child;
  final AppBackgroundMode mode;
  final bool isInner;

  @override
  Widget build(BuildContext context) {
    final colorTokens = context.colors;
    final gradientTokens = context.gradients;

    final resolved = _resolve(mode, isInner, colorTokens, gradientTokens);

    return Stack(
      fit: StackFit.expand,
      children: [
        RepaintBoundary(
          child: _BackgroundCanvas(
            baseTop: const Color(0xFF14110B),
            baseBottom: colorTokens.backgroundPrimary,
            layers: resolved.layers,
            signature: resolved.signature,
          ),
        ),
        child,
      ],
    );
  }

  ({List<_GlowLayer> layers, int signature}) _resolve(
    AppBackgroundMode mode,
    bool isInner,
    AppColorTokens colorTokens,
    AppGradientTokens gradientTokens,
  ) {
    if (mode == AppBackgroundMode.defaultMode) {
      return (layers: const [], signature: Object.hash(mode, isInner));
    }

    final AppColorTokens modeColors;
    final AppGradientTokens modeGradients;
    switch (mode) {
      case AppBackgroundMode.flow:
        modeColors = AppColorTokens.flow;
        modeGradients = AppGradientTokens.flow;
        break;
      case AppBackgroundMode.steady:
        modeColors = AppColorTokens.steady;
        modeGradients = AppGradientTokens.steady;
        break;
      case AppBackgroundMode.restore:
        modeColors = AppColorTokens.restore;
        modeGradients = AppGradientTokens.restore;
        break;
      case AppBackgroundMode.defaultMode:
        return (layers: const [], signature: Object.hash(mode, isInner));
    }

    final primary = modeGradients.primary as LinearGradient;
    final haloTop = primary.colors.first;
    final haloBottom = primary.colors.last;
    // Verify this equals your mode's near-black deep tint (see checklist
    // below the class). If bgTinted is actually a lighter "card surface"
    // token elsewhere in the system, that's the wrong token for this.
    final deepTint = modeColors.bgTinted;

    final layers = isInner
        ? _innerLayers(
            haloTop: haloTop,
            haloBottom: haloBottom,
            deepTint: deepTint,
          )
        : _mainLayers(haloTop: haloTop, haloBottom: haloBottom);

    final signature = Object.hash(
      mode,
      isInner,
      haloTop.toARGB32(),
      haloBottom.toARGB32(),
      deepTint.toARGB32(),
    );

    return (layers: layers, signature: signature);
  }
}

// ---------------------------------------------------------------------------
// Geometry -- extracted from flow_main.svg / flow_inner.svg, as fractions of
// the 375x812 design canvas. Identical across all 3 modes, only fill colors
// differ (confirmed against main_background_theme.svg / inner_background_theme.svg).
// ---------------------------------------------------------------------------

const Offset _kHaloCenter = Offset(0.5, 0.0967);
const Offset _kHaloRadius = Offset(0.6307, 0.3097);

const Offset _kHighlightCenter = Offset(0.5, 0.2599);
const Offset _kHighlightRadius = Offset(0.5907, 0.1293);

const Offset _kInnerTopHaloCenter = Offset(0.5, -0.0634);
const Offset _kInnerBottomGlowCenter = Offset(0.5, 0.9717);
const Offset _kInnerBottomGlowRadius = Offset(0.5, 0.0283);

const Offset _kFullTintCenter = Offset(0.5, 0.5);
const Offset _kFullTintRadius = Offset(0.5, 0.5);

const double _kBlurSigma = 0.24; // 90px / 375
const double _kBottomGlowBlurSigma = 0.2667; // 100px / 375

List<_GlowLayer> _mainLayers({
  required Color haloTop,
  required Color haloBottom,
}) => [
  _GlowLayer(
    centerFraction: _kHaloCenter,
    radiusFraction: _kHaloRadius,
    blurSigmaFraction: _kBlurSigma,
    colors: [haloTop, haloBottom],
  ),
  _GlowLayer(
    centerFraction: _kHighlightCenter,
    radiusFraction: _kHighlightRadius,
    blurSigmaFraction: _kBlurSigma,
    colors: const [Colors.white], // pure lighting effect, not a brand token
  ),
];

List<_GlowLayer> _innerLayers({
  required Color haloTop,
  required Color haloBottom,
  required Color deepTint,
}) {
  // SVG blurs deepTint + 10%-white as one composited group over identical
  // geometry. Same result as pre-blending the color once, one fewer draw.
  final tintWithWash = Color.alphaBlend(
    Colors.white.withValues(alpha: 0.1),
    deepTint,
  );

  return [
    _GlowLayer(
      centerFraction: _kInnerBottomGlowCenter,
      radiusFraction: _kInnerBottomGlowRadius,
      blurSigmaFraction: _kBottomGlowBlurSigma,
      colors: [haloTop, haloBottom],
    ),
    _GlowLayer(
      centerFraction: _kInnerTopHaloCenter,
      radiusFraction: _kHaloRadius,
      blurSigmaFraction: _kBlurSigma,
      colors: [haloTop, haloBottom],
    ),
    _GlowLayer(
      centerFraction: _kFullTintCenter,
      radiusFraction: _kFullTintRadius,
      blurSigmaFraction: _kBlurSigma,
      colors: [tintWithWash],
    ),
    _GlowLayer(
      centerFraction: _kHighlightCenter,
      radiusFraction: _kHighlightRadius,
      blurSigmaFraction: _kBlurSigma,
      colors: [deepTint], // same spot main's white highlight sits, inverted
    ),
  ];
}

// ---------------------------------------------------------------------------
// Rendering
// ---------------------------------------------------------------------------

@immutable
class _GlowLayer {
  const _GlowLayer({
    required this.centerFraction,
    required this.radiusFraction,
    required this.blurSigmaFraction,
    required this.colors,
  });

  /// (dx, dy) as a fraction of canvas size, top-left origin. Values outside
  /// 0..1 are valid, several source ellipses sit partially off-canvas.
  final Offset centerFraction;

  /// (rx, ry) as a fraction of canvas size.
  final Offset radiusFraction;

  /// Blur sigma as a fraction of canvas width.
  final double blurSigmaFraction;

  /// Length 1 = solid fill. Length 2 = halo gradient: solid [colors.first]
  /// for the top half of the ellipse, blending to [colors.last] by the
  /// bottom edge (matches the source SVGs' gradientUnits span).
  final List<Color> colors;
}

class _BackgroundCanvas extends StatelessWidget {
  const _BackgroundCanvas({
    required this.baseTop,
    required this.baseBottom,
    required this.layers,
    required this.signature,
  });

  final Color baseTop;
  final Color baseBottom;
  final List<_GlowLayer> layers;
  final int signature;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [baseTop, baseBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: layers.isEmpty
          ? null
          : ClipRect(
              child: CustomPaint(
                painter: _GlowPainter(layers: layers, signature: signature),
                size: Size.infinite,
              ),
            ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  const _GlowPainter({required this.layers, required this.signature});

  final List<_GlowLayer> layers;
  final int signature;

  @override
  void paint(Canvas canvas, Size size) {
    for (final layer in layers) {
      final center = Offset(
        layer.centerFraction.dx * size.width,
        layer.centerFraction.dy * size.height,
      );
      final radius = Offset(
        layer.radiusFraction.dx * size.width,
        layer.radiusFraction.dy * size.height,
      );
      final rect = Rect.fromCenter(
        center: center,
        width: radius.dx * 2,
        height: radius.dy * 2,
      );
      final sigma = layer.blurSigmaFraction * size.width;
      final paint = Paint()
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, sigma);

      if (layer.colors.length == 1) {
        paint.color = layer.colors.single;
      } else {
        paint.shader = ui.Gradient.linear(
          Offset(center.dx, rect.top),
          Offset(center.dx, rect.bottom),
          [layer.colors.first, layer.colors.first, layer.colors.last],
          const [0.0, 0.5, 1.0],
        );
      }

      canvas.drawOval(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GlowPainter oldDelegate) =>
      oldDelegate.signature != signature;
}

// import 'package:flutter/material.dart';
// import 'package:floww/config/theme/app_theme_tokens.dart';

// enum AppBackgroundMode { defaultMode, flow, steady, restore }

// class AppBackground extends StatelessWidget {
//   const AppBackground({
//     super.key,
//     required this.child,
//     this.mode = AppBackgroundMode.defaultMode,
//     this.isInner = false,
//   });

//   final Widget child;
//   final AppBackgroundMode mode;
//   final bool isInner;

//   @override
//   Widget build(BuildContext context) {
//     BoxDecoration decoration;

//     if (mode == AppBackgroundMode.defaultMode) {
//       decoration = BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color(0xFF14110B),
//             context.colors.backgroundPrimary,
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       );
//     } else {
//       AppColorTokens colorTokens;
//       AppGradientTokens gradientTokens;

//       switch (mode) {
//         case AppBackgroundMode.flow:
//           colorTokens = AppColorTokens.flow;
//           gradientTokens = AppGradientTokens.flow;
//           break;
//         case AppBackgroundMode.steady:
//           colorTokens = AppColorTokens.steady;
//           gradientTokens = AppGradientTokens.steady;
//           break;
//         case AppBackgroundMode.restore:
//           colorTokens = AppColorTokens.restore;
//           gradientTokens = AppGradientTokens.restore;
//           break;
//         default:
//           colorTokens = context.colors;
//           gradientTokens = context.gradients;
//       }

//       final primaryGradient = gradientTokens.primary as LinearGradient;
//       final Color topColor = primaryGradient.colors.first;
//       final Color bottomColor = primaryGradient.colors.last;

//       if (!isInner) {
//         // Main Screen Variant (Based closely on your example)
//         decoration = BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               topColor.withValues(alpha: 0.15),
//               colorTokens.bgTinted,
//               context.colors.backgroundPrimary,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: const [0.0, 0.5, 1.0],
//           ),
//         );
//       } else {
//         // Inner Screen Variant
//         decoration = BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               topColor.withValues(alpha: 0.15),
//               colorTokens.bgTinted,
//               bottomColor.withValues(alpha: 0.15),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: const [0.0, 0.5, 1.0],
//           ),
//         );
//       }
//     }

//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       decoration: decoration,
//       child: child,
//     );
//   }
// }
