import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';

/// Singleton LocationsService to handle location-related operations
class LocationsService {
  static LocationsService? _instance;
  final LocationRepository _locationsRepository;

  // Private constructor
  LocationsService._internal(this._locationsRepository);

  // Initialize the singleton instance
  static void initialize(LocationRepository locationsRepository) {
    if (_instance == null) {
      _instance = LocationsService._internal(locationsRepository);
    } else {
      throw Exception("LocationsService is already initialized");
    }
  }

  // Getter to access the instance
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception("LocationsService has not been initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Location> getLocations() {
    return _locationsRepository.getLocations();
  }
}
