part of weather;

class DailyWidget extends StatelessWidget {
  final List<dynamic> weather;

  const DailyWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    Map<int, String> week = {
      1: '周一',
      2: '周二',
      3: '周三',
      4: '周四',
      5: '周五',
      6: '周六',
      7: '周日',
    };

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white24,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        color: Colors.white10,
      ),
      height: 240,
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: const Text(
              '10天预报',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const Divider(
            color: Colors.white24,
          ),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...weather.map((e) {
                  DateTime now = DateTime.now();
                  DateTime dt = DateTime.parse(
                      '${(e['daily']['valid'] as String).substring(0, 19)}Z');

                  return Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                    child: Column(
                      children: [
                        Text(
                          now.day == dt.day
                              ? '今日'
                              : '${dt.day}日${week[dt.weekday]}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IconWidget(
                          al: '早',
                          almanac: e['almanac'],
                          hw: 25,
                          weather: e['daily']['day']['cap'],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${(e['daily']['tempHi'] as double).floor()}℃',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${(e['daily']['tempLo'] as double).floor()}℃',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IconWidget(
                          al: '晚',
                          almanac: e['almanac'],
                          hw: 25,
                          weather: e['daily']['night']['cap'],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.water_drop_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${(e['daily']['precip'] as double).floor()}%',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
