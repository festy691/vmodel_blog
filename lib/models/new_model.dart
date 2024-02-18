class NewsModel {
  final id;
  final title;
  final subtitle;
  final body;
  final date;

  NewsModel({this.id, this.title, this.subtitle, this.date, this.body});

  factory NewsModel.fromJson(Map<String, dynamic> data) {
    return NewsModel(
      id: data['id'],
      title: data['title'],
      subtitle: data['subTitle'],
      body: data['body'],
      date: data['dateCreated'],
    );
  }

  toBookmark (){
    return {
      "id": id,
      "dateCreated": date,
      "title": title,
      "subTitle": subtitle,
      "body": body
    };
  }

  toJson (){
    return {
      "title": title,
      "subTitle": subtitle,
      "body": body
    };
  }
}
