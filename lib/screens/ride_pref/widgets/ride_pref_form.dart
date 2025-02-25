import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/locationPicker_screen.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/blaButton.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  final ValueChanged<RidePref> onSubmit;
  const RidePrefForm({super.key, this.initRidePref, required this.onSubmit});
  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;
  bool _isFormValid() {
    return departure != null && arrival != null;
  }

  /// this function use for validate the rideformpref to make sure user
  void _handleSubmit() {
    if (_isFormValid()) {
      widget.onSubmit(RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      ));
    }
  }

  void _handleSwitchLocation() {
    setState(() {
      final Location? temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _rideLocationInput(
              label: departure?.name ?? 'Leaving From',
              icon: Icons.radio_button_unchecked,
              onTap: () async {
                // Implement your location selection logic here
                final Location? selectedLocation = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationPickerScreen()));
                if (selectedLocation != null) {
                  setState(() {
                    departure = selectedLocation;
                  });
                }
              },
              endIcon: IconButton(
                  onPressed: _handleSwitchLocation,
                  icon: Icon(Icons.swap_vert),style: ButtonStyle(iconColor: WidgetStateProperty.all(BlaColors.primary)),),
            ),
            const BlaDivider(),
            _rideLocationInput(
              label: arrival?.name ?? 'Going To',
              icon: Icons.radio_button_unchecked,
              onTap: () async {
                // Implement your location selection logic here
                final Location? selectedLocation = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationPickerScreen()));
                if (selectedLocation != null) {
                  setState(() {
                    arrival = selectedLocation;
                  });
                }
              },
            ),
            const BlaDivider(),
            _showDate(
                date: departureDate,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: departureDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != departureDate) {
                    setState(() {
                      departureDate = pickedDate;
                    });
                  }
                }),
            const BlaDivider(),
            _rideSeatsInput(
              seats: requestedSeats,
              onTap: () {
                // Implement your seat selection logic here
              },
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaButton(
              text: 'Search',
              onPressed: _handleSubmit,
              buttonType: BlaButtonType.primary,
            )
          ],
        ),
      ),
    );
  }

  Widget _rideLocationInput({
    required String label,
    required IconData icon,
    void Function()? onTap,
    IconButton? endIcon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: BlaColors.iconNormal),
            const SizedBox(width: 16),
            Text(
              label,
              style: BlaTextStyles.label.copyWith(
                color: BlaColors.textNormal,
                fontWeight: FontWeight.bold, // <-- make it bold
              ),
            ),
            const Spacer(),
            if (endIcon != null) endIcon,
          ],
        ),
      ),
    );
  }

  Widget _showDate({required DateTime date, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.calendar_month_rounded, color: BlaColors.iconLight),
            const SizedBox(width: 16),
            Text(
              DateTimeUtils.formatDateTime(date),
              style: BlaTextStyles.label.copyWith(
                color: BlaColors.textNormal,
                fontWeight: FontWeight.bold, //make it bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rideSeatsInput({required int seats, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(Icons.person_outline, color: BlaColors.iconLight),
            const SizedBox(width: 16),
            Text(
              '$seats',
              style: BlaTextStyles.label.copyWith(
                color: BlaColors.textNormal,
                fontWeight: FontWeight.bold, // <-- make it bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
