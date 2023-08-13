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
  final List<FlSpot> fs = [];

  double barSpotX = 0;
  Widget axisTitle = Container();

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() {
    double index = 0;
    double minY = double.infinity;
    double tempHi = -283, tempLo = 100;

    void processData(double temp) {
      index++;

      fs.add(FlSpot(index, temp));

      if (temp < minY) minY = temp;
      if (temp > tempHi) tempHi = temp;
      if (temp < tempLo) tempLo = temp;
    }

    processData(widget.current['temp']);

    for (int i = 0; i < widget.forecast.length; i++) {
      List<dynamic> h = (widget.forecast[i]['hourly'] ?? []) as List<dynamic>;

      if (h.isNotEmpty) {
        for (int j = 0; j < h.length; j++) {
          double k = h[j]['temp'];

          processData(k);
        }
      }
    }

    y = minY - 2;
    hi = tempHi;
    lo = tempLo;

    // setState(() {
    // axisTitle = axisTitleWidgets(1);
    // });
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

  Widget axisTitleWidgets() {
    TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 30,
    );
    Widget current = Row(
      children: [
        const SizedBox(width: 15),
        IconWidget(
          almanac: widget.almanac,
          cap: widget.current['cap'],
          hw: 30,
        ),
        const SizedBox(width: 15),
        Text(
          '${(widget.current['temp'] as double).floor()}',
          style: textStyle,
        ),
      ],
    );

    try {
      if (barSpotX == 1) {
        return current;
      } else {
        return Container();
      }
    } catch (e) {
      return current;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          // child: axisTitleWidgets(),
        ),
        SizedBox(
          height: 150,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  barWidth: 2,
                  color: Colors.yellow.shade200,
                  dotData: const FlDotData(show: false),
                  isCurved: true,
                  spots: fs,
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.yellow.shade200,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      TextStyle textStyle = const TextStyle(
                        color: Colors.black87,
                      );

                      // setState(() {
                      // axisTitle = axisTitleWidgets(barSpot.x);
                      // barSpotX = barSpot.x;
                      // });

                      if (barSpot.y == hi) {
                        return LineTooltipItem(
                          '最高：${barSpot.y.toInt()}℃',
                          textStyle,
                        );
                      } else if (barSpot.y == lo) {
                        return LineTooltipItem(
                          '最低：${barSpot.y.toInt()}℃',
                          textStyle,
                        );
                      } else {
                        return LineTooltipItem(
                          '${barSpot.y.toInt()}℃',
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
                  // axisNameWidget: axisTitle,
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
