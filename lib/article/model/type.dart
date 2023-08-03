part of article;

class TypeModel {
  int? id;
  String? name;

  TypeModel({this.id, this.name});

  TypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
