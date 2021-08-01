// To parse this JSON data, do
//
//     final categoryDrink = categoryDrinkFromJson(jsonString);

import 'dart:convert';

CategoryDrink categoryDrinkFromJson(String str) =>
    CategoryDrink.fromJson(json.decode(str));

String categoryDrinkToJson(CategoryDrink data) => json.encode(data.toJson());

class CategoryDrink {
  CategoryDrink({
    this.drinks,
  });

  List<Drink> drinks;

  factory CategoryDrink.fromJson(Map<String, dynamic> json) => CategoryDrink(
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class Drink {
  Drink({
    this.strDrink,
    this.strDrinkThumb,
    this.idDrink,
  });

  String strDrink;
  String strDrinkThumb;
  String idDrink;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        strDrink: json["strDrink"],
        strDrinkThumb: json["strDrinkThumb"],
        idDrink: json["idDrink"],
      );

  Map<String, dynamic> toJson() => {
        "strDrink": strDrink,
        "strDrinkThumb": strDrinkThumb,
        "idDrink": idDrink,
      };
}
