class Chapter {
  List<String>? content;

  Chapter({this.content});

  Chapter.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['content'] = content;
    return data;
  }
}