import 'package:flutter/material.dart';

enum InputType {
  text,
  datePicker,
  timePicker,
  singleSelect,
  multiSelect,
  multiSelectPill,
  cardSelect,
  numberSlider,
  inlineSlider,
  yesNo,
  permission,
  loading,
  summary,
  multiQuestion,
}

class QuestionOption {
  final String title;
  final String? description;
  final IconData? icon;

  const QuestionOption({required this.title, this.description, this.icon});
}

class OnboardingQuestion {
  final String id;
  final String title;
  final String? subtitle;
  final InputType inputType;
  final List<QuestionOption>? options;
  final List<OnboardingQuestion>? subQuestions;

  // Specific for numberSlider inputs
  final double? min;
  final double? max;
  final String? suffixText;

  const OnboardingQuestion({
    required this.id,
    required this.title,
    this.subtitle,
    required this.inputType,
    this.options,
    this.subQuestions,
    this.min,
    this.max,
    this.suffixText,
  });
}

class OnboardingPhase {
  final String id;
  final String title;
  final List<OnboardingQuestion> questions;

  const OnboardingPhase({
    required this.id,
    required this.title,
    required this.questions,
  });
}
