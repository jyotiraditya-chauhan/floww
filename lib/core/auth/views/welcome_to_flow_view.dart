import 'package:floww/config/utils/backgrounds/app_background.dart';
import 'package:floww/config/widgets/buttons/custom_button.dart';
import 'package:floww/config/widgets/headers/custom_header.dart';
import 'package:flutter/material.dart';

class WelcomeToFlowView extends StatefulWidget {
  const WelcomeToFlowView({super.key});

  @override
  State<WelcomeToFlowView> createState() => _WelcomeToFlowViewState();
}

class _WelcomeToFlowViewState extends State<WelcomeToFlowView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            CustomHeader(title: "Welcome to Floww", onBackPressed: () {}),
            CustomButton(text: "Let's personalize"),
          ],
        ),
      ),
    );
  }
}
