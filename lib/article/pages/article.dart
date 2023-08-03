part of article;

class ArticlePage extends GetView<ArticlePageController> {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticlePageController>(
      builder: (controller) {
        return Scaffold(
          appBar: TopBarWidget(
            text: controller.isLoading ? '正在加载...' : controller.article.title!,
          ),
          body: () {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  Text(
                    controller.detail.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Row(
                      children: [
                        Text(controller.article.channelName!),
                        const Text('  '),
                        Text(controller.article.source!),
                        const Text('  '),
                        Text(controller.article.author!),
                        Text(controller.article.docpubTime!),
                      ],
                    ),
                  ),
                  () {
                    if (controller.detail.appendixUrl.isNotEmpty) {
                      return Image.network(controller.detail.appendixUrl);
                    } else {
                      return Container();
                    }
                  }(),
                  Html(
                    data: controller.detail.content,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(controller.article.docpubTime!),
                      ],
                    ),
                  ),
                ],
              );
            }
          }(),
        );
      },
    );
  }
}

class ArticlePageController extends GetxController {
  ArticleModel article = Get.arguments['article'];
  late DetailModel detail;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    int length = article.docpubUrl!.length;
    String id = article.docpubUrl!.substring(length - 24, length - 6);
    getFullArticle(id: id);
  }

  void getFullArticle({
    required String id,
  }) {
    getArticleService(id: id).then((value) {
      Map<String, dynamic> responseData = jsonDecode(value.data);
      ApiRequest.callback(
        status: responseData['status'],
        message: responseData['message'],
        function: () {
          detail = DetailModel.fromJson(responseData['datas']);

          isLoading = false;
          update();
        },
      );
    }).catchError((e) {
      isLoading = false;
      update();
    });
  }
}
