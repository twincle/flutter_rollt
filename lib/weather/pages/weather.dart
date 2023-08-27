part of weather;

class WeatherPage extends GetView<WeatherPageController> {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: const TopBarWidget(text: '天气'),
          body: () {
            if (controller.isLoading) {
              return Container(
                decoration: const BoxDecoration(
                  color: weatherBackgroundColor,
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: BgWidget(
                      almanac: controller.weather['almanac'],
                      cap: controller.weather['cap'],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Text(
                              controller.locationStr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              child: Container(
                                child: controller.locations.isEmpty
                                    ? const Text(
                                        '更多天气点这',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.arrow_drop_down_circle_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                              ),
                              onTap: () {
                                Get.toNamed('/weather/search')!.then((value) {
                                  if (value != null) {
                                    controller.loadLocation(value);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        TempWidget(weather: controller.weather),
                        FeelWidget(weather: controller.weather),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white24,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Colors.white10,
                          ),
                          height: 250,
                          child: DefaultTabController(
                            length: 2,
                            child: Scaffold(
                              appBar: const PreferredSize(
                                preferredSize: Size.fromHeight(42),
                                child: TabBar(
                                  isScrollable: true,
                                  labelColor: Colors.white,
                                  tabs: [
                                    Tab(text: '24小时天气预报'),
                                    Tab(text: '10天天气预报'),
                                  ],
                                  unselectedLabelColor: Colors.white54,
                                ),
                              ),
                              backgroundColor: Colors.transparent,
                              body: TabBarView(
                                children: [
                                  HourlyWidget(
                                    almanac: controller.weather['almanac'],
                                    current: controller.weather['current'],
                                    forecast: controller.weather['forecast'],
                                  ),
                                  DailyWidget(
                                    forecast: controller.weather['forecast'],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        LifeWidget(life: controller.weather['life']),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              );
            }
          }(),
        );
      },
    );
  }
}

class WeatherPageController extends GetxController {
  bool isLoading = true;
  Storage storage = Storage();

  late List<dynamic> locations;
  late int index;
  Map<String, dynamic> location = {};
  late String locationStr;

  Map<String, dynamic> _w = {};
  Map<String, dynamic> weather = {};

  List<dynamic> _d = [];

  @override
  void onInit() {
    super.onInit();

    locations = storage.get('locations') ?? [];
    index = storage.get('location_index') ?? 0;

    if (locations.isEmpty) {
      loadWeather();
    } else {
      location = locations[index];
      loadWeather(loc: location);
    }
  }

  void loadLocation(Map<String, dynamic> loc) {
    isLoading = true;
    update();

    locations.add(loc);
    index = locations.length - 1;
    storage.set('locations', locations);
    storage.set('location_index', index);

    location = loc;
    loadWeather(loc: loc);
  }

  void loadWeather({
    Map<String, dynamic>? loc,
  }) {
    Future promise;

    if (locations.isEmpty) {
      promise = getCurrentLocationService().then((value) {
        location = (value.data as List<dynamic>)[0];

        if (location['country'] == '中华人民共和国') {
          locationStr = '${location['city']} ${location['state']}  ';
        } else {
          locationStr =
              '${location['city']} ${location['state']} ${location['country']}  ';
        }

        return getWeatherService(
          lat: location['latitude'],
          lon: location['longitude'],
        );
      });
    } else {
      if (loc!['country'] == '中华人民共和国') {
        locationStr = '${loc['district']} ${loc['city']} ${loc['province']}  ';
      } else {
        locationStr =
            '${loc['district']} ${loc['city']} ${loc['province']} ${loc['country']}  ';
      }

      promise = getWeatherService(lat: loc['latitude'], lon: loc['longitude']);
    }

    promise.then((value) {
      _w = (value.data as Map<String, dynamic>)['responses'][0]['weather'][0];

      onWeather();
      return getDailyWeatherService(
        lat: location['latitude'],
        lon: location['longitude'],
      );
    }).then((value) {
      _d = (value.data as Map<String, dynamic>)['value'][0]['responses'][0]
          ['average'][0]['days'];

      isLoading = false;
      update();
    }).catchError((e) {
      isLoading = false;
      update();
    });
  }

  void onWeather() {
    weather = {
      'almanac': _w['forecast']['days'][0]['almanac'],
      'current': _w['current'],
      'temp': _w['current']['temp'],
      'cap': _w['current']['cap'],
      'nowcasting': _w['nowcasting'],
      'forecast': _w['forecast']['days'],
      'daily': _d,
      'dayw': _w['forecast']['days'][0]['daily']['day']['cap'],
      'nightw': _w['forecast']['days'][0]['daily']['night']['cap'],
      'isDnSame': _w['forecast']['days'][0]['daily']['day']['cap'] ==
          _w['forecast']['days'][0]['daily']['night']['cap'],
      'tempHi': _w['forecast']['days'][0]['daily']['tempHi'],
      'tempLo': _w['forecast']['days'][0]['daily']['tempLo'],
      'rh': _w['current']['rh'],
      'feels': _w['current']['feels'],
      'pvdrWindDir': _w['current']['pvdrWindDir'],
      'pvdrWindSpd': _w['current']['pvdrWindSpd'],
      'aqi': _w['current']['aqi'],
      'baro': _w['current']['baro'],
      'vis': _w['current']['vis'],
      'life': _w['lifeDaily']['days'][0],
    };
  }
}
