import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/core/contants/cities.dart';
import 'package:weather_app/core/contants/storage_key.dart';
import 'package:weather_app/core/services/storage_service.dart';

import '../models/city_model.dart';

class CityProvider extends ChangeNotifier {
  //  List<CityModel> _cities = [
  //   CityModel(
  //     city: "Lagos",
  //     lat: "6.4550",
  //     lon: "3.3841",
  //     isSelected: true,
  //   ),
  //   CityModel(
  //     city: "Abuja",
  //     lat: "9.0667",
  //     lon: "7.4833",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Ibadan",
  //     lat: "7.3964",
  //     lon: "3.9167",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Kano",
  //     lat: "12.0000",
  //     lon: "8.5167",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Orogbum",
  //     lat: "4.8242",
  //     lon: "7.0336",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Aba",
  //     lat: "5.1167",
  //     lon: "7.3667",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Onitsha",
  //     lat: "6.1667",
  //     lon: "6.7833",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Maiduguri",
  //     lat: "11.8333",
  //     lon: "13.1500",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Benin City",
  //     lat: "6.3333",
  //     lon: "5.6222",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Owerri",
  //     lat: "5.4833",
  //     lon: "7.0333",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Sokoto",
  //     lat: "13.0622",
  //     lon: "5.2339",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Ebute-Metta",
  //     lat: "6.4722",
  //     lon: "3.3806",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Ikotun",
  //     lat: "6.5443",
  //     lon: "3.2638",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Uselu",
  //     lat: "6.3843",
  //     lon: "5.6098",
  //     isSelected: false,
  //   ),
  //   CityModel(
  //     city: "Nnewi",
  //     lat: "6.0167",
  //     lon: "6.9167",
  //     isSelected: false,
  //   ),
  // ];

  CityProvider() {
    initialized();
  }

  List<CityModel> _cities = [];
  List<CityModel> get cities => _cities;

  initialized({bool notifyUI = false}) {
    _cities = allCities;
    if (notifyUI) {
      notifyListeners();
    }
  }

  CityModel? _selectedCity;
  CityModel? get selectedCity => _selectedCity;

  setSelectedCity(CityModel city) {
    _selectedCity = city;
    notifyListeners();
  }

  List<CityModel> _selectedCities = [];
  List<CityModel> get selectedCities => _selectedCities;
  setSelectedCities(List<CityModel> cities) {
    _selectedCities = cities;
    notifyListeners();
  }

  void toggleIselectedCity({required CityModel city, bool persist = true}) {
    //toggle selection
    int index =
        _selectedCities.indexWhere((c) => c.city.trim() == city.city.trim());
    index == -1 ? _selectedCities.add(city) : _selectedCities.removeAt(index);
    notifyListeners();

    //persists selection
    if (persist) {
      StorageService.storeStringItem(
          StorageKey.selectedCities, json.encode(_selectedCities));
    }
  }

  search({String? query}) {
    if (query == null || query.isEmpty) {
      notifyListeners();
      initialized();
      return;
    }

    _cities = _cities
        .where((city) => city.city.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
