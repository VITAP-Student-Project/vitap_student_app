import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/models/shimmers/weather_shimmer.dart';
import 'package:vit_ap_student_app/utils/api/weather/uv_index.dart';
import '../../utils/provider/provider.dart';
import '../../utils/api/weather/wmo_codes.dart';
import 'package:lottie/lottie.dart';

class MyWeatherWidget extends ConsumerWidget {
  const MyWeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsyncValue = ref.watch(weatherFutureProvider);
    final weatherNotifier = ref.watch(weatherProvider);
    final hourlyIndexNotifier = ref.watch(hourlyIndexProvider);
    final int index = hourlyIndexNotifier.index;
    print(index);

    return weatherAsyncValue.when(
      loading: () => const WeatherWidgetShimmer(),
      error: (err, stack) => Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
              child: Column(
            children: [
              Lottie.asset(
                'assets/images/lottie/not_found_ghost.json',
                frameRate: FrameRate(60),
                width: 150,
              ),
              Text("Unable to fetch weather data at the moment"),
            ],
          )),
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(9),
          ),
        ),
      )),
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

        final Map<String, String> uvWarning = uvIndex != null
            ? uvIndexWarning(uvIndex)
            : {"description": "N/A", "assetPath": ""};
        final Map<String, String> weatherInfo = weatherCode != null
            ? getWeatherDescription(weatherCode)
            : {"description": "N/A", "assetPath": ""};

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
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
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              Text(
                                "Amaravathi, In",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).colorScheme.tertiary,
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
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                "°C",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
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
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            minTemperature != null && maxTemperature != null
                                ? "Min : $minTemperature°C | Max : $maxTemperature°C"
                                : "Min : N/A | Max : N/A",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primary,
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
                          child: Lottie.asset(
                            "${weatherInfo['assetPath']}",
                            frameRate: FrameRate(60),
                            width: 150,
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: AutoSizeText(
                              "${weatherInfo['description']}",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Lottie.asset(
                        "${uvWarning['assetPath']}",
                        frameRate: FrameRate(60),
                        width: 38,
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        '${uvWarning['description']}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
