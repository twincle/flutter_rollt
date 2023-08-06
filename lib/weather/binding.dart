part of weather;

class WeatherControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherPageController());
  }
}
