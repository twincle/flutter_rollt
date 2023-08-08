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
                    child: WeatherBgWidget(
                      almanac: controller.weather['almanac'],
                      weather: controller.weather['cap'],
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
                                Container(
                                  child: controller.locations.isEmpty
                                      ? InkWell(
                                          onTap: () =>
                                              Get.toNamed('/weather/search'),
                                          child: const Text(
                                            '更多天气信息请点这',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () =>
                                              Get.toNamed('/weather/weathers'),
                                          child: const Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }(),
                        TempWidget(temp: controller.weather),
                        FeelWidget(weather: controller.weather),
                        ForeDaysWidget(weather: controller.weather['forecast']),
                        LifeWidget(life: controller.weather['life']),
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

  @override
  void onInit() {
    super.onInit();

    locations = storage.get('location') ?? [];

    loadWeather();
  }

  void loadWeather() {
    if (locations.isEmpty) {
      getCurrentLocationService().then((value) {
        location = (value.data as List<dynamic>)[0];

        return getWeatherService(
          lat: location['latitude'],
          lon: location['longitude'],
        );
      }).then((value) {
        _w = (value.data as Map<String, dynamic>)['responses'][0]['weather'][0];

        onWeather();
        isLoading = false;
        update();
      });
    } else {
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
  }

  void onWeather() {
    weather = {
      'almanac': _w['forecast']['days'][0]['almanac'],
      'temp': _w['current']['temp'],
      'cap': _w['current']['cap'],
      'forecast': _w['forecast']['days'],
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
