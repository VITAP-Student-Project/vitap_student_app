import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:vit_ap_student_app/core/constants/uv_index.dart';
import 'package:vit_ap_student_app/core/constants/wmo_code.dart';
import 'package:vit_ap_student_app/core/utils/find_hour_index.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:timezone/timezone.dart' as tz;

class WeatherContainer extends ConsumerStatefulWidget {
  const WeatherContainer({super.key});

  @override
  ConsumerState<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends ConsumerState<WeatherContainer> {
  @override
  void initState() {
    super.initState();
    // Fetch weather data when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherAsyncValue = ref.watch(homeViewModelProvider);

    return weatherAsyncValue?.when(
          loading: () => Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/images/lottie/plane.json',
                        frameRate: FrameRate(60),
                        width: 150,
                      ),
                      Text("Fetching weather data...."),
                    ],
                  ),
                ),
              ),
            ),
          ),
          error: (err, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(9),
                ),
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
                  ),
                ),
              ),
            ),
          ),
          data: (weather) {
            final location = tz.getLocation(weather.timezone);
            final now = tz.TZDateTime.now(location);

            final hourlyTimes = weather.hourly.time.map((timeString) {
              return tz.TZDateTime.parse(location, timeString);
            }).toList();

            final currentIndex = findHourIndex(hourlyTimes, now);
            debugPrint('Current index: $currentIndex');
            debugPrint('Current Location: ${location.currentTimeZone}');
            debugPrint('Current time: ${now.toString()}');

            final uvIndex = weather.hourly.uvIndex[currentIndex];
            final weatherCode = weather.hourly.weatherCode[currentIndex];
            final temperature = weather.hourly.temperature2M[currentIndex];
            final apparentTemperature =
                weather.hourly.apparentTemperature[currentIndex];
            final minTemperature = weather.daily.temperature2MMin[0];
            final maxTemperature = weather.daily.temperature2MMax[0];

            final Map<String, String> uvWarning = uvIndexWarning(uvIndex);
            final Map<String, String> weatherInfo =
                getWeatherDescription(weatherCode);

            return Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
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
                                  Iconsax.location,
                                  size: 14,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Amaravathi, In",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${temperature.round()}",
                                  style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  "°C",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Feels Like: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${apparentTemperature.round()}°C",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Min: "),
                                  TextSpan(
                                    text: "${minTemperature.round()}°C",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  TextSpan(text: " | Max: "),
                                  TextSpan(
                                    text: "${maxTemperature.round()}°C",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ],
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
                              width: 125,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(
                                "${weatherInfo['description']}",
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
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
                        child: Text(
                          '${uvWarning['description']}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ) ??
        const SizedBox(); // Handle null case
  }
}
