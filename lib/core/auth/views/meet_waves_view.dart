import 'package:floww/config/utils/backgrounds/app_background.dart';
import 'package:flutter/material.dart';

class MeetWavesView extends StatefulWidget {
  const MeetWavesView({super.key});

  @override
  State<MeetWavesView> createState() => _MeetWavesViewState();
}

class _MeetWavesViewState extends State<MeetWavesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        // isInner: true,
        // mode: AppBackgroundMode.flow,
        child: Column(children: [Text("data")]),
      ),
    );
  }
}
