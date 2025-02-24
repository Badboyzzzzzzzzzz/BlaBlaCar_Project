import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/blaButton.dart';
import 'package:week_3_blabla_project/widgets/test/test_button.dart';
import 'screens/ride_pref/ride_pref_screen.dart';
import 'theme/theme.dart';
import 'widgets/actions/blaButton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: TestButton()),
    );
  }
}
