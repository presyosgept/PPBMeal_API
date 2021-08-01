// To parse this JSON data, do
//
//     final drinkDetails = drinkDetailsFromJson(jsonString);

import 'dart:convert';

DrinkDetails drinkDetailsFromJson(String str) =>
    DrinkDetails.fromJson(json.decode(str));

String drinkDetailsToJson(DrinkDetails data) => json.encode(data.toJson());

class DrinkDetails {
  DrinkDetails({
    this.drinks,
  });

  List<Map<String, String>> drinks;

  factory DrinkDetails.fromJson(Map<String, dynamic> json) => DrinkDetails(
        drinks: List<Map<String, String>>.from(json["drinks"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
