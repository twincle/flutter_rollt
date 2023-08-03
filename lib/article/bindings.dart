part of article;

class ArticleControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ArticlePageController());
    Get.lazyPut(() => ArticlesPageController());
  }
}
