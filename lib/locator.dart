import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather_app/core/provider/fav_city_weather_provider.dart';
import 'package:weather_app/core/services/dio/dio_api_service.dart';

import 'core/provider/city_provider.dart';
import 'core/provider/weather_provider.dart';

final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => CityProvider()),
  ChangeNotifierProvider(
      create: (_) => WeatherProvider(apiService: DioApiService())),
  ChangeNotifierProvider(
      create: (_) => FavCityWeatherProvider(apiService: DioApiService())),
];
