part of home;

class HomeControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
