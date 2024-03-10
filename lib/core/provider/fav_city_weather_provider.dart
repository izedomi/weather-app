import 'package:flutter/material.dart';
import 'package:weather_app/core/contants/global_variables.dart';
import 'package:weather_app/core/models/weather_model.dart';
import '../models/api_response.dart';
import '../services/dio/dio_api_service.dart';

class FavCityWeatherProvider extends ChangeNotifier {
  WeatherModel? weatherModel;

  late ApiResponse _apiResponse;
  DioApiService apiService;

  FavCityWeatherProvider({required this.apiService});

  Future<WeatherModel?> getCityWeather(
      {required String long, required String lat}) async {
    try {
      String url =
          "data/2.5/weather?lat=$lat&lon=$long&appid=${EnvConstant.weatherApiKey}";

      _apiResponse = await apiService.get(url: url);
      if (!_apiResponse.success) {
        return null;
      }
      return WeatherModel.fromJson(_apiResponse.data);
    } catch (e) {
      return null;
    }
  }

  notify() {
    notifyListeners();
  }
}
