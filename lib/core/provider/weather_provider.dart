import 'package:flutter/material.dart';
import 'package:weather_app/core/contants/global_variables.dart';
import 'package:weather_app/core/models/weather_model.dart';
import '../enum/view_state.dart';
import '../models/api_response.dart';
import '../services/dio/dio_api_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? weatherModel;

  final DioApiService apiService;

  WeatherProvider({required this.apiService});

  late ApiResponse _apiResponse;
  ViewState _getWeatherViewState = ViewState.idle;
  ViewState get getWeatherViewState => _getWeatherViewState;

  void setWeatherViewState(ViewState viewState) {
    _getWeatherViewState = viewState;
    notifyListeners();
  }

  getCityWeather({required String long, required String lat}) async {
    try {
      setWeatherViewState(ViewState.busy);
      String url =
          "data/2.5/weather?lat=$lat&lon=$long&appid=${EnvConstant.weatherApiKey}";

      _apiResponse = await apiService.get(url: url);
      if (!_apiResponse.success) {
        setWeatherViewState(ViewState.error);
        return;
      }

      weatherModel = WeatherModel.fromJson(_apiResponse.data);

      setWeatherViewState(ViewState.completed);
    } catch (e) {
      setWeatherViewState(ViewState.error);
    }
  }
}
