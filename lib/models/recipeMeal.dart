// To parse this JSON data, do
//
//     final recipeMeal = recipeMealFromJson(jsonString);

import 'dart:convert';

RecipeMeal recipeMealFromJson(String str) =>
    RecipeMeal.fromJson(json.decode(str));

String recipeMealToJson(RecipeMeal data) => json.encode(data.toJson());

class RecipeMeal {
  RecipeMeal({
    this.meals,
  });

  List<Map<String, String>> meals;

  factory RecipeMeal.fromJson(Map<String, dynamic> json) => RecipeMeal(
        meals: List<Map<String, String>>.from(json["meals"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
