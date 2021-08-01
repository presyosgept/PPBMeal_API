// To parse this JSON data, do
//
//     final categoryMeal = categoryMealFromJson(jsonString);

import 'dart:convert';

CategoryMeal categoryMealFromJson(String str) =>
    CategoryMeal.fromJson(json.decode(str));

String categoryMealToJson(CategoryMeal data) => json.encode(data.toJson());

class CategoryMeal {
  CategoryMeal({
    this.meals,
  });

  List<Meal> meals;

  factory CategoryMeal.fromJson(Map<String, dynamic> json) => CategoryMeal(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  String strMeal;
  String strMealThumb;
  String idMeal;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
