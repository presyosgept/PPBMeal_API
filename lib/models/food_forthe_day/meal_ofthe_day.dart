//
//     final mealoftheDay = mealoftheDayFromJson(jsonString);

import 'dart:convert';

MealoftheDay mealoftheDayFromJson(String str) =>
    MealoftheDay.fromJson(json.decode(str));

String mealoftheDayToJson(MealoftheDay data) => json.encode(data.toJson());

class MealoftheDay {
  MealoftheDay({
    this.meals,
  });

  List<Map<String, String>> meals;

  factory MealoftheDay.fromJson(Map<String, dynamic> json) => MealoftheDay(
        meals: List<Map<String, String>>.from(json["meals"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
