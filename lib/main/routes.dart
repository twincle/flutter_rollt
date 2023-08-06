part of main;

List<GetPage<dynamic>> getPages = [
  GetPage(
    bindings: [
      MainControllerBinding(),
    ],
    name: '/',
    page: () => const MainPage(),
  ),
  ...article.getPages,
  ...home.getPages,
  ...inquiry.getPages,
];
