part of weather;

class HourlyWidget extends StatefulWidget {
  final Map<String, dynamic> almanac;
  final Map<String, dynamic> current;
  final List<dynamic> forecast;

  const HourlyWidget({
    super.key,
    required this.almanac,
    required this.current,
    required this.forecast,
  });

  @override
  State<HourlyWidget> createState() => _HourlyWidgetState();
}

class _HourlyWidgetState extends State<HourlyWidget> {
  late double hi, lo;
  late double y;
  final List<dynamic> fs = [];

  // double barSpotX = 0;
  // Widget axisTitle = Container();

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() {
    double index = 0;
    double minY = double.infinity;
    double tempHi = -283, tempLo = 100;

    void processData(String cap, String timeStr, double temp) {
      index++;

      if (temp < minY) minY = temp;
      if (temp > tempHi) tempHi = temp;
      if (temp < tempLo) tempLo = temp;

      if (timeStr == '现在') {
        return fs.add([cap, timeStr, FlSpot(index, temp)]);
      }

      int time = DateTime.parse('${timeStr.substring(0, 19)}Z').hour;

      fs.add([
        cap,
        // '$time:00-${time + 1 >= 24 ? time + 1 - 24 : time + 1}:00',
        '$time点后',
        FlSpot(index, temp)
      ]);
    }

    processData(widget.current['cap'], '现在', widget.current['temp']);

    for (int i = 0; i < widget.forecast.length; i++) {
      List<dynamic> h = (widget.forecast[i]['hourly'] ?? []) as List<dynamic>;

      if (h.isNotEmpty) {
        for (int j = 0; j < h.length; j++) {
          String cap = h[j]['cap'];
          double temp = h[j]['temp'];

          processData(cap, h[j]['valid'], temp);
        }
      }
    }

    y = minY - 2;
    hi = tempHi;
    lo = tempLo;

    // setState(() {
    // axisTitle = axisTitleWidgets();
    // });
    // return axisTitleWidgets();
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    int now = DateTime.now().hour.toInt();
    late String text;

    switch (value.toInt()) {
      case 1:
        text = '现在';
      case 5:
        text = '${now + 5 >= 24 ? now + 5 - 24 : now + 5}点';
      case 9:
        text = '${now + 9 >= 24 ? now + 9 - 24 : now + 9}点';
      case 13:
        text = '${now + 13 >= 24 ? now + 13 - 24 : now + 13}点';
      case 17:
        text = '${now + 17 >= 24 ? now + 17 - 24 : now + 17}点';
      case 21:
        text = '${now + 21 >= 24 ? now + 21 - 24 : now + 21}点';
      case 25:
        text =
            '${now + 25 >= 48 ? now + 25 - 48 : (now + 1 >= 24 ? now + 1 - 24 : now + 1)}点';
      default:
        text = '';
    }

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  // Widget axisTitleWidget() {
  //   TextStyle textStyle = const TextStyle(
  //     color: Colors.white,
  //     fontSize: 30,
  //   );
  //   Widget current = Row(
  //     children: [
  //       const SizedBox(width: 15),
  //       IconWidget(
  //         almanac: widget.almanac,
  //         cap: widget.current['cap'],
  //         hw: 30,
  //       ),
  //       const SizedBox(width: 15),
  //       Text(
  //         '${(widget.current['temp'] as double).floor()}',
  //         style: textStyle,
  //       ),
  //     ],
  //   );

  //   try {
  //     if (barSpotX == 1) {
  //       return current;
  //     } else {
  //       return Container();
  //     }
  //   } catch (e) {
  //     return current;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65,
          // child: axisTitleWidget(),
        ),
        SizedBox(
          height: 140,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  barWidth: 2,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.yellow.shade300,
                        Colors.yellow.shade50,
                      ],
                    ),
                  ),
                  dotData: const FlDotData(show: false),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.yellow.shade300,
                      Colors.yellow.shade50,
                    ],
                  ),
                  isCurved: true,
                  spots: fs.map((e) => e[2] as FlSpot).toList(),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.yellow.shade300,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      TextStyle textStyle = const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      );

                      // setState(() {
                      // axisTitle = axisTitleWidgets(barSpot.x);
                      // barSpotX = barSpot.x;
                      // });

                      String cap = fs
                          .map((e) => e[0] as String)
                          .toList()[barSpot.spotIndex];
                      // String time = fs
                      //     .map((e) => e[1] as String)
                      //     .toList()[barSpot.spotIndex];
                      int temp = barSpot.y.toInt();
                      if (barSpot.y == hi) {
                        return LineTooltipItem(
                          '$cap\n最高：$temp℃',
                          textStyle,
                        );
                      } else if (barSpot.y == lo) {
                        return LineTooltipItem(
                          '$cap\n最低：$temp℃',
                          textStyle,
                        );
                      } else {
                        return LineTooltipItem(
                          '$cap\n$temp℃',
                          textStyle,
                        );
                      }
                    }).toList();
                  },
                ),
              ),
              maxX: 27,
              minX: -1,
              minY: y,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: bottomTitleWidgets,
                    reservedSize: 38,
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                topTitles: const AxisTitles(
                  // axisNameWidget: axisTitleWidget,
                  // axisNameWidget: Container(),
                  // axisNameSize: 15,
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
