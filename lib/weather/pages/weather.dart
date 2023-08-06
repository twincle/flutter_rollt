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
              return Container(
                decoration: const BoxDecoration(
                  color: weatherBackgroundColor,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      /** 
                       * https://assets.msn.cn/weathermapdata/1/static/background/mobile/Cloudy%20Night1.png
                       */
                      image: NetworkImage(
                        'https://assets.msn.cn/weathermapdata/1/static/background/mobile/mostcloudy_sunset1.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
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
                                          Icons.arrow_drop_down_circle_outlined,
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
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(controller.weather['temp'] as double).floor()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 80,
                              ),
                            ),
                            const Text(
                              '  ℃',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.weather['dayw'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              controller.weather['isDnSame']
                                  ? ''
                                  : '转${controller.weather['nightw']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '  ${(controller.weather['tempHi'] as double).floor()}℃ / ${(controller.weather['tempLo'] as double).floor()}℃',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  '湿度： ${(controller.weather['rh'] as double).floor()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  '体感： ${(controller.weather['feels'] as double).floor()}℃',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  '风速： ${controller.weather['pvdrWindDir']}${controller.weather['pvdrWindSpd']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  '气压： ${(controller.weather['baro'] as double).floor()}帕',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  '能见度： ${controller.weather['vis']}公里',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  '空气质量： ${(controller.weather['aqi'] as double).floor()}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
      'temp': _w['current']['temp'],
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
    };
  }
}
