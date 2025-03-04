import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  final LocationRepository _locationsRepository;
  LocationsService(this._locationsRepository);
  List<Location> getLocations() {
    return _locationsRepository.getLocations();
  }
}
