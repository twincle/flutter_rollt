part of inquiry;

class InquiriesPage extends GetView<InquiriesPageController> {
  const InquiriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InquiriesPageController>(
      builder: (controller) {
        return const Scaffold(
          appBar: TopBarWidget(text: 'RollT'),
          body: Center(),
        );
      },
    );
  }
}

class InquiriesPageController extends GetxController {}
