Map<String, String> uvIndexWarning(double uv) {
  if (uv >= 0 && uv < 1) {
    return {
      'description':
          'You can safely enjoy being outdoors without any protection!',
      'assetPath': "assets/weather_icons/uv-index.json"
    };
  }
  if (uv >= 1 && uv < 2) {
    return {
      'description':
          'You can safely enjoy being outdoors without any protection!',
      'assetPath': "assets/weather_icons/uv-index-1.json"
    };
  }
  if (uv >= 2 && uv < 3) {
    return {
      'description':
          'Take some precaution. Seek shade during midday,wear SPF 15+ sunscreen if desired',
      'assetPath': "assets/weather_icons/uv-index-2.json"
    };
  }
  if (uv >= 3 && uv < 4) {
    return {
      'description':
          'Take some precaution. Seek shade during midday,wear SPF 15+ sunscreen if desired',
      'assetPath': "assets/weather_icons/uv-index-3.json"
    };
  }
  if (uv >= 4 && uv < 5) {
    return {
      'description':
          'Take some precaution. Seek shade during midday,wear SPF 15+ sunscreen if desired',
      'assetPath': "assets/weather_icons/uv-index-4.json"
    };
  }
  if (uv >= 5 && uv < 6) {
    return {
      'description':
          'Take some precaution. Seek shade during midday,wear SPF 15+ sunscreen if desired',
      'assetPath': "assets/weather_icons/uv-index-5.json"
    };
  }
  if (uv >= 6 && uv < 7) {
    return {
      'description':
          'Be sun smart! Seek shade during midday! Slip on a shirt, slop on sunscreen and slap on hat!',
      'assetPath': "assets/weather_icons/uv-index-6.json"
    };
  }
  if (uv >= 7 && uv < 8) {
    return {
      'description':
          'Be sun smart! Seek shade during midday! Slip on a shirt, slop on sunscreen and slap on hat!',
      'assetPath': "assets/weather_icons/uv-index-7.json"
    };
  }
  if (uv >= 8 && uv < 9) {
    return {
      'description':
          'Extra caution needed. Minimize midday sun, wear sun protection gear & SPF 50+',
      'assetPath': "assets/weather_icons/uv-index-8.json"
    };
  }
  if (uv >= 9 && uv < 10) {
    return {
      'description':
          'Extra caution needed. Minimize midday sun, wear sun protection gear & SPF 50+',
      'assetPath': "assets/weather_icons/uv-index-9.json"
    };
  }
  if (uv >= 10 && uv < 11) {
    return {
      'description':
          'Extra caution needed. Minimize midday sun, wear sun protection gear & SPF 50+',
      'assetPath': "assets/weather_icons/uv-index-10.json"
    };
  }
  if (uv >= 11) {
    return {
      'description':
          'Seek shade! Sunburn in minutes. All precautions are crucial, including SPF 30+ reapplied often.',
      'assetPath': "assets/weather_icons/uv-index-11.json"
    };
  }
  return {
    'description': 'Invalid UV Index indentified $uv',
    'assetPath': "assets/weather_icons/not-available.json"
  };
}
