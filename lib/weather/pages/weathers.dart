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
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 33, 70, 103),
            ),
            padding: const EdgeInsets.all(15),
            child: () {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        InkWell(
                          onTap: () =>
                              Get.toNamed('/weather/search')!.then((value) {
                            if (value != null) {
                              controller.searchBack(value);
                            }
                          }),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '添加城市',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    ...controller.weathers.map((e) {
                      return InkWell(
                        onTap: () => controller.goBack(e),
                        child: ItemWidget(weather: e),
                      );
                    }).toList(),
                  ],
                );
              }
            }(),
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

      isLoading = false;
      update();
    });
  }

  searchBack(value) {
    locations.add(value);
    int index = locations.length - 1;
    storage.set('locations', locations);
    storage.set('location_index', index);

    Get.back(result: index);
  }

  goBack(value) {
    int index = locations.indexOf(value['location']);
    storage.set('location_index', index);

    Get.back(result: index);
  }
}
