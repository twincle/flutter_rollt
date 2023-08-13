part of weather;

class DailyWidget extends StatelessWidget {
  final List<dynamic> forecast;

  const DailyWidget({super.key, required this.forecast});

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
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: SizedBox(
        height: 190,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...forecast.map(
              (e) {
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
                        cap: e['daily']['day']['cap'],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${(e['daily']['tempHi'] as double).floor()}℃',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${(e['daily']['tempLo'] as double).floor()}℃',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IconWidget(
                        al: '晚',
                        almanac: e['almanac'],
                        hw: 25,
                        cap: e['daily']['night']['cap'],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.water_drop_outlined,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${(e['daily']['precip'] as double).floor()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
