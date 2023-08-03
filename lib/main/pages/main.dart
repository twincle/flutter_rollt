part of main;

class MainPage extends // StatelessWidget {
    GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.index,
              children: const [
                home.HomePage(),
                article.ArticlesPage(),
                inquiry.InquiriesPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '首页',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.face),
                label: '新闻',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '查询',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            onTap: controller.changeMainIndex,
          ),
        );
      },
    );
  }
}

class MainController extends GetxController {
  int index = 0;

  changeMainIndex(int i) {
    index = i;
    update();
  }
}
