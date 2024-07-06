import 'package:shop_app/home.dart';
class RecipeModel{

  late String appLabel;
  late String appImgUrl;
  late double appCalories;
  late String appUrl;

  RecipeModel({
    this.appLabel="label",
    this.appImgUrl="image",
    this.appCalories=0.000,
    this.appUrl="url" });

  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      appCalories: recipe["calories"],
      appImgUrl: recipe["image"],
      appLabel: recipe["label"],
      appUrl: recipe["url"],

    );
  }

}