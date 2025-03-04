import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';

class MockLocationRepository extends LocationRepository {
  @override
  List<Location> getLocations() {
    return [
      // cambodia Cities
      Location(name: 'Phnom Penh', country: Country.cambodia),
      Location(name: 'Siem Reap', country: Country.cambodia),
      Location(name: 'Battambang', country: Country.cambodia),
      Location(name: 'Sihanoukville', country: Country.cambodia),
      Location(name: 'Kampong Cham', country: Country.cambodia),
      Location(name: 'Kampot', country: Country.cambodia),
    ];
  }
}
