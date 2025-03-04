import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of ble rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides;

  static RidesService? _instance;

  final RidesRepository repository;

  RidesService._internal(this.repository);
  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized");
    }
  }

  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "RidesService has not been initialized. Call initialize() first.");
    }
    return _instance!;
  }


  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePreference preferences,RidesFilter? filter) {
    // For now, just a test
    return instance.repository.getRides(preferences, filter);
  }
}

class RidesFilter {
  final bool acceptingPets;
  RidesFilter({required this.acceptingPets});
}