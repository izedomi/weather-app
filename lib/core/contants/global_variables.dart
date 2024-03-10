import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConstant {
  static String weatherApiKey = dotenv.env['WEATHER_API_KEY'] ?? "";
}
