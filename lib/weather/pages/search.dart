part of weather;

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: const TopBarWidget(text: '搜索城市、地区和区域'),
          body: Container(),
        );
      },
    );
  }
}

class SearchPageController extends GetxController {
  bool isLoading = true;
  Storage storage = Storage();

  @override
  void onInit() {
    super.onInit();

    searchLocation();
  }

  void searchLocation() {}
}
