import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/models/shimmers/weather_shimmer.dart';
import 'package:vit_ap_student_app/utils/weather/uv_index.dart';
import '../../utils/api/providers.dart';
import '../../utils/weather/wmo_codes.dart';

class MyWeatherWidget extends ConsumerWidget {
  const MyWeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncValue = ref.watch(weatherFutureProvider);
    final weatherNotifier = ref.watch(weatherProvider);
    final hourlyIndexNotifier = ref.watch(hourlyIndexProvider);
    final int index = hourlyIndexNotifier.index;

    return weatherAsyncValue.when(
      loading: () => const WeatherWidgetShimmer(),
      error: (err, stack) => const Center(
        child: Text("Some unexpected error occurred"),
      ),
      data: (_) {
        final uvIndex =
            weatherNotifier.weatherData["hourly"]["uv_index"]?[index];
        final weatherCode =
            weatherNotifier.weatherData["hourly"]["weather_code"]?[index];
        final temperature =
            weatherNotifier.weatherData["hourly"]["temperature_2m"]?[index];
        final apparentTemperature = weatherNotifier.weatherData["hourly"]
            ["apparent_temperature"]?[index];
        final minTemperature =
            weatherNotifier.weatherData["daily"]["temperature_2m_min"]?[0];
        final maxTemperature =
            weatherNotifier.weatherData["daily"]["temperature_2m_max"]?[0];

        final String uvWarning =
            uvIndex != null ? uvIndexWarning(uvIndex) : "UV data unavailable";
        final Map<String, String> weatherInfo = weatherCode != null
            ? getWeatherDescription(weatherCode)
            : {"description": "N/A", "assetPath": ""};

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                              Text(
                                "Amaravathi, In",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                temperature?.toString() ?? "N/A",
                                style: TextStyle(
                                  fontSize: 44,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                              Text(
                                "°C",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            apparentTemperature != null
                                ? "Feels Like : $apparentTemperature°C"
                                : "Feels Like : N/A",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          Text(
                            minTemperature != null && maxTemperature != null
                                ? "Min : $minTemperature°C | Max : $maxTemperature°C"
                                : "Min : N/A | Max : N/A",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: SvgPicture.asset(
                            "${weatherInfo['assetPath']}",
                            height: 150,
                            width: 150,
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              "${weatherInfo['description']}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "$uvWarning",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
