part of main;

List<GetPage<dynamic>> getPages = [
  GetPage(
    binding: MainControllerBinding(),
    name: '/',
    page: () => const MainPage(),
  ),
  ...article.getPages,
  ...home.getPages,
  ...inquiry.getPages,
];
