import 'package:flutter_test/flutter_test.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_ride_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

void main() {
  RidesService.initialize(MockRidesRepository());

  RidePreference pref = RidePreference(
    departure: cambodiaLocation[2], // Battambang
    departureDate: DateTime.now(),
    arrival: cambodiaLocation[1], // SiemReap
    requestedSeats: 1,
  );

  RidesFilter filter1 = RidesFilter(acceptingPets: false);
  RidesFilter filter2 = RidesFilter(acceptingPets: true);

  test('not allow pet', () {
    var rides = RidesService.getRidesFor(pref, filter1); // No pet filter

    print('Battambang -> SiemReap, today 1 passenger have ${rides.length} rides:');
    for (var ride in rides) {
      String formattedTime = '${ride.departureDate.hour}:${ride.departureDate.minute.toString().padLeft(2, '0')} ${ride.departureDate.hour < 12 ? 'am' : 'pm'}';
      print('- at $formattedTime with ${ride.driver.firstName} (${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours)');
    }

    expect(rides.length, equals(4)); // 4 rides without pet filter
  });

  test('accept pets', () {
    var rides = RidesService.getRidesFor(pref, filter2); // With pet filter

    print('Battambang -> SiemReap, today 1 passenger and accepting pets have ${rides.length} ride:');
    for (var ride in rides) {
      String formattedTime = '${ride.departureDate.hour}:${ride.departureDate.minute.toString().padLeft(2, '0')} ${ride.departureDate.hour < 12 ? 'am' : 'pm'}';
      print('- at $formattedTime with ${ride.driver.firstName} (${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours)');
    }

    expect(rides.length, equals(1)); // Only 1 ride with pet filter
  });
}
