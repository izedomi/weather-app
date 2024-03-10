import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/contants/images.dart';
import 'package:weather_app/core/models/city_model.dart';
import 'package:weather_app/core/provider/city_provider.dart';
import 'package:weather_app/ui/bs/bs_header.dart';
import 'package:weather_app/ui/utils/media_query.dart';
import 'package:weather_app/ui/utils/space.dart';

import '../../../core/contants/color.dart';
import '../../widgets/shared/custom_textfield.dart';

class FavouriteCitySelectionBs extends StatefulWidget {
  const FavouriteCitySelectionBs({super.key});

  @override
  State<FavouriteCitySelectionBs> createState() =>
      _FavouriteCitySelectionBsState();
}

class _FavouriteCitySelectionBsState extends State<FavouriteCitySelectionBs> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CityProvider>().initialized();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(builder: (context, citiesProvider, _) {
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
                      child:
                          const BsHeader(navTitle: "Select Favourite Cities")),
                  VSpace(24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomTextField(
                        labelText: "Search",
                        controller: controller,
                        onChange: () {
                          citiesProvider.search(query: controller.text);
                        }),
                  ),
                  VSpace(8.h),
                  citiesProvider.cities.isEmpty
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
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: citiesProvider.cities.length,
                            itemBuilder: (BuildContext context, int index) {
                              CityModel city = citiesProvider.cities[index];
                              city.isSelected = citiesProvider.selectedCities
                                      .indexWhere((it) =>
                                          it.city.trim() == city.city.trim()) >
                                  -1;
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 10, top: 20, right: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: deviceHeight(context) * .08,
                                width: deviceWidth(context),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromARGB(255, 16, 12, 44),
                                        Color(0xff362A84),
                                        // Color(0xff5936B4)
                                      ]),
                                  //  color: AppColor.brandBlue,
                                  border: city.isSelected == true
                                      ? Border.all(
                                          color: AppColor.white,
                                          width: 2,
                                        )
                                      : Border.all(color: Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    citiesProvider.toggleIselectedCity(
                                        city: city);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        city.isSelected ? checked : unchecked,
                                        width: 30,
                                        color: AppColor.white,
                                      ),
                                      HSpace(24.w),
                                      Text(
                                        citiesProvider.cities[index].city,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
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
