part of weather;

List<GetPage<dynamic>> getPages = [
  GetPage(
    bindings: [
      WeatherControllerBinding(),
    ],
    name: '/weather',
    page: () => const WeatherPage(),
  ),
];
