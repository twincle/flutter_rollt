part of weather;

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.blue,
      ),
    );

    return GetBuilder<SearchPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: const TopBarWidget(text: '搜索城市、地区和区域'),
          body: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    hintText: '请输入你要搜索的城市、地区和区域',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                () {
                  if (controller.isLoading) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (!controller.isWrited) {
                    return Container();
                  } else if (controller.v.isEmpty && controller.isWrited) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        '没找到结果……',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        ...controller.v.map((e) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade100,
                            ),
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 8),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e['addrDetailStr'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      () {
                                        if (e['addrStr'] == '') {
                                          return Container();
                                        } else {
                                          return Container(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: Text(
                                              e['addrStr'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }
                                      }(),
                                    ],
                                  ),
                                  const Icon(Icons.add_circle_outline),
                                ],
                              ),
                              onTap: () {
                                Get.back(result: e);
                              },
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }
                }(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SearchPageController extends GetxController {
  bool isLoading = false;
  bool isWrited = false;
  Storage storage = Storage();

  TextEditingController nameController = TextEditingController();
  String nameStr = '';

  List<dynamic> v = [];

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(() {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (nameController.text != nameStr) {
          nameStr = nameController.text;
          searchLocation(nameController.text);
        }
      });
    });
  }

  void searchLocation(String val) {
    if (val.isEmpty || val == '') {
      v = [];
      isLoading = false;
      update();

      return;
    }

    v = [];
    isLoading = true;
    isWrited = true;
    update();

    listSuggestionService(q: val).then((value) {
      List<dynamic> responseData =
          (value.data as Map<String, dynamic>)['value'];

      for (int i = 0; i < responseData.length; i++) {
        if (responseData[i]['_type'] == 'Place' &&
            responseData[i]['address'] != null &&
            responseData[i]['geo'] != null) {
          v.add({
            'country': responseData[i]['address']['addressCountry'] ?? '',
            'province': responseData[i]['address']['addressRegion'] ?? '',
            'city': responseData[i]['address']['addressSubregion'] ?? '',
            'district': responseData[i]['name'],
            'latitude': responseData[i]['geo']['latitude'],
            'longitude': responseData[i]['geo']['longitude'],
          });

          String str = '';

          if (v[i]['country'] == null || v[i]['country'].toString().isEmpty) {
            str += '';
          } else {
            str += v[i]['country'] + ' ';
          }
          if (v[i]['province'] == null || v[i]['province'].toString().isEmpty) {
            str += '';
          } else {
            str += v[i]['province'] + ' ';
          }
          if (v[i]['city'] == null || v[i]['city'].toString().isEmpty) {
            str += '';
          } else {
            str += v[i]['city'] + ' ';
          }
          if (v[i]['district'] == null || v[i]['district'].toString().isEmpty) {
            str += '';
          } else {
            str += v[i]['district'];
          }

          List<String> strs = str.split(' ');

          if (strs.length < 2) {
            v[i]['addrDetailStr'] = strs[0];
            v[i]['addrStr'] = '';
          } else if (strs.length == 2) {
            v[i]['addrDetailStr'] = strs[1];
            v[i]['addrStr'] = strs[0];
          } else {
            if (strs[0] == '中华人民共和国') {
              strs.removeAt(0);
            }
            v[i]['addrDetailStr'] = strs[strs.length - 1];
            strs[strs.length - 1] = '';
            v[i]['addrStr'] = strs.join(' ');
          }
        }
      }

      isLoading = false;
      update();
    }).catchError((e) {
      isLoading = false;
      update();
    });
  }
}
