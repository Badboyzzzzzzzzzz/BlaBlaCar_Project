// ignore_for_file: unnecessary_null_comparison, unrelated_type_equality_checks

import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/user/user.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

class MockRidesRepository extends RidesRepository {
  final List<Ride> _rides = [
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      departureDate: _getTodayAt(5, 30), // Today at 5:30 AM
      arrivalDateTime: _getTodayAt(7, 30), // 2 hours later
      driver: User(
          firstName: 'Kannika',
          lastName: '',
          email: 'email',
          phone: 'phone',
          profilePicture: 'profilePicture',
          verifiedProfile: true),
      acceptedPets: false,
      availableSeats: 2,
      pricePerSeat: 20,
    ),
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      departureDate: _getTodayAt(20, 0), // Today at 8:00 PM
      arrivalDateTime: _getTodayAt(22, 0), // 2 hours later
      driver: User(
          firstName: 'Chaylim',
          lastName: '',
          email: 'email',
          phone: 'phone',
          profilePicture: 'profilePicture',
          verifiedProfile: true),
      acceptedPets: false,
      availableSeats: 0,
      pricePerSeat: 20,
    ),
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      departureDate: _getTodayAt(5, 0), // Today at 5:00 AM
      arrivalDateTime: _getTodayAt(8, 0), // 3 hours later
      driver: User(
          firstName: 'Mengtech',
          lastName: '',
          email: 'email',
          phone: 'phone',
          profilePicture: 'profilePicture',
          verifiedProfile: true),
      acceptedPets: false,
      availableSeats: 1,
      pricePerSeat: 20,
    ),
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      departureDate: _getTodayAt(20, 0), // Today at 8:00 PM
      arrivalDateTime: _getTodayAt(22, 0), // 2 hours later
      driver: User(
          firstName: 'Limhao',
          lastName: '',
          email: 'email',
          phone: 'phone',
          profilePicture: 'profilePicture',
          verifiedProfile: true),
      acceptedPets: true,
      availableSeats: 2,
      pricePerSeat: 20,
    ),
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      departureDate: _getTodayAt(5, 0), // Today at 5:00 AM
      arrivalDateTime: _getTodayAt(8, 0), // 3 hours later
      driver: User(
          firstName: 'Sovanda',
          lastName: '',
          email: 'email',
          phone: 'phone',
          profilePicture: 'profilePicture',
          verifiedProfile: true),
      acceptedPets: false,
      availableSeats: 1,
      pricePerSeat: 20,
    ),
  ];

  static DateTime _getTodayAt(int hour, int minute) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    return _rides;
  }
}
