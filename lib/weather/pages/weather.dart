part of weather;

class WeatherPage extends GetView<WeatherPageController> {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherPageController>(
      builder: (controller) {
        return const Scaffold(
          appBar: TopBarWidget(text: '天气'),
          body: Center(),
        );
      },
    );
  }
}

class WeatherPageController extends GetxController {
  Storage storage = Storage();
  late List<Point> locations;

  @override
  void onInit() {
    super.onInit();

    locations = storage.get('location') ?? [];

    loadWeather();
  }

  void loadWeather() {
    if (locations.isEmpty) {
      late Map<String, dynamic> location;
      late Map<String, dynamic> weather;
      getCurrentLocationService().then((value) {
        location = (value.data as List<dynamic>)[0];

        return getWeatherService(
          lat: location['latitude'],
          lon: location['longitude'],
        );
      }).then((value) {
        weather = (value.data as Map<String, dynamic>)['responses'][0];

        print(weather);
      });
    } else {}
  }
}
