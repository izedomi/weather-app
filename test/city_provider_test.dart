import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/provider/city_provider.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("cites", () {
    test("15 cities are available", () {
      final cityProvider = CityProvider();
      expect(cityProvider.cities.length, 15);
    });

    test("city has name, lat and long", () {
      final cityProvider = CityProvider();

      final city = cityProvider.cities.first;
      expect(city.city, "Lagos");
      expect(city.lat, "6.4550");
      expect(city.lon, "3.3841");
    });

    test("Lagos is selected by default", () {
      final cityProvider = CityProvider();

      final city = cityProvider.cities.first;

      expect(city.city, "Lagos");
      expect(city.isSelected, true);
    });

    test("currently selected city is null by default", () {
      final cityProvider = CityProvider();

      expect(cityProvider.selectedCity, null);
    });

    test("currently selected city has name 'Uselu'", () {
      final cityProvider = CityProvider();

      CityModel selectedCity = CityModel(
        city: "Uselu",
        lat: "6.3843",
        lon: "5.6098",
        isSelected: false,
      );

      cityProvider.setSelectedCity(selectedCity);

      expect(cityProvider.selectedCity?.city, selectedCity.city);
      expect(cityProvider.selectedCity?.lat, selectedCity.lat);
      expect(cityProvider.selectedCity?.lon, selectedCity.lon);
      expect(cityProvider.selectedCity?.isSelected, selectedCity.isSelected);
    });
  });

  group("selected cities", () {
    test("selected cities is empty by default", () {
      final cityProvider = CityProvider();

      expect(cityProvider.selectedCities, []);
      expect(cityProvider.selectedCities.length, 0);
    });

    test("cities is added to list of selected cities", () {
      final cityProvider = CityProvider();

      cityProvider.setSelectedCities(cityProvider.cities);

      expect(cityProvider.selectedCities.length, 15);
    });

    test("add city to selected cities if city is not in list", () async {
      final cityProvider = CityProvider();

      final cities = [
        CityModel(
          city: "Abuja",
          lat: "9.0667",
          lon: "7.4833",
          isSelected: false,
        ),
      ];

      //add cities
      cityProvider.setSelectedCities(cities);

      cityProvider.toggleIselectedCity(
          city: CityModel(
            city: "Lagos",
            lat: "6.4550",
            lon: "3.3841",
            isSelected: true,
          ),
          persist: false);

      expect(cityProvider.selectedCities.length, 2);
    });

    test("remove city from selected cities if city already exists", () async {
      final cityProvider = CityProvider();

      final cities = [
        CityModel(
          city: "Abuja",
          lat: "9.0667",
          lon: "7.4833",
          isSelected: false,
        ),
        CityModel(
          city: "Lagos",
          lat: "6.4550",
          lon: "3.3841",
          isSelected: true,
        )
      ];

      cityProvider.setSelectedCities(cities);

      cityProvider.toggleIselectedCity(
          city: CityModel(
            city: "Lagos",
            lat: "6.4550",
            lon: "3.3841",
            isSelected: true,
          ),
          persist: false);

      expect(cityProvider.selectedCities.length, 1);
    });
  });

  group("search cities", () {
    test("query string is null, returns all list of cities", () {
      final cityProvider = CityProvider();

      cityProvider.search(query: "");

      expect(cityProvider.cities, isNotEmpty);
      expect(cityProvider.cities.length, 15);
    });

    test("query string is empty, returns all list of cities", () {
      final cityProvider = CityProvider();

      cityProvider.search(query: null);

      expect(cityProvider.cities, isNotEmpty);
      expect(cityProvider.cities.length, 15);
    });

    test(
        "query string is a substring of an existing city name, return all cities",
        () {
      final cityProvider = CityProvider();

      cityProvider.search(query: "Lagos");

      expect(cityProvider.cities, isNotEmpty);
    });

    test(
        "query string is not a substring of an existing city name, return an empty list",
        () {
      final cityProvider = CityProvider();

      cityProvider.search(query: "Quebec");

      expect(cityProvider.cities, isEmpty);
    });
  });
}
