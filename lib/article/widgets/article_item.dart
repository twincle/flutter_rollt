part of article;

class ArticleItemWidget extends StatelessWidget {
  final ArticleModel article;

  const ArticleItemWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
        height: 90,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            () {
              if (article.appendixUrl.isNotEmpty) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(article.appendixUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 100,
                );
              } else {
                return Container(width: 0);
              }
            }(),
            const Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title!,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.author!,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      const Text('  '),
                      Text(
                        article.source!.length <= 6
                            ? article.source!
                            : '${article.source!.substring(0, 6)}...',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Text(
                        article.docpubTime!,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.toNamed(
          '/article',
          arguments: {
            'article': article,
          },
        );
      },
    );
  }
}
