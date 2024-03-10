import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/provider/city_provider.dart';
import 'package:weather_app/ui/bs/bs_header.dart';
import 'package:weather_app/ui/utils/space.dart';

import '../../../core/contants/color.dart';
import '../../../core/provider/weather_provider.dart';
import '../../utils/media_query.dart';
import '../../widgets/shared/custom_textfield.dart';

class CitySelectionBs extends StatefulWidget {
  const CitySelectionBs({super.key});

  @override
  State<CitySelectionBs> createState() => _CitySelectionBsState();
}

class _CitySelectionBsState extends State<CitySelectionBs> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CityProvider>().initialized();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(builder: (context, cityProvider, _) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
        child: Container(
          width: deviceWidth(context),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 16, 12, 44),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  VSpace(60.h),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const BsHeader(navTitle: "Select City")),
                  VSpace(24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomTextField(
                        labelText: "Search",
                        controller: controller,
                        onChange: () {
                          cityProvider.search(query: controller.text);
                        }),
                  ),
                  VSpace(8.h),
                  cityProvider.cities.isEmpty
                      ? Column(
                          children: [
                            VSpace(60.h),
                            const Text(
                              "No city available",
                              style: TextStyle(color: AppColor.white),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cityProvider.cities.length,
                            padding: EdgeInsets.only(top: 24.sp),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return VSpace(16.h);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              CityModel city = cityProvider.cities[index];
                              city.isSelected = cityProvider.selectedCities
                                      .indexWhere((it) =>
                                          it.city.trim() == city.city.trim()) >
                                  -1;

                              return GestureDetector(
                                onTap: () {
                                  cityProvider.setSelectedCity(
                                      cityProvider.cities[index]);
                                  Provider.of<WeatherProvider>(context,
                                          listen: false)
                                      .getCityWeather(
                                          long: cityProvider.selectedCity!.lon,
                                          lat: cityProvider.selectedCity!.lat);
                                  // Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 24),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: cityProvider.selectedCity ==
                                            cityProvider.cities[index]
                                        ? Border.all(
                                            color: AppColor.white,
                                            width: 2,
                                          )
                                        : Border.all(color: Colors.transparent),
                                    gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color.fromARGB(255, 16, 12, 44),
                                          Color(0xff362A84),
                                          // Color(0xff5936B4)
                                        ]),
                                    color: cityProvider.selectedCity ==
                                            cityProvider.cities[index]
                                        ? AppColor.brandBlue
                                        : AppColor.brownGrey.withOpacity(0.8),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        cityProvider.cities[index].city,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.white),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
              Positioned(
                  bottom: 16.h,
                  right: 16.w,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          color: AppColor.brandOrange,
                          borderRadius: BorderRadius.circular(16.r)),
                      child: const Icon(
                        Icons.check,
                        color: AppColor.white,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
