import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<List<dynamic>> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return [400, 'Location services are disabled.'];
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        return [400, 'Location permissions are denied'];
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied
      return [
        400,
        'Location permissions are permanently denied, we cannot request permissions.'
      ];
    }

    // Retrieve the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // print('Latitude: ${position.latitude}');
    // print('Longitude: ${position.longitude}');
    return [200, position];
  }
}
