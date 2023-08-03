part of main;

class MainControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());

    Get.lazyPut(() => home.HomePageController());
    Get.lazyPut(() => article.ArticlesPageController());
    Get.lazyPut(() => inquiry.InquiriesPageController());
  }
}
