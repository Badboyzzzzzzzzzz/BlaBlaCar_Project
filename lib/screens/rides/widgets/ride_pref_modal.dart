import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_icon_button.dart';

import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../ride_pref/widgets/ride_pref_form.dart';

class RidePrefModal extends StatefulWidget {
  final RidePreference? initialPreference;
  final Function(RidePreference) onSubmit;

  const RidePrefModal({
    super.key,
    required this.initialPreference,
    required this.onSubmit,

    // TODO 7 : We should pass the current prefs to this moda;
  });

  @override
  State<RidePrefModal> createState() => _RidePrefModalState();
}

class _RidePrefModalState extends State<RidePrefModal> {
  RidePreference? currentPreference;

  @override
  void initState() {
    super.initState();
    // Set the initial preference when the modal is first opened
    currentPreference = widget.initialPreference;
  }

  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onSubmit(RidePreference newPreference) {
    setState(() {
      // Update the preference when submitting
      currentPreference = newPreference;
    });
    widget.onSubmit(newPreference);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back icon
          BlaIconButton(
            onPressed: onBackSelected,
            icon: Icons.close,
          ),
          SizedBox(height: BlaSpacings.m),

          // Title
          Text("Edit your search",
              style: BlaTextStyles.title.copyWith(color: BlaColors.textNormal)),

          // Form
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: RidePrefForm(
              initialPreference:
                  currentPreference, // TODO 7 : The form should be displayed with the modal current prefs
              onSubmit: onSubmit,
            ),
          )),
        ],
      ),
    ));
  }
}
