part of weather;

class WeathersPage extends GetView<WeathersPageController> {
  const WeathersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeathersPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: const TopBarWidget(text: '天气'),
          body: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                ...controller.weathers.map((e) {
                  return ItemWidget(weather: e);
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WeathersPageController extends GetxController {
  bool isLoading = true;
  Storage storage = Storage();

  List<dynamic> locations = [];
  List<Future> promises = [];
  List<Map<String, dynamic>> weathers = [];

  @override
  void onInit() {
    super.onInit();

    locations = storage.get('locations');
    locations
        .map((e) => promises.add(getWeatherService(
              lat: e['latitude'],
              lon: e['longitude'],
            )))
        .toList();
    Future.wait(promises).then((values) {
      for (int i = 0; i < values.length; i++) {
        Map<String, dynamic> w = (values[i].data
            as Map<String, dynamic>)['responses'][0]['weather'][0];

        weathers.add({
          'location': locations[i],
          'almanac': w['forecast']['days'][0]['almanac'],
          'cap': w['current']['cap'],
          'temp': (w['current']['temp'] as double).floor(),
        });
      }
    });
  }
}
