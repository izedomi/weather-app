import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/enum/view_state.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/provider/fav_city_weather_provider.dart';
import 'package:weather_app/ui/utils/space.dart';
import '../../core/contants/color.dart';
import '../../core/contants/images.dart';
import '../../core/models/weather_model.dart';
import '../utils/media_query.dart';

class FavouriteWidget extends StatefulWidget {
  final CityModel cityModel;
  const FavouriteWidget({super.key, required this.cityModel});

  @override
  State<FavouriteWidget> createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  ViewState viewState = ViewState.idle;
  late FavCityWeatherProvider cityWeatherProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Future<WeatherModel?> _getMyCityweather() async {
    cityWeatherProvider =
        Provider.of<FavCityWeatherProvider>(context, listen: false);
    return cityWeatherProvider.getCityWeather(
        lat: widget.cityModel.lat, long: widget.cityModel.lon);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherModel?>(
      future: _getMyCityweather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: deviceWidth(context),
            height: deviceHeight(context),
            child: const Center(
                child: CircularProgressIndicator(
              color: AppColor.white,
            )
                //LottieBuilder.asset(lottiew2),
                ),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            width: deviceWidth(context),
            height: deviceHeight(context),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Error Occurred",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    VSpace(24.h),
                    TextButton(
                      onPressed: () {
                        _getMyCityweather();
                      },
                      child: const Text(
                        "Try Again",
                        style: TextStyle(
                            color: AppColor.brandOrange,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          WeatherModel? weatherModel = snapshot.data as WeatherModel;

          return SizedBox(
            width: 310.w,
            child: Stack(
              children: [
                Image.asset(
                  cityBg,
                  width: 310.w,
                ),
                Positioned(
                  left: 26.w,
                  top: 30.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          weatherModel.main?.temp?.toString() ?? "",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        ),
                      ),
                      Text(
                        'o',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 26.w,
                  bottom: 45.h,
                  child: Text(
                    weatherModel.name ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColor.white),
                  ),
                ),
                Positioned(
                  right: 20.w,
                  bottom: 45.h,
                  child: Text(
                    weatherModel.weather?.first.description ?? "",
                    style: TextStyle(fontSize: 12.sp, color: AppColor.white),
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
