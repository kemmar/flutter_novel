class ChapterInfo {
  String? chapterLink;
  String? chapterTitle;

  ChapterInfo({this.chapterLink, this.chapterTitle});

  ChapterInfo.fromJson(Map<String, dynamic> json) {
    chapterLink = json['chapterLink'];
    chapterTitle = json['chapterTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chapterLink'] = chapterLink;
    data['chapterTitle'] = chapterTitle;
    return data;
  }
}