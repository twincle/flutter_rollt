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
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: ListView(
        children: [
          // Container(
          //   margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          //   child: const Text(
          //     '10天预报',
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // const Divider(
          //   color: Colors.white24,
          // ),
          // SizedBox(
          //   height: 150,
          //   child: Column(
          //     children: [
          //       Expanded(
          //         child: LineChart(
          //           LineChartData(
          //             borderData: FlBorderData(
          //               show: false,
          //             ),
          //             gridData: const FlGridData(
          //               show: false,
          //             ),
          //             lineBarsData: [
          //               LineChartBarData(
          //                 isCurved: true,
          //                 color: Colors.yellow,
          //                 barWidth: 5,
          //                 dotData: const FlDotData(
          //                   show: false,
          //                 ),
          //                 spots: const [
          //                   FlSpot(1, 1),
          //                   FlSpot(2, 1.5),
          //                   FlSpot(3, 1.4),
          //                   FlSpot(4, 3.4),
          //                   FlSpot(5, 2),
          //                   FlSpot(6, 2.2),
          //                   FlSpot(7, 1.8),
          //                 ],
          //               ),
          //               LineChartBarData(
          //                 isCurved: true,
          //                 color: Colors.red,
          //                 barWidth: 5,
          //                 dotData: const FlDotData(
          //                   show: false,
          //                 ),
          //                 spots: const [
          //                   FlSpot(1, 2),
          //                   FlSpot(2, 2.5),
          //                   FlSpot(3, 0.4),
          //                   FlSpot(4, 1.4),
          //                   FlSpot(5, 1),
          //                   FlSpot(6, 3.2),
          //                   FlSpot(7, 2.8),
          //                 ],
          //               ),
          //             ],
          //             maxX: 8,
          //             maxY: 4,
          //             minX: 0,
          //             minY: 0,
          //             titlesData: const FlTitlesData(
          //               show: false,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // Stack(
          //   children: [
          //     // Positioned(
          //     //   height: 100,
          //     //   left: 0,
          //     //   top: 0,
          //     //   width: 100,
          //     //   child: Container(),
          //     // ),
          //   ],
          // ),
          SizedBox(
            height: 190,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...weather.map(
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
                            weather: e['daily']['day']['cap'],
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
        ],
      ),
    );
  }
}
