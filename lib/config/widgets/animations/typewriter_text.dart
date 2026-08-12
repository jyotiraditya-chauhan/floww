import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Duration speed;
  final VoidCallback? onFinished;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.speed = const Duration(milliseconds: 15),
    this.onFinished,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _displayedCharacterCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(covariant TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _startTyping();
    }
  }

  void _startTyping() {
    _timer?.cancel();
    _displayedCharacterCount = 0;
    
    if (widget.text.isEmpty) {
      widget.onFinished?.call();
      return;
    }

    _timer = Timer.periodic(widget.speed, (timer) {
      if (_displayedCharacterCount < widget.text.length) {
        setState(() {
          _displayedCharacterCount++;
        });
      } else {
        _timer?.cancel();
        widget.onFinished?.call();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: widget.textAlign ?? TextAlign.start,
      text: TextSpan(
        style: widget.style,
        children: [
          TextSpan(
            text: widget.text.substring(0, _displayedCharacterCount),
          ),
          TextSpan(
            text: widget.text.substring(_displayedCharacterCount),
            style: const TextStyle(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
