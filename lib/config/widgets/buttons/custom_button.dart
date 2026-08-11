import 'package:flutter/material.dart';
import 'package:floww/config/theme/app_theme_tokens.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final double? width;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _pressed = false;

  bool get _isEnabled =>
      widget.onPressed != null && !widget.isLoading && !widget.isDisabled;

  void _setPressed(bool value) {
    if (_isEnabled && value != _pressed) {
      setState(() => _pressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double targetOpacity = !_isEnabled
        ? 0.5
        : _pressed
        ? 0.85
        : 1.0;

    final double targetScale = _pressed ? 0.98 : 1.0;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: _isEnabled ? widget.onPressed : null,
      child: AnimatedOpacity(
        opacity: targetOpacity,
        duration: const Duration(milliseconds: 120),
        child: AnimatedScale(
          scale: targetScale,
          duration: const Duration(milliseconds: 120),
          child: Container(
            height: 55,
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.gradients.primary.colors[0],
                  context.gradients.primary.colors[0],
                  context.gradients.primary.colors[1],
                ],
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                stops: [0.0, 0.5, 0.9],
              ),
              borderRadius: BorderRadius.circular(27.5),
              border: Border.all(
                color: context.scheme.onPrimary.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.scheme.onPrimary,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: context.scheme.onPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          widget.text,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.scheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
