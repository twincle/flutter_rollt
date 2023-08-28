part of weather;

class ItemWidget extends StatelessWidget {
  final Map<String, dynamic> weather;

  const ItemWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    String locationStr = '';

    locationStr =
        '${weather['location']['addrStr']}${weather['location']['addrDetailStr']}';

    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: BgWidget(
                almanac: weather['almanac'],
                cap: weather['cap'],
                fit: BoxFit.fill,
                radius: 10,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        locationStr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        weather['temp'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                      const Text(
                        ' ℃',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Column(
                        children: [
                          IconWidget(
                            almanac: weather['almanac'],
                            cap: weather['cap'],
                            hw: 50,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            weather['cap'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
