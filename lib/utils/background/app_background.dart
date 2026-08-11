import 'dart:ui';
import 'package:flutter/material.dart';

enum AppBackgroundMode { defaultMode, flow, steady, restore }

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.mode = AppBackgroundMode.defaultMode,
    this.isInner = false,
    this.safeAreaTop = true,
  });

  final Widget child;
  final AppBackgroundMode mode;
  final bool isInner;
  final bool safeAreaTop;

  @override
  Widget build(BuildContext context) {
    if (mode == AppBackgroundMode.defaultMode) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF14110B), Color(0xFF0A0A0A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          top: safeAreaTop,
          bottom: false,
          left: false,
          right: false,
          child: child,
        ),
      );
    }

    LinearGradient coloredOrbGradient;
    Color darkOrbColor;

    switch (mode) {
      case AppBackgroundMode.flow:
        coloredOrbGradient = const LinearGradient(
          colors: [Color(0xFFC3FF3D), Color(0xFFA9F500)],
        );
        darkOrbColor = const Color(0xFF1F2218);
        break;
      case AppBackgroundMode.steady:
        coloredOrbGradient = const LinearGradient(
          colors: [Color(0xFFF97316), Color(0xFFF59E0B)],
        );
        darkOrbColor = const Color(0xFF221C18);
        break;
      case AppBackgroundMode.restore:
        coloredOrbGradient = const LinearGradient(
          colors: [Color(0xFF28D5E6), Color(0xFF00C4D5)],
        );
        darkOrbColor = const Color(0xFF182122);
        break;
      default:
        coloredOrbGradient = const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
        );
        darkOrbColor = const Color(0xFF000000);
    }

    final List<Widget> backgroundElements = [];

    backgroundElements.add(Container(color: const Color(0xFF0A0A0A)));

    if (!isInner) {
      backgroundElements.add(
        Positioned(
          left: -49.0,
          top: -173.0,
          child: _buildOrb(
            width: 473.0,
            height: 503.0,
            blur: 90.0,
            gradient: coloredOrbGradient,
          ),
        ),
      );

      backgroundElements.add(
        Positioned(
          left: -34.0,
          top: 106.0,
          child: _buildOrb(
            width: 443.0,
            height: 210.0,
            blur: 90.0,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      );
    } else {
      backgroundElements.add(
        Positioned(
          left: 0.0,
          top: 0.0,
          child: _buildOrb(
            width: 375.0,
            height: 812.0,
            blur: 90.0,
            color: darkOrbColor,
          ),
        ),
      );

      backgroundElements.add(
        Positioned(
          left: 0.0,
          top: 0.0,
          child: _buildOrb(
            width: 375.0,
            height: 812.0,
            blur: 90.0,
            color: const Color(0x1AFFFFFF), 
          ),
        ),
      );

      backgroundElements.add(
        Positioned(
          left: -34.0,
          top: 106.0,
          child: _buildOrb(
            width: 443.0,
            height: 210.0,
            blur: 90.0,
            color: darkOrbColor,
          ),
        ),
      );

      backgroundElements.add(
        Positioned(
          left: -49.0,
          top: -303.0,
          child: _buildOrb(
            width: 473.0,
            height: 503.0,
            blur: 90.0,
            gradient: coloredOrbGradient,
          ),
        ),
      );

      backgroundElements.add(
        Positioned(
          left: 0.0,
          top: 766.0,
          child: _buildOrb(
            width: 375.0,
            height: 46.0,
            blur: 100.0,
            gradient: coloredOrbGradient,
          ),
        ),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: RepaintBoundary(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: 375.0,
                height: 812.0,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: backgroundElements,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            top: safeAreaTop,
            bottom: false,
            left: false,
            right: false,
            child: child,
          ),
        ),
      ],
    );
  }

  Widget _buildOrb({
    required double width,
    required double height,
    required double blur,
    Color? color,
    LinearGradient? gradient,
  }) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.all(Radius.elliptical(width, height)),
        ),
      ),
    );
  }
}
