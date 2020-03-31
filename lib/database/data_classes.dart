class IngredientList {
  String title;
  String imgUrl;
  String wikiEn;
  String wikiTa;

  IngredientList(this.title, this.imgUrl,this.wikiEn,this.wikiTa);

  IngredientList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imgUrl = json['img_url'];
    wikiEn = json['wiki_en'];
    wikiTa = json['wiki_ta'];
  }
}

class HomePage {
  String imgUrl;
  String title;
  String targetUrl;

  HomePage(this.imgUrl,this.targetUrl,this.title);

  HomePage.fromJson(Map<String, dynamic> json){
    imgUrl = json['img_url'];
    title = json['title'];
    targetUrl = json['target_url'];
  }
}

class TipsList {
  String title;
  String content;
  String desc;

  TipsList(this.title, this.content,this.desc);

  TipsList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    desc = json['desc'];
  }
}