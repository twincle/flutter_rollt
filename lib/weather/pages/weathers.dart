part of weather;

class WeathersPage extends GetView<WeathersPageController> {
  const WeathersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeathersPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: const TopBarWidget(text: '天气'),
          body: Container(),
        );
      },
    );
  }
}

class WeathersPageController extends GetxController {
  bool isLoading = true;
  Storage storage = Storage();

  @override
  void onInit() {
    super.onInit();

    searchLocation();
  }

  void searchLocation() {}
}
