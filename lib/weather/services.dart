part of weather;

Future<dio.Response<dynamic>> getCurrentLocationService() {
  ApiRequest api = ApiRequest();

  return api.get(
      'https://assets.msn.cn/service/v1/news/users/me/locations?apikey=0QfOX3Vn51YCzitbLaRkTTBadtWpgTN8NZLW0C1SEM&activityId=93F5254A-4AC8-4658-8B94-CB07AE1032D9&ocid=pdp-peregrine&cm=zh-cn&it=edgeid&user=m-08EAECDBDCCB6CF3117CFFBFDD196D4A&autodetect=true');
}

Future<dio.Response<dynamic>> listSuggestionService({
  required String q,
}) {
  ApiRequest api = ApiRequest();

  return api.get(
      'https://cn.bing.com/api/v6/Places/AutoSuggest?appid=EDEC3CB74CF190BBBE26DF7938F3D961E925F593&count=10&q=$q&localcircularview=40,116,100&setmkt=zh-cn&setlang=zh-cn&types=Place,Address,Business&abbrtext=1&structuredaddress=true&strucaddrread=1&setflight');
}

Future<dio.Response<dynamic>> addLocationService({
  required Map<String, dynamic> data,
}) {
  ApiRequest api = ApiRequest();

  return api.post(
    'https://assets.msn.cn/service/graph/actions?apikey=0QfOX3Vn51YCzitbLaRkTTBadtWpgTN8NZLW0C1SEM&activityId=47808819-D817-400C-AEC4-2013E9E3F2C4&ocid=pdp-peregrine&cm=zh-cn&it=edgeid&user=m-08EAECDBDCCB6CF3117CFFBFDD196D4A',
    data: data,
  );
}

Future<dio.Response<dynamic>> removeLocationService({
  required double lat,
  required double lon,
}) {
  ApiRequest api = ApiRequest();

  return api.delete(
      'https://assets.msn.cn/service/graph/actions?%24filter=actionType+eq+%27Follow%27+and+%28definitionName+eq+%27$lat%2C$lon%27%29+and+%28targetType+eq+%27Location%27%29&apikey=0QfOX3Vn51YCzitbLaRkTTBadtWpgTN8NZLW0C1SEM&activityId=FEDA56CD-D99B-4AF1-AE1F-9D552BDCE51A&ocid=pdp-peregrine&cm=zh-cn&it=edgeid&user=m-08EAECDBDCCB6CF3117CFFBFDD196D4A');
}

Future<dio.Response<dynamic>> getWeatherService({
  required double lat,
  required double lon,
}) {
  ApiRequest api = ApiRequest();

  return api.get(
      'https://api.msn.cn/weather/overview?apikey=j5i4gDqHL6nGYwx5wi5kRhXjtf2c5qgFX9fzfk0TOo&activityId=93F5254A-4AC8-4658-8B94-CB07AE1032D9&ocid=msftweather&cm=zh-cn&it=edgeid&user=m-08EAECDBDCCB6CF3117CFFBFDD196D4A&units=C&appId=9e21380c-ff19-4c78-b4ea-19558e93a5d3&wrapodata=false&includemapsmetadata=true&cuthour=true&regioncategories=alert%2Ccontent&feature=lifeday&lifeDays=2&lifeModes=50&includestorm=true&distanceinkm=0&regionDataCount=20&orderby=distance&days=10&pageOcid=prime-weather%3A%3Aweathertoday-peregrine&source=weather_csr&hours=24&region=cn&market=zh-cn&locale=zh-cn&lat=$lat&lon=$lon');
}

Future<dio.Response<dynamic>> getDailyWeatherService({
  required double lat,
  required double lon,
}) {
  ApiRequest api = ApiRequest();

  return api.get(
      'https://assets.msn.cn/service/weather/dailytrend?apiKey=j5i4gDqHL6nGYwx5wi5kRhXjtf2c5qgFX9fzfk0TOo&appid=9e21380c-ff19-4c78-b4ea-19558e93a5d3&ocid=msftweather&market=%E5%86%85%E8%92%99%E5%8F%A4%E8%87%AA%E6%B2%BB%E5%8C%BA&locale=zh-cn&region=%E5%86%85%E8%92%99%E5%8F%A4%E8%87%AA%E6%B2%BB%E5%8C%BA&lon=$lon&lat=$lat&units=C&days=10');
}
