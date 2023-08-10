part of article;

class ArticlesPage extends GetView<ArticlesPageController> {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticlesPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: const TopBarWidget(
            text: '文章',
          ),
          body: () {
            if (controller.isLoadingUserTags) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Scaffold(
                appBar: TabBar(
                  controller: controller.tabController,
                  indicator: const BoxDecoration(
                    color: primaryColor,
                  ),
                  isScrollable: true,
                  labelColor: Colors.white,
                  tabs: controller.tabs,
                  unselectedLabelColor: primaryColor,
                  onTap: (i) => controller.onLoadMore(i: i),
                ),
                body: TabBarView(
                  controller: controller.tabController,
                  children: controller.typeArticlesList.values
                      .map(
                        (e) => KeepAliveWidget(
                          child: ListView(
                            children: [
                              ...e
                                  .map((f) => controller.isCard
                                      ? ArticleCardWidget(article: f)
                                      : ArticleItemWidget(article: f))
                                  .toList(),
                              InkWell(
                                onTap: () => controller.onLoadMore(),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        controller.isLoading
                                            ? Icons.download
                                            : Icons.add_circle_outline,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(controller.isLoading
                                          ? '正在加载...'
                                          : '点击加载更多'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: primaryColor,
                  mini: true,
                  tooltip: '切换${controller.isCard ? "列表" : "卡片"}模式',
                  onPressed: controller.isCardItem,
                  child: const Icon(
                    Icons.change_circle_outlined,
                    size: 30,
                  ),
                ),
              );
            }
          }(),
        );
      },
    );
  }
}

class ArticlesPageController extends GetxController
    with GetTickerProviderStateMixin {
  bool isLoadingUserTags = true;
  bool isLoading = true;
  int index = 0;
  final Map<TypeModel, List<ArticleModel>> typeArticlesList = {};

  List<Tab> tabs = [];
  late TabController tabController;
  List<int> pages = [];

  bool isCard = false;

  @override
  void onInit() {
    super.onInit();

    loadTypes();
  }

  @override
  void onClose() {
    tabController.dispose();

    super.onClose();
  }

  void loadTypes() {
    listTypeService().then((value) {
      Map<String, dynamic> responseData = jsonDecode(value.data);
      ApiRequest.callback(
        status: 0,
        message: '',
        function: () {
          List<TypeModel> types = (responseData['category'] as List<dynamic>)
              .map((e) => TypeModel.fromJson(e))
              .toList();

          for (int i = 0; i < types.length; i++) {
            typeArticlesList.addAll({types[i]: []});
            tabs.add(Tab(child: Text(types[i].name!)));
            pages.add(1);
          }

          tabController = TabController(
            initialIndex: 0,
            length: tabs.length,
            vsync: this,
          );

          tabController.addListener(() {
            if (tabController.animation!.value == tabController.index) {
              onLoadMore(i: tabController.index);
            }
          });

          onLoadMore(i: index);
        },
      );
    }).catchError((e) {});
  }

  void onLoadMore({int? i}) {
    if (i == null) {
      return loadMore();
    }

    index = i;
    List<ArticleModel> articlesList = typeArticlesList.values.toList()[index];
    if (articlesList.isEmpty) {
      loadMore(i: index);
    }
  }

  void loadMore({int? i}) {
    isLoading = true;
    update();

    index = i ?? index;
    List<ArticleModel> articlesList = typeArticlesList.values.toList()[index];
    int? typeId = typeArticlesList.keys.toList()[index].id;

    listArticlesService(
      typeId: typeId!,
      page: pages[index],
    ).then((value) {
      Map<String, dynamic> responseData = jsonDecode(value.data);
      ApiRequest.callback(
        status: responseData['status'],
        message: responseData['message'],
        function: () {
          articlesList.addAll((responseData['datas'] as List<dynamic>)
              .map((e) => ArticleModel.fromJson(e))
              .toList());

          isLoadingUserTags = false;
          isLoading = false;
          pages[index]++;
          update();
        },
      );
    }).catchError((e) {
      isLoadingUserTags = false;
      isLoading = false;
      update();
    });
  }

  void isCardItem() {
    isCard = !isCard;
    update();
  }
}
