part of weather;

class WeatherControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPageController());
    Get.lazyPut(() => WeatherPageController());
    Get.lazyPut(() => WeathersPageController());
  }
}
