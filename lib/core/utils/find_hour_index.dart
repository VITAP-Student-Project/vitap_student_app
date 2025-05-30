import 'package:timezone/timezone.dart' as tz;

int findHourIndex(List<tz.TZDateTime> times, tz.TZDateTime target) {
  int closestIndex = 0;
  Duration closestDifference = times[0].difference(target).abs();

  for (int i = 1; i < times.length; i++) {
    final Duration diff = times[i].difference(target).abs();
    if (diff < closestDifference) {
      closestDifference = diff;
      closestIndex = i;
    }
  }
  return closestIndex;
}
