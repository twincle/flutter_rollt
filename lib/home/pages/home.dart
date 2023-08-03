part of home;

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) {
        return const Scaffold(
          appBar: TopBarWidget(text: 'RollT'),
          body: Center(),
        );
      },
    );
  }
}

class HomePageController extends GetxController {}
