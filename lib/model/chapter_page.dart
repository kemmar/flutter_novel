class ChapterPageInfo {
  String? chapterTitle;
  List<String>? chapterContent;

  ChapterPageInfo({this.chapterTitle, this.chapterContent});

  ChapterPageInfo.fromJson(Map<String, dynamic> json) {
    chapterTitle = json['chapterTitle'];
    chapterContent = json['chapterContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chapterTitle'] = chapterTitle;
    data['chapterContent'] = chapterContent;
    return data;
  }
}