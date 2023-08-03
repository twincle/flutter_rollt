part of article;

class ArticleModel {
  String? doctype;
  String? docabstract;
  int? id;
  String? channelName;
  int? channelid;
  String? author;
  String? source;
  String? type;
  String? title;
  String? docpubTime;
  int? modelType;
  String? content;
  late String appendixUrl;
  String? docpubUrl;

  ArticleModel(
      {this.doctype,
      this.docabstract,
      this.id,
      this.channelName,
      this.channelid,
      this.author,
      this.source,
      this.type,
      this.title,
      this.docpubTime,
      this.modelType,
      this.content,
      required this.appendixUrl,
      this.docpubUrl});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    doctype = json['doctype'];
    docabstract = json['docabstract'];
    id = json['id'];
    channelName = json['channelName'];
    channelid = json['channelid'];
    author = json['author'];
    source = json['source'];
    type = json['type'];
    title = json['title'];
    docpubTime = json['docpubTime'];
    modelType = json['modelType'];
    content = json['content'];
    appendixUrl = json['appendixUrl'];
    docpubUrl = json['docpubUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['doctype'] = doctype;
    data['docabstract'] = docabstract;
    data['id'] = id;
    data['channelName'] = channelName;
    data['channelid'] = channelid;
    data['author'] = author;
    data['source'] = source;
    data['type'] = type;
    data['title'] = title;
    data['docpubTime'] = docpubTime;
    data['modelType'] = modelType;
    data['content'] = content;
    data['appendixUrl'] = appendixUrl;
    data['docpubUrl'] = docpubUrl;
    return data;
  }
}
