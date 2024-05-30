Map<String, String> getWeatherDescription(int wmoCode) {
  final Map<String, Map<String, Map<String, String>>> wmoCodes = {
    "0": {
      "day": {
        "description": "Sunny",
        "asset": "assets/images/weather/day.svg",
      },
      "night": {
        "description": "Clear",
        "asset": "assets/images/weather/night.svg",
      }
    },
    "1": {
      "day": {
        "description": "Mainly Sunny",
        "asset": "assets/images/weather/day.svg",
      },
      "night": {
        "description": "Mainly Clear",
        "asset": "assets/images/weather/night.svg",
      }
    },
    "2": {
      "day": {
        "description": "Partly Cloudy",
        "asset": "assets/images/weather/cloudy-day-1.svg",
      },
      "night": {
        "description": "Partly Cloudy",
        "asset": "assets/images/weather/cloudy-night-1.svg",
      }
    },
    "3": {
      "day": {
        "description": "Cloudy",
        "asset": "assets/images/weather/cloudy.svg",
      },
      "night": {
        "description": "Cloudy",
        "asset": "assets/images/weather/cloudy.svg",
      }
    },
    "45": {
      "day": {
        "description": "Foggy",
        "asset": "",
      },
      "night": {
        "description": "Foggy",
        "asset": "",
      }
    },
    "48": {
      "day": {
        "description": "Rime Fog",
        "asset": "",
      },
      "night": {
        "description": "Rime Fog",
        "asset": "",
      }
    },
    "51": {
      "day": {
        "description": "Light Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      },
      "night": {
        "description": "Light Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      }
    },
    "53": {
      "day": {
        "description": "Drizzle",
        "asset": "assets/images/weather/rainy-7.svg"
      },
      "night": {
        "description": "Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      }
    },
    "55": {
      "day": {
        "description": "Heavy Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      },
      "night": {
        "description": "Heavy Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      }
    },
    "56": {
      "day": {
        "description": "Light Freezing Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      },
      "night": {
        "description": "Light Freezing Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      }
    },
    "57": {
      "day": {
        "description": "Freezing Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      },
      "night": {
        "description": "Freezing Drizzle",
        "asset": "assets/images/weather/rainy-7.svg",
      }
    },
    "61": {
      "day": {
        "description": "Light Rain",
        "asset": "assets/images/weather/rainy-4.svg",
      },
      "night": {
        "description": "Light Rain",
        "asset": "assets/images/weather/rainy-4.svg",
      }
    },
    "63": {
      "day": {
        "description": "Rain",
        "asset": "assets/images/weather/rainy-5.svg",
      },
      "night": {
        "description": "Rain",
        "asset": "assets/images/weather/rainy-5.svg",
      }
    },
    "65": {
      "day": {
        "description": "Heavy Rain",
        "asset": "assets/images/weather/rainy-6.svg",
      },
      "night": {
        "description": "Heavy Rain",
        "asset": "assets/images/weather/rainy-6.svg",
      }
    },
    "66": {
      "day": {
        "description": "Light Freezing Rain",
        "asset": "assets/images/weather/snowy-4.svg",
      },
      "night": {
        "description": "Light Freezing Rain",
        "asset": "assets/images/weather/snowy-4.svg",
      }
    },
    "67": {
      "day": {
        "description": "Freezing Rain",
        "asset": "assets/images/weather/snowy-5.svg",
      },
      "night": {
        "description": "Freezing Rain",
        "asset": "assets/images/weather/snowy-5.svg",
      }
    },
    "71": {
      "day": {
        "description": "Light Snow",
        "asset": "assets/images/weather/snowy-4.svg",
      },
      "night": {
        "description": "Light Snow",
        "asset": "assets/images/weather/snowy-4.svg",
      }
    },
    "73": {
      "day": {
        "description": "Snow",
        "asset": "assets/images/weather/snowy-5.svg",
      },
      "night": {
        "description": "Snow",
        "asset": "assets/images/weather/snowy-5.svg",
      }
    },
    "75": {
      "day": {
        "description": "Heavy Snow",
        "asset": "assets/images/weather/snowy-6.svg",
      },
      "night": {
        "description": "Heavy Snow",
        "asset": "assets/images/weather/snowy-6.svg",
      }
    },
    "77": {
      "day": {
        "description": "Snow Grains",
        "asset": "assets/images/weather/snowy-6.svg",
      },
      "night": {
        "description": "Snow Grains",
        "asset": "assets/images/weather/snowy-6.svg",
      }
    },
    "80": {
      "day": {
        "description": "Light Showers",
        "asset": "assets/images/weather/rainy-4.svg",
      },
      "night": {
        "description": "Light Showers",
        "asset": "assets/images/weather/rainy-4.svg",
      }
    },
    "81": {
      "day": {
        "description": "Showers",
        "asset": "assets/images/weather/rainy-5.svg",
      },
      "night": {
        "description": "Showers",
        "asset": "assets/images/weather/rainy-5.svg",
      }
    },
    "82": {
      "day": {
        "description": "Heavy Showers",
        "asset": "assets/images/weather/rainy-6.svg",
      },
      "night": {
        "description": "Heavy Showers",
        "asset": "assets/images/weather/rainy-6.svg",
      }
    },
    "85": {
      "day": {
        "description": "Light Snow Showers",
        "asset": "assets/images/weather/snowy-4.svg",
      },
      "night": {
        "description": "Light Snow Showers",
        "asset": "assets/images/weather/snowy-4.svg",
      }
    },
    "86": {
      "day": {
        "description": "Snow Showers",
        "asset": "assets/images/weather/snowy-5.svg",
      },
      "night": {
        "description": "Snow Showers",
        "asset": "assets/images/weather/snowy-5.svg",
      }
    },
    "95": {
      "day": {
        "description": "Thunderstorm",
        "asset": "assets/images/weather/thunder.svg",
      },
      "night": {
        "description": "Thunderstorm",
        "asset": "assets/images/weather/thunder.svg",
      }
    },
    "96": {
      "day": {
        "description": "Light Thunderstorms With Hail",
        "asset": "assets/images/weather/thunder.svg",
      },
      "night": {
        "description": "Light Thunderstorms With Hail",
        "asset": "assets/images/weather/thunder.svg",
      }
    },
    "99": {
      "day": {
        "description": "Thunderstorm With Hail",
        "asset": "assets/images/weather/thunder.svg",
      },
      "night": {
        "description": "Thunderstorm With Hail",
        "asset": "assets/images/weather/thunder.svg",
      }
    }
  };

  DateTime now = DateTime.now();
  bool isDayTime = now.hour > 6 && now.hour < 20;

  String timeOfDay = isDayTime ? 'day' : 'night';
  String description =
      wmoCodes[wmoCode.toString()]?[timeOfDay]?['description'] ?? 'Unknown';
  String assetPath = wmoCodes[wmoCode.toString()]?[timeOfDay]?['asset'] ?? '';

  return {'description': description, 'assetPath': assetPath};
}

  //Map<String, String> weather = getWeatherDescription("63");
  //print("Description: ${weather['description']}");
  //print("Asset Path: ${weather['assetPath']}");

