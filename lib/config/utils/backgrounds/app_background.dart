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

    String imagePath;
    switch (mode) {
      case AppBackgroundMode.flow:
        imagePath = isInner
            ? 'assets/images/floww_inner.png'
            : 'assets/images/floww_main.png';
        break;
      case AppBackgroundMode.steady:
        imagePath = isInner
            ? 'assets/images/steady_inner.png'
            : 'assets/images/steady_main.png';
        break;
      case AppBackgroundMode.restore:
        imagePath = isInner
            ? 'assets/images/restore_inner.png'
            : 'assets/images/restore_main.png';
        break;
      default:
        imagePath = 'assets/images/floww_main.png';
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
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
}
