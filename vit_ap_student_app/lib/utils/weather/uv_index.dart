String uvIndexWarning(double uv) {
  if (uv < 2.00) {
    return 'You can safely enjoy being outside!';
  }
  if (uv >= 2.00 && uv < 8.00) {
    return 'Seek shade during midday hours! Slip on a shirt, slop on sunscreen and slap on hat!';
  }
  if (uv >= 8.00) {
    return 'Avoid being outside during midday hours! Make sure you seek shade! Shirt, sunscreen and hat are a must!';
  }
  return "Invalid UV Index Identified $uv";
}
