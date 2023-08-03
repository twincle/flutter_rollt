part of article;

class ArticleCardWidget extends StatelessWidget {
  final ArticleModel article;

  const ArticleCardWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            () {
              if (article.appendixUrl.isNotEmpty) {
                return AspectRatio(
                  aspectRatio: 2.5 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          article.appendixUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }(),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Text(
                article.title!,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 8),
              child: Text(
                article.docabstract!,
                maxLines: 4,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '来源 ${article.source} ${article.author}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '发表于  ${article.docpubTime}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Get.toNamed(
            '/article',
            arguments: {
              'article': article,
            },
          );
        },
      ),
    );
  }
}
