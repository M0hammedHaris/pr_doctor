class IngredientList {
  String title;
  String text;

  IngredientList(this.title, this.text);

  IngredientList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
  }
}