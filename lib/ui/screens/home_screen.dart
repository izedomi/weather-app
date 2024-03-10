import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/enum/view_state.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/provider/weather_provider.dart';
import 'package:weather_app/ui/bs/bs_wrapper.dart';
import 'package:weather_app/ui/bs/content/city_selection_screen.dart';
import 'package:weather_app/ui/utils/media_query.dart';
import 'package:weather_app/ui/widgets/weather_info_widget.dart';
import '../../core/contants/color.dart';
import '../../core/contants/images.dart';
import '../../core/provider/city_provider.dart';
import '../../core/services/geo_locator_service.dart';
import '../widgets/favourite_widget.dart';
import '../widgets/shared/selection_button_widget.dart';
import '../bs/content/favourite_city_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //initiatilization

  late CityProvider cityProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCity();
    });
  }

  _getMyCityweather(CityModel city) {
    return Provider.of<WeatherProvider>(context, listen: false)
        .getCityWeather(lat: city.lat, long: city.lon);
  }

  _initializeCity() {
    cityProvider = Provider.of<CityProvider>(context, listen: false);
    cityProvider.setSelectedCity(cityProvider.cities.first);
    _getMyCityweather(cityProvider.selectedCity!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SizedBox(
            width: deviceWidth(context),
            height: deviceHeight(context),
            child: Stack(
              children: [
                Image.asset(
                  bg1,
                  width: deviceWidth(context),
                  height: deviceHeight(context),
                  fit: BoxFit.cover,
                ),
                _mainContent(),
              ],
            )),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              //get my current location lat/long
              _getCurrentLocation();
            },
            backgroundColor: AppColor.brandOrange,
            label: const Text(
              "Current Location",
              style: TextStyle(color: AppColor.white),
            ),
            // label: SizedBox(),
            icon: const Icon(
              Iconsax.location,
              color: AppColor.white,
            )));
  }

  Widget _mainContent() {
    return Consumer<WeatherProvider>(builder: (context, vm, _) {
      if (vm.getWeatherViewState == ViewState.busy) {
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
      if (vm.getWeatherViewState == ViewState.error) {
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
                    "Unable to fetch weather information\nat this time.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      _getMyCityweather(cityProvider.selectedCity!);
                    },
                    child: const Text(
                      "Try Again",
                      style: TextStyle(
                          color: AppColor.white,
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
      if (vm.getWeatherViewState == ViewState.completed &&
          vm.weatherModel != null) {
        return Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
          child: ListView(
            children: [
              Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 24.w),
                          child: SelectionButtonWidget(
                            onTap: () {
                              BsWrapper.bottomSheet(
                                  context: context,
                                  widget: const CitySelectionBs());

                              //Navigator.pushNamed(context, '/city-selection');
                            },
                          ))),
                  SizedBox(height: 30.h),
                  Text(
                    vm.weatherModel!.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 42.sp,
                      height: 0.8,
                      color: AppColor.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          vm.weatherModel?.main?.temp?.toString() ?? "",
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
                  Text(
                    vm.weatherModel?.weather?.first.description ?? "",
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 13.sp,
                      height: 0.4,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Text("Main",
                        style: TextStyle(
                            fontSize: 24,
                            //color: AppColor.brandBlue,
                            foreground: Paint()..shader = linearGradient,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    height: 150.h,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      children: [
                        WeatherItemWidget(
                          value:
                              vm.weatherModel?.main?.humidity.toString() ?? "",
                          label: "Humidity",
                          imageUrl: humidityImg,
                          c1: Colors.green,
                        ),
                        const SizedBox(width: 16),
                        WeatherItemWidget(
                          value:
                              vm.weatherModel?.main?.pressure.toString() ?? "",
                          label: "Pressure",
                          imageUrl: sleetImg,
                          c1: AppColor.brandOrange,
                        ),
                        const SizedBox(width: 16),
                        vm.weatherModel?.main?.seaLevel != null
                            ? WeatherItemWidget(
                                value: vm.weatherModel?.main?.seaLevel
                                        .toString() ??
                                    "",
                                label: "Sea Level",
                                imageUrl: humidityImg,
                                c1: Colors.green,
                              )
                            : const SizedBox(),
                        const SizedBox(width: 16),
                        vm.weatherModel?.main?.grndLevel != null
                            ? WeatherItemWidget(
                                value: vm.weatherModel?.main?.grndLevel
                                        .toString() ??
                                    "",
                                label: "Ground Level",
                                imageUrl: sleetImg,
                                c1: AppColor.brandOrange,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              // Wind
              Consumer<CityProvider>(builder: (context, cityVM, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Favourite Cities",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 4.w),
                              const Icon(
                                Iconsax.heart5,
                                color: AppColor.brandOrange,
                              ),
                            ],
                          ),
                          if (cityVM.selectedCities.isNotEmpty)
                            InkWell(
                              onTap: () {
                                // Navigator.pushNamed(context, '/city-selection');
                                BsWrapper.bottomSheet(
                                    context: context,
                                    widget: const FavouriteCitySelectionBs());
                              },
                              child: Row(
                                children: [
                                  Text("Update",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColor.white,
                                          // foreground: Paint()..shader = linearGradient,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 4.w),
                                  const Icon(
                                    Iconsax.arrow_right_1,
                                    color: AppColor.white,
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      height: 220,

                      alignment: Alignment.center,
                      child: cityVM.selectedCities.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    BsWrapper.bottomSheet(
                                        context: context,
                                        widget:
                                            const FavouriteCitySelectionBs());
                                    // GlobalBottomSheet
                                    //     .customShowModelBottomSheet(
                                    //   context: context,
                                    //   widget: Container(
                                    //       width: deviceWidth(context),
                                    //       height: deviceHeight(context) * 0.9,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.only(
                                    //             topLeft: Radius.circular(16.r),
                                    //             topRight:
                                    //                 Radius.circular(16.r)),
                                    //       ),
                                    //       child:
                                    //           const FavouriteCitySelectionScreen()),
                                    // );
                                    // Navigator.pushNamed(
                                    //     context, '/city-selection');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Add a fav city",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                            color: AppColor.white),
                                      ),
                                      SizedBox(width: 4.w),
                                      const Icon(
                                        Iconsax.add,
                                        color: AppColor.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              itemCount: cityVM.selectedCities.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 24.w);
                              },
                              itemBuilder: (context, index) {
                                CityModel city = cityVM.selectedCities[index];
                                return FavouriteWidget(cityModel: city);
                              }),
                      // child: ListView(
                      //   scrollDirection: Axis.horizontal,
                      //   children: [
                      //
                      //   ],
                      // ),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      }

      return const SizedBox();
    });
  }

  _getCurrentLocation() async {
    try {
      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      final cityProvider = Provider.of<CityProvider>(context, listen: false);
      weatherProvider.setWeatherViewState(ViewState.busy);
      final res = await GeoLocatorService().getCurrentLocation();

      //Error getting user current lat/long
      if (res.first != 200) {
        weatherProvider.setWeatherViewState(ViewState.error);
        _showErrorBs(res.last.toString());
        return;
      }

      String long = res.last.longitude.toString();
      String lat = res.last.latitude.toString();
      cityProvider.setSelectedCity(CityModel(
          city: "Current Location", lat: lat, lon: long, isSelected: false));
      weatherProvider.getCityWeather(long: long, lat: lat);
    } catch (_) {
      _showErrorBs("Something went wrong. Please try again.");
    }
  }

  _showErrorBs(String msg) {
    BsWrapper.bottomSheet(
        context: context,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 60),
            Text(
              msg,
              style: const TextStyle(
                  color: AppColor.brandBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
          ],
        ));
  }
}
