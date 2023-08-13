part of weather;

class TempWidget extends StatelessWidget {
  final Map<String, dynamic> weather;

  const TempWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    String str = weather['nowcasting']['summary'];
    str = str.substring(0, str.length - 1);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
          child: Row(
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
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weather['dayw'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                weather['isDnSame'] ? '' : '转${weather['nightw']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                '    ${(weather['tempHi'] as double).floor()}℃ / ${(weather['tempLo'] as double).floor()}℃',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 120,
          ),
          child: Text(
            str,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
