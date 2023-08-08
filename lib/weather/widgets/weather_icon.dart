part of weather;

class WeatherIconWidget extends StatelessWidget {
  final String al;
  final Map<String, dynamic> almanac;
  final double? hw;
  final String weather;

  const WeatherIconWidget({
    super.key,
    this.al = '',
    required this.almanac,
    this.hw,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    String icon = '';

    final now = DateTime.now();
    final sunrise = DateTime.parse(almanac['sunrise']!);
    final sunset = DateTime.parse(almanac['sunset']!);

    if (weather == '晴朗') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/SunnyDayV3.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/ClearNightV3.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/ClearNightV3.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/SunnyDayV3.svg';
      }
    } else if (weather == '大部晴朗') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlySunnyDay.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyClearNight.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyClearNight.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlySunnyDay.svg';
      }
    } else if (weather == '局部晴朗') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D200PartlySunnyV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/PartlyCloudyNightV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/PartlyCloudyNightV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D200PartlySunnyV2.svg';
      }
    } else if (weather == '局部多云') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D200PartlySunnyV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/PartlyCloudyNightV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/PartlyCloudyNightV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D200PartlySunnyV2.svg';
      }
    } else if (weather == '多云') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyCloudyDayV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyCloudyNightV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyCloudyNightV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyCloudyDayV2.svg';
      }
    } else if (weather == '阴') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/CloudyV3.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/CloudyV3.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/CloudyV3.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/CloudyV3.svg';
      }
    } else if (weather == '小阵雨') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D310LightRainShowersV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N310LightRainShowersV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N310LightRainShowersV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D310LightRainShowersV2.svg';
      }
    } else if (weather == '阵雨') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainShowersDayV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainShowersNightV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainShowersNightV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainShowersDayV2.svg';
      }
    } else if (weather == '雷雨') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D340TstormsV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N340TstormsV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N340TstormsV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D340TstormsV2.svg';
      }
    } else if (weather == '小雨') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightRainV3.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightRainV3.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightRainV3.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightRainV3.svg';
      }
    } else if (weather == '雨') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavyDrizzle.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavyDrizzle.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        // TODO
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavyDrizzle.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavyDrizzle.svg';
      }
    } else if (weather == '大雨') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/ModerateRainV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/ModerateRainV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/ModerateRainV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/ModerateRainV2.svg';
      }
    } else if (weather == '小阵雨夹雪') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D311LightRainSnowShowersV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N311LightRainSnowShowersV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        // TODO
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N311LightRainSnowShowersV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D311LightRainSnowShowersV2.svg';
      }
    } else if (weather == '雨夹雪' || weather == '小雨夹雪') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainSnowV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainSnowV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        // TODO
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainSnowV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainSnowV2.svg';
      }
    } else if (weather == '小阵雪') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowShowersDay.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowShowersNight.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowShowersNight.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowShowersDay.svg';
      }
    } else if (weather == '阵雪') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D212LightSnowShowersV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N212LightSnowShowersV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N212LightSnowShowersV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D212LightSnowShowersV2.svg';
      }
    } else if (weather == '小雪') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        // TODO
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowV2.svg';
      }
    } else if (weather == '雪') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/Snow.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N422SnowV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N422SnowV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/Snow.svg';
      }
    } else if (weather == '大雪') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavySnowV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavySnowV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        // TODO
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavySnowV2.svg';
      } else {
        // TODO
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavySnowV2.svg';
      }
      // } else if (weather == '冰雹') {
      //   if (al == '早') {
      //   icon =
      //       '';
      // } else if (al == '晚') {
      //   icon =
      //       '';
      // } else if (now.difference(sunset).inSeconds >= 0 ||
      //       now.difference(sunrise).inSeconds <= 0) {
      //     icon = '';
      //   } else {
      //     icon = '';
      //   }
    } else if (weather == '雾') {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/FogV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/FogV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        // TODO
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/FogV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/FogV2.svg';
      }
      // } else if (weather == '霾') {
      //   if (al == '早') {
      //   icon = '';
      // } else if (al == '晚') {
      //   icon = '';
      // } else if (now.difference(sunset).inSeconds >= 0 ||
      //       now.difference(sunrise).inSeconds <= 0) {
      //     icon = '';
      //   } else {
      //     icon = '';
      //   }
    } else {
      if (al == '早') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D200PartlySunnyV2.svg';
      } else if (al == '晚') {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/PartlyCloudyNightV2.svg';
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/PartlyCloudyNightV2.svg';
      } else {
        icon =
            'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D200PartlySunnyV2.svg';
      }
    }

    return SvgPicture.network(
      icon,
      fit: BoxFit.cover,
      height: hw ?? 60,
      width: hw ?? 60,
    );
  }
}
