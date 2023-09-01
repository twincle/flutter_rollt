part of weather;

class LifeWidget extends StatelessWidget {
  final Map<String, dynamic> life;

  const LifeWidget({super.key, required this.life});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
    );

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
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                '带伞指数：${life['umbrellaIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '外出指数：${life['outdoorIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '穿衣指数：${life['dressingIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '晾晒指数：${life['dryingIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '垂钓指数：${life['fishingIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '紫外线指数：${life['uvIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 5),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                '感冒指数：${life['coldIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '交通指数：${life['trafficIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '洗车指数：${life['carWashingIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '中暑指数：${life['heatIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              Text(
                '风冷指数：${life['windChillIndex']['summary']}',
                style: textStyle,
              ),
              const SizedBox(height: 5),
            ],
          ),
        ],
      ),
    );
  }
}
