part of weather;

List<GetPage<dynamic>> getPages = [
  GetPage(
    bindings: [
      WeatherControllerBinding(),
    ],
    name: '/weather/search',
    page: () => const SearchPage(),
  ),
  GetPage(
    bindings: [
      WeatherControllerBinding(),
    ],
    name: '/weather/weather',
    page: () => const WeatherPage(),
  ),
  GetPage(
    bindings: [
      WeatherControllerBinding(),
    ],
    name: '/weather/weathers',
    page: () => const WeathersPage(),
  ),
];
