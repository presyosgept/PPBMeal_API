// To parse this JSON data, do
//
//     final drinkCategory = drinkCategoryFromJson(jsonString);

import 'dart:convert';

DrinkCategory drinkCategoryFromJson(String str) =>
    DrinkCategory.fromJson(json.decode(str));

String drinkCategoryToJson(DrinkCategory data) => json.encode(data.toJson());

class DrinkCategory {
  DrinkCategory({
    this.drinks,
  });

  List<Drink> drinks;

  factory DrinkCategory.fromJson(Map<String, dynamic> json) => DrinkCategory(
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class Drink {
  Drink({
    this.strCategory,
  });

  String strCategory;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        strCategory: json["strCategory"],
      );

  Map<String, dynamic> toJson() => {
        "strCategory": strCategory,
      };
}
