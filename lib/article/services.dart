part of article;

Future<dio.Response<dynamic>> listTypeService() {
  ApiRequest api = ApiRequest();

  return api.post('https://apppc.cnr.cn/home/category');
}

Future<dio.Response<dynamic>> listArticlesService({
  required int typeId,
  required int page,
  int? lastId,
}) {
  ApiRequest api = ApiRequest();

  return api.post(
    'https://apppc.cnr.cn/channel/list',
    data: {
      'id': typeId,
      'pageIndex': page,
      'perPage': 10,
      'lastNewsId': lastId ?? 0,
    },
  );
}

Future<dio.Response<dynamic>> getArticleService({
  required String id,
}) {
  ApiRequest api = ApiRequest();

  return api.post(
    'https://apppc.cnr.cn/pc/detail',
    data: {
      'docpubUrl': id,
    },
  );
}
