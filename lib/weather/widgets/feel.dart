part of weather;

class FeelWidget extends StatelessWidget {
  final Map<String, dynamic> weather;

  const FeelWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
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
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  top: 5,
                ),
                child: Text(
                  '湿度：${(weather['rh'] as double).floor()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  top: 5,
                ),
                child: Text(
                  '体感：${(weather['feels'] as double).floor()}℃',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  top: 5,
                ),
                child: Text(
                  '风速：${weather['pvdrWindDir']}${weather['pvdrWindSpd']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  top: 5,
                ),
                child: Text(
                  '气压：${(weather['baro'] as double).floor()}百帕',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  top: 5,
                ),
                child: Text(
                  '能见度：${weather['vis']}公里',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  top: 5,
                ),
                child: Text(
                  '空气质量：${(weather['aqi'] as double).floor()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
