import 'dart:ui' as ui;

import 'package:floww/config/constants/app_images.dart';
import 'package:floww/config/constants/app_spacing.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';
import 'package:floww/core/auth/widgets/animated_reverse_ripple.dart';
import 'package:floww/navigation/app_router.dart';
import 'package:floww/navigation/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MeetWavesView extends StatefulWidget {
  const MeetWavesView({super.key});

  @override
  State<MeetWavesView> createState() => _MeetWavesViewState();
}

class _MeetWavesViewState extends State<MeetWavesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: _MeetWavesBackground()),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.xl,
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppImages.sparkel),
                                Text(
                                  "Floww",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'PlusJakartaSans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: AnimatedReverseRipple(
                                  duration: Duration(milliseconds: 5000),
                                  isInward: false,
                                  ringCount: 5,
                                  rippleColor: AppColorTokens.flow.primary,
                                  minRadius: 30.0,
                                  maxRadius: 200.0,
                                  strokeWidth: 0.5,
                                  child: SvgPicture.asset(AppImages.waveIcon),
                                ),
                              ),
                            ),
                            Spacer(),

                            Text(
                              "Powered by AI",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white30,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.15,
                              ),
                            ),
                            SizedBox(height: AppSpacing.xl),

                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Meet WAVE",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: ".",
                                      style: TextStyle(
                                        color: AppColorTokens.flow.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                style: const TextStyle(
                                  fontSize: 58,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'PlusJakartaSans',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ),
                            SizedBox(height: AppSpacing.xl),

                            Text(
                              "A new kind of AI fitness coach — built around how you actually feel, every single day.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white30,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.15,
                              ),
                            ),
                            SizedBox(height: 68),
                            GestureDetector(
                              onTap: () {
                                NavigationService.instance.push(
                                  AppRouter.welcomeToFlowView,
                                );
                              },
                              child: Container(
                                height: 68,
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSpacing.xl,
                                  horizontal: AppSpacing.xl4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 4,
                                    children: [
                                      Text(
                                        "Get Started",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'PlusJakartaSans',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      Icon(Icons.arrow_forward, size: 30),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MeetWavesBackground extends StatelessWidget {
  const _MeetWavesBackground();

  static const double designWidth = 375.0;
  static const double designHeight = 812.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          child: const SizedBox(
            width: designWidth,
            height: designHeight,
            child: _MeetWavesDesign(),
          ),
        );
      },
    );
  }
}

class _MeetWavesDesign extends StatelessWidget {
  const _MeetWavesDesign();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppGradientTokens.defaultBackground,
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.20,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0, -1.0),
                  end: Alignment(-0.0026667, 0.0),
                  colors: [Color(0xFFC3FF3D), Color(0xFF13100B)],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          left: -49,
          top: 621,
          width: 473,
          height: 204,
          child: _BottomGlow(),
        ),
      ],
    );
  }
}

class _BottomGlow extends StatelessWidget {
  const _BottomGlow();

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(
        sigmaX: 60,
        sigmaY: 60,
        tileMode: TileMode.decal,
      ),
      child: CustomPaint(
        size: const Size(473, 204),
        painter: _BottomGlowPainter(),
      ),
    );
  }
}

class _BottomGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(0, 183.239)
      ..cubicTo(0, 165.776, 105.8846, 120, 236.5, 120)
      ..cubicTo(367.115, 120, 473, 165.776, 473, 183.239)
      ..cubicTo(473, 200.702, 367.115, 183.239, 236.5, 183.239)
      ..cubicTo(105.8846, 183.239, 0, 200.702, 0, 183.239)
      ..close();

    final Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(236.5, 151.619),
        const Offset(236.5, 120),
        const [Color(0xFFA9F500), Color(0xFF556B1E)],
        const [0.0, 1.0],
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
