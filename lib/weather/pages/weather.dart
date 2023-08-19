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
                        () {
                          if (controller.locations.isEmpty) {
                            return Row(
                              children: [
                                Text(
                                  '${controller.location['state']} ${controller.location['city']}  ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                    child: controller.locations.isEmpty
                                        ? const Text(
                                            '更多天气信息请点这',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          )
                                        : const Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                  ),
                                  onTap: () {
                                    Get.toNamed('/weather/search')!
                                        .then((value) {
                                      if (value != null) {
                                        controller.loadLocation(value);
                                      }
                                    });
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }(),
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

  late List<Point> locations;
  Map<String, dynamic> location = {};

  Map<String, dynamic> _w = {};
  Map<String, dynamic> weather = {};

  List<dynamic> _d = [];

  @override
  void onInit() {
    super.onInit();

    locations = storage.get('locations') ?? [];

    loadWeather();
  }

  void loadLocation(Map<String, dynamic> location) {
    isLoading = true;
    update();

    storage.set('locations', location);
  }

  void loadWeather({
    Map<String, dynamic>? loc,
  }) {
    Future promise;

    if (locations.isEmpty) {
      promise = getCurrentLocationService().then((value) {
        location = (value.data as List<dynamic>)[0];

        return getWeatherService(
          lat: location['latitude'],
          lon: location['longitude'],
        );
      });
    } else {
      promise = getWeatherService(lat: loc!['lat'], lon: loc['lon']);
      // Map<String, dynamic> ln = (value.data as Map<String, dynamic>).['value'][0]['metadata'];
      // return addLocationService(data: {
      //     'actionType':'Follow',
      //     'targetType':'Location',
      //     'definitionName':'${location['latitude']},${location['longitude']}',
      //     'degree':'FavoriteLocation',
      //     'metaData':{
      //       'geoCoordinates':{
      //         'latitude':location['latitude'],
      //         'longitude':location['longitude'],
      //       },
      //       'subRegion':location['longitude'],
      //       'readLink':'https://cn.bing.com/api/v6/places/search?q=%e6%b2%b3%e5%8c%97%e7%9c%81%e6%b2%a7%e5%b7%9e%e5%b8%82%e6%b2%a7%e5%8e%bf&setLang=zh-cn&dtype=PlaceOrLandmark',
      //       'city':'沧县',
      //       'state':'河北省',
      //       'countryRegion':'中华人民共和国',
      //       'isoCode':'cn',
      //       'locationType':102,
      //       'locationTypeId':'沧县,河北省,中华人民共和国',
      //       'language':'zh-cn',
      //       'properties':{
      //         'locationType':'Place',
      //         'entitySubTypeHints':'Other',
      //       },
      //     },
      //   });
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
