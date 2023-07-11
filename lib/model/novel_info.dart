class NovelInfo {
  String? id;
  String? lang;
  String? url;
  String? visitPath;
  String? name;
  String? author;
  String? artist;
  String? intro;
  String? frequency;
  String? completed;
  String? status;
  String? lastChapterTitle;
  String? showIt;
  bool? isNovel;
  String? cover;
  String? categoryStr;
  List<String>? categoryList;
  int? time;

  NovelInfo(
      {this.id,
        this.lang,
        this.url,
        this.visitPath,
        this.name,
        this.author,
        this.artist,
        this.intro,
        this.frequency,
        this.completed,
        this.status,
        this.lastChapterTitle,
        this.showIt,
        this.isNovel,
        this.cover,
        this.categoryStr,
        this.categoryList,
        this.time});

  NovelInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lang = json['lang'];
    url = json['url'];
    visitPath = json['visit_path'];
    name = json['name'];
    author = json['author'];
    artist = json['artist'];
    intro = json['intro'];
    frequency = json['frequency'];
    completed = json['completed'];
    status = json['status'];
    lastChapterTitle = json['last_chapter_title'];
    showIt = json['show_it'];
    isNovel = json['is_novel'];
    cover = json['cover'];
    categoryStr = json['category_str'];
    categoryList = json['category_list'].cast<String>();
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lang'] = this.lang;
    data['url'] = this.url;
    data['visit_path'] = this.visitPath;
    data['name'] = this.name;
    data['author'] = this.author;
    data['artist'] = this.artist;
    data['intro'] = this.intro;
    data['frequency'] = this.frequency;
    data['completed'] = this.completed;
    data['status'] = this.status;
    data['last_chapter_title'] = this.lastChapterTitle;
    data['show_it'] = this.showIt;
    data['is_novel'] = this.isNovel;
    data['cover'] = this.cover;
    data['category_str'] = this.categoryStr;
    data['category_list'] = this.categoryList;
    data['time'] = this.time;
    return data;
  }
}
