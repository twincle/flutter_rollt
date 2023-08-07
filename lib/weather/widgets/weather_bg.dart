part of weather;

class WeatherBgWidget extends StatelessWidget {
  final String weather;
  final Map<String, dynamic> almanac;

  const WeatherBgWidget(
      {super.key, required this.weather, required this.almanac});

  @override
  Widget build(BuildContext context) {
    String bg = '';

    final now = DateTime.now();
    final sunrise = DateTime.parse(almanac['sunrise']!);
    final sunset = DateTime.parse(almanac['sunset']!);

    /** 
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/Sunny-bg.png
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlySunny_cloud.png
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/Cloudy1.png
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/Rain-bg.png
     * 
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlysunny_sunset1.png
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/mostcloudy_sunset1.png
     * 
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/Sunny%20Night.png
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/Cloudy%20Night1.png
     * https://assets.msn.cn/weathermapdata/1/static/background/mobile/Rain%20Night.png
     */
    if (weather.contains('晴')) {
      if (now.difference(sunrise).inSeconds < 0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds >
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Sunny%20Night.png';
      } else if (now
                  .difference(sunset.add(const Duration(hours: -1)))
                  .inSeconds >=
              0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds <=
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlysunny_sunset1.png';
      } else {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Sunny-bg.png';
      }
    } else if (weather.contains('雨')) {
      if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Rain%20Night.png';
      } else {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Rain-bg.png';
      }
    } else if (weather.contains('云')) {
      if (now.difference(sunrise).inSeconds < 0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds >
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Cloudy%20Night1.png';
      } else if (now
                  .difference(sunset.add(const Duration(hours: -1)))
                  .inSeconds >=
              0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds <=
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlysunny_sunset1.png';
      } else {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlySunny_cloud.png';
      }
    } else if (weather.contains('阴')) {
      if (now.difference(sunrise).inSeconds < 0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds >
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Cloudy%20Night1.png';
      } else if (now
                  .difference(sunset.add(const Duration(hours: -1)))
                  .inSeconds >=
              0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds <=
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/mostcloudy_sunset1.png';
      } else {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Cloudy1.png';
      }
    } else {
      bg =
          'https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlysunny_sunset1.png';
    }

    return Image.network(
      bg,
      fit: BoxFit.cover,
    );
  }
}
