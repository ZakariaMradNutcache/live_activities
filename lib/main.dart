import 'package:flutter/material.dart';
import 'package:nutcache_live_activities/pages/timer_age.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: TimerWidget(),
        ),
      ),
    );
  }
}
