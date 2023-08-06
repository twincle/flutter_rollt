part of home;

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) {
        return Scaffold(
          appBar: const TopBarWidget(text: 'RollT'),
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => Get.toNamed('/weather'),
                  child: const Text('天气'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomePageController extends GetxController {}
