part of article;

List<GetPage<dynamic>> getPages = [
  GetPage(
    bindings: [
      ArticleControllerBinding(),
    ],
    name: '/article',
    page: () => const ArticlePage(),
  ),
];
