part of weather;

class BgWidget extends StatelessWidget {
  final String cap;
  final Map<String, dynamic> almanac;

  const BgWidget({super.key, required this.cap, required this.almanac});

  @override
  Widget build(BuildContext context) {
    String bg = '';

    final now = DateTime.now();
    final sunrise = DateTime.parse(almanac['sunrise']!);
    final sunset = DateTime.parse(almanac['sunset']!);

    if (cap.contains('晴')) {
      if (now.difference(sunrise).inSeconds < 0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds >
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Sunny%20Night.png';
      } else if (now
                  .difference(sunset.add(const Duration(hours: -1)))
                  .inSeconds >=
              0 &&
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds <=
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlysunny_sunset1.png';
      } else {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Sunny-bg.png';
      }
    } else if (cap.contains('雨')) {
      if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Rain%20Night.png';
      } else {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Rain-bg.png';
      }
    } else if (cap.contains('雪')) {
      if (now.difference(sunset).inSeconds >= 0 ||
          now.difference(sunrise).inSeconds <= 0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Snow%20Night.png';
      } else {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Snow-bg.png';
      }
    } else if (cap.contains('云')) {
      if (now.difference(sunrise).inSeconds < 0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds >
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Cloudy%20Night1.png';
      } else if (now
                  .difference(sunset.add(const Duration(hours: -1)))
                  .inSeconds >=
              0 &&
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds <=
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlysunny_sunset1.png';
      } else {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/partlySunny_cloud.png';
      }
    } else if (cap.contains('阴')) {
      if (now.difference(sunrise).inSeconds < 0 ||
          now.difference(sunset.add(const Duration(minutes: 30))).inSeconds >
              0) {
        bg =
            'https://assets.msn.cn/weathermapdata/1/static/background/mobile/Cloudy%20Night1.png';
      } else if (now
                  .difference(sunset.add(const Duration(hours: -1)))
                  .inSeconds >=
              0 &&
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
