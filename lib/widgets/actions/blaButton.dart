import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final BlaButtonType buttonType;

  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonType,
    this.icon, // Made icon optional
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = buttonType == BlaButtonType.primary;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: BlaSpacings.s,
        horizontal: BlaSpacings.xl,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? BlaColors.primary
              : BlaColors
                  .white, // this is use for passing color from the test screen
          foregroundColor: isPrimary ? BlaColors.white : BlaColors.primary,
          padding: EdgeInsets.symmetric(
              vertical: BlaSpacings.s, horizontal: BlaSpacings.l),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: isPrimary ? BlaColors.white : BlaColors.primary),
              SizedBox(width: BlaSpacings.s), // Spacing between icon and text
            ],
            Text(
              text,
              style: BlaTextStyles.button.copyWith(
                color: isPrimary? BlaColors.white: BlaColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum BlaButtonType {
  primary,
  secondary,
}
