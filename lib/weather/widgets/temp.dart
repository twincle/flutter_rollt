part of weather;

class TempWidget extends StatelessWidget {
  final Map<String, dynamic> weather;

  const TempWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    String str = weather['nowcasting']['summary'] ?? '。';
    str = str.substring(0, str.length - 1);

    TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconWidget(
              cap: weather['cap'],
              almanac: weather['almanac'],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
              child: Text(
                '${(weather['temp'] as double).floor()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '℃',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  weather['cap'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '今天${weather['dayw']}',
              style: textStyle,
            ),
            Text(
              weather['isDnSame'] ? '' : '转${weather['nightw']}',
              style: textStyle,
            ),
            Text(
              '    ${(weather['tempHi'] as double).floor()}℃ / ${(weather['tempLo'] as double).floor()}℃',
              style: textStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          str,
          style: textStyle,
        ),
        const SizedBox(height: 120),
      ],
    );
  }
}
