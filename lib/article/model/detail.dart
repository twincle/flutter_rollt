part of article;

class DetailModel {
  String? docpubTime;
  int? id;
  String? modelType;
  String? title;
  String? docpubUrl1;
  String? author;
  String? channelid;
  String? source;
  String? doctype;
  String? channelName;
  String? docabstract;
  late String appendixUrl;
  String? content;
  String? type;
  String? docpubUrl;

  DetailModel(
      {this.docpubTime,
      this.id,
      this.modelType,
      this.title,
      this.docpubUrl1,
      this.author,
      this.channelid,
      this.source,
      this.doctype,
      this.channelName,
      this.docabstract,
      required this.appendixUrl,
      this.content,
      this.type,
      this.docpubUrl});

  DetailModel.fromJson(Map<String, dynamic> json) {
    docpubTime = json['docpubTime'];
    id = json['id'];
    modelType = json['modelType'];
    title = json['title'];
    docpubUrl1 = json['docpubUrl1'];
    author = json['author'];
    channelid = json['channelid'];
    source = json['source'];
    doctype = json['doctype'];
    channelName = json['channelName'];
    docabstract = json['docabstract'];
    appendixUrl = json['appendixUrl'];
    content = json['content'];
    type = json['type'];
    docpubUrl = json['docpubUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['docpubTime'] = docpubTime;
    data['id'] = id;
    data['modelType'] = modelType;
    data['title'] = title;
    data['docpubUrl1'] = docpubUrl1;
    data['author'] = author;
    data['channelid'] = channelid;
    data['source'] = source;
    data['doctype'] = doctype;
    data['channelName'] = channelName;
    data['docabstract'] = docabstract;
    data['appendixUrl'] = appendixUrl;
    data['content'] = content;
    data['type'] = type;
    data['docpubUrl'] = docpubUrl;
    return data;
  }
}
