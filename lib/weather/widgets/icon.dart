part of weather;

class IconWidget extends StatelessWidget {
  final String al;
  final Map<String, dynamic> almanac;
  final double? hw;
  final String cap;

  const IconWidget({
    super.key,
    this.al = '',
    required this.almanac,
    this.hw,
    required this.cap,
  });

  @override
  Widget build(BuildContext context) {
    String icon = '';

    final now = DateTime.now();
    final sunrise = DateTime.parse(almanac['sunrise']!);
    final sunset = DateTime.parse(almanac['sunset']!);

    late List<String> wi;

    if (cap == '晴朗') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/SunnyDayV3.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/ClearNightV3.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '大部晴朗') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlySunnyDay.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyClearNight.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '局部晴朗' || cap == '局部多云') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D200PartlySunnyV2.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/PartlyCloudyNightV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '多云') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyCloudyDayV2.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/MostlyCloudyNightV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '阴') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/CloudyV3.svg',
      ];

      icon = wi[0];
    } else if (cap == '小阵雨') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D310LightRainShowersV2.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N310LightRainShowersV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '阵雨') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainShowersDayV2.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainShowersNightV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '雷雨') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D340TstormsV2.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N340TstormsV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '小雨') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightRainV3.svg',
      ];

      icon = wi[0];
    } else if (cap == '雨') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavyDrizzle.svg',
      ];

      icon = wi[0];
    } else if (cap == '大雨') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/ModerateRainV2.svg',
      ];

      icon = wi[0];
    } else if (cap == '小阵雨夹雪') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D311LightRainSnowShowersV2.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N311LightRainSnowShowersV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '雨夹雪' || cap == '小雨夹雪') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/RainSnowV2.svg',
      ];

      icon = wi[0];
    } else if (cap == '小阵雪') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowShowersDay.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowShowersNight.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '阵雪') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D212LightSnowShowersV2.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N212LightSnowShowersV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '小雪') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/LightSnowV2.svg',
      ];

      icon = wi[0];
    } else if (cap == '雪') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/Snow.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/N422SnowV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    } else if (cap == '大雪') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/HeavySnowV2.svg',
      ];

      icon = wi[0];
      // } else if (cap == '冰雹') {
      // wi = [

      // ];
      //
      //   if (al == '早') {
      //   icon =
      //       '';
      // } else if (al == '晚') {
      //   icon =
      //       '';
      // } else if (now.difference(sunset).inSeconds >= 0 ||
      //       now.difference(sunrise).inSeconds <= 0) {
      //   icon = '';
      // } else {
      //   icon = '';
      // }
    } else if (cap == '雾') {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/FogV2.svg',
      ];

      icon = wi[0];
      // } else if (cap == '霾') {
      // wi = [

      // ];

      // if (al == '早') {
      //   icon = '';
      // } else if (al == '晚') {
      //   icon = '';
      // } else if (now.difference(sunset).inSeconds >= 0 ||
      //       now.difference(sunrise).inSeconds <= 0) {
      //   icon = '';
      // } else {
      //   icon = '';
      // }
    } else {
      wi = [
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/D200PartlySunnyV2.svg',
        'https://assets.msn.cn/weathermapdata/1/static/weather/Icons/taskbar_v10/Condition_Card/PartlyCloudyNightV2.svg',
      ];

      if (al == '早') {
        icon = wi[0];
      } else if (al == '晚') {
        icon = wi[1];
      } else if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        icon = wi[1];
      } else {
        icon = wi[0];
      }
    }

    return SvgPicture.network(
      icon,
      fit: BoxFit.cover,
      height: hw ?? 80,
      width: hw ?? 80,
    );
  }
}
