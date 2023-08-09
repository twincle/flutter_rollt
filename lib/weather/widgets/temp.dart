part of weather;

class TempWidget extends StatelessWidget {
  final Map<String, dynamic> temp;

  const TempWidget({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconWidget(
                weather: temp['cap'],
                almanac: temp['almanac'],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                child: Text(
                  '${(temp['temp'] as double).floor()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 80,
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
                    temp['cap'],
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
            bottom: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                temp['dayw'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                temp['isDnSame'] ? '' : '转${temp['nightw']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                '    ${(temp['tempHi'] as double).floor()}℃ / ${(temp['tempLo'] as double).floor()}℃',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
