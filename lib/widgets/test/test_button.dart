import 'package:flutter/material.dart';
import '../actions/blaButton.dart';
class TestButton extends StatelessWidget {
  const TestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlaButton(
              text: "Primary Button",
              onPressed: () {},
              buttonType: BlaButtonType.primary,
              icon: Icons.add,
            ),
            SizedBox(height: 10,),
            BlaButton(
              text: "Secondary Button",
              onPressed: () {},
              buttonType: BlaButtonType.secondary,
              icon: Icons.add_alarm
            ),
          ],
        ),
      ),
    );
  }
}