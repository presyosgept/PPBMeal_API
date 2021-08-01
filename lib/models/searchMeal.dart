// To parse this JSON data, do
//
//     final searchMeal = searchMealFromJson(jsonString);

import 'dart:convert';

SearchMeal searchMealFromJson(String str) =>
    SearchMeal.fromJson(json.decode(str));

String searchMealToJson(SearchMeal data) => json.encode(data.toJson());

class SearchMeal {
  SearchMeal({
    this.meals,
  });

  List<Map<String, String>> meals;

  factory SearchMeal.fromJson(Map<String, dynamic> json) => SearchMeal(
        meals: List<Map<String, String>>.from(json["meals"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
