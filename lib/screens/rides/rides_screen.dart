import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_pref_modal.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_pref_bar.dart';
import 'package:week_3_blabla_project/service/ride_prefs_service.dart';

import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
import 'widgets/rides_tile.dart';

///
/// The Ride Selection screen allows users to select a ride after defining ride preferences.
/// Users can also edit their search preferences and apply filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late RidePreference currentPreference;

  @override
  void initState() {
    super.initState();
    
    // Fetch the current preference from the RidePrefService singleton
    currentPreference = RidePrefService.instance.currentPreference!;
  }

  List<Ride> get matchingRides => RidesService.getRidesFor(currentPreference, null);

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  /// Opens the RidePrefModal for the user to edit their search preferences.
  void onPreferencePressed() async {
    final updatedPreference = await showModalBottomSheet<RidePreference>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => RidePrefModal(
        initialPreference: currentPreference,
        onSubmit: (newPreference) {
          setState(() {
            currentPreference = newPreference;
            RidePrefService.instance.setCurrentPreference(newPreference);
          });
        },
      ),
    );

    // If the preference was updated, refresh the ride list
    if (updatedPreference != null) {
      setState(() {
        currentPreference = updatedPreference;
      });
    }
  }

  void onFilterPressed() {
    // TODO: Implement filter logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            // Top search bar with back button and filter
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed, // Opens edit search modal
              onFilterPressed: onFilterPressed,
            ),

            // Display list of matching rides
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
