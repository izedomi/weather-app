import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/contants/global_variables.dart';
import 'package:weather_app/core/enum/view_state.dart';
import 'package:weather_app/core/models/api_response.dart';
import 'package:weather_app/core/provider/weather_provider.dart';
import 'package:weather_app/core/services/dio/dio_api_service.dart';
import 'weather_provider_test.mocks.dart';

@GenerateMocks([DioApiService])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  late MockDioApiService mockApiService;
  late WeatherProvider weatherProvider;
  final apiRespnse = {
    "coord": {"lon": 10.99, "lat": 44.34},
    "weather": [
      {"id": 501, "main": "Rain", "description": "moderate rain", "icon": "10d"}
    ],
    "base": "stations",
    "main": {
      "temp": 298.48,
      "feels_like": 298.74,
      "temp_min": 297.56,
      "temp_max": 300.05,
      "pressure": 1015,
      "humidity": 64,
      "sea_level": 1015,
      "grnd_level": 933
    },
    "visibility": 10000,
    "wind": {"speed": 0.62, "deg": 349, "gust": 1.18},
    "rain": {"1h": 3.16},
    "clouds": {"all": 100},
    "dt": 1661870592,
    "sys": {
      "type": 2,
      "id": 2075663,
      "country": "IT",
      "sunrise": 1661834187,
      "sunset": 1661882248
    },
    "timezone": 7200,
    "id": 3163858,
    "name": "Zocca",
    "cod": 200
  };

  setUp(() {
    mockApiService = MockDioApiService();
    weatherProvider = WeatherProvider(apiService: mockApiService);
  });

  test("successfully get weather with long and lat", () async {
    String long = '2.42';
    String lat = '2.43';
    String url =
        "data/2.5/weather?lat=$lat&lon=$long&appid=${EnvConstant.weatherApiKey}";

    // Stubbing
    when(mockApiService.get(url: url)).thenAnswer((_) async => ApiResponse(
        success: true, code: 200, message: "success", data: apiRespnse));

    await weatherProvider.getCityWeather(long: long, lat: lat);
    expect(weatherProvider.weatherModel, isNotNull);
    expect(weatherProvider.weatherModel?.name, "Zocca");
    expect(weatherProvider.weatherModel?.main?.temp, 298.48);
  });

  test("failed to get weather with long and lat", () async {
    String long = '2.42';
    String lat = '2.43';
    String url =
        "data/2.5/weather?lat=$lat&lon=$long&appid=${EnvConstant.weatherApiKey}";

    // Stubbing
    when(mockApiService.get(url: url)).thenAnswer(
        (_) async => ApiResponse(success: false, code: 400, message: "Error"));

    await weatherProvider.getCityWeather(long: long, lat: lat);
    expect(weatherProvider.weatherModel, isNull);
    expect(weatherProvider.getWeatherViewState, ViewState.error);
  });
}
