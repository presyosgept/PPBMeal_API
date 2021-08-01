// To parse this JSON data, do
//
//     final searchCocktail = searchCocktailFromJson(jsonString);

import 'dart:convert';

SearchCocktail searchCocktailFromJson(String str) =>
    SearchCocktail.fromJson(json.decode(str));

String searchCocktailToJson(SearchCocktail data) => json.encode(data.toJson());

class SearchCocktail {
  SearchCocktail({
    this.drinks,
  });

  List<Map<String, String>> drinks;

  factory SearchCocktail.fromJson(Map<String, dynamic> json) => SearchCocktail(
        drinks: List<Map<String, String>>.from(json["drinks"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": List<dynamic>.from(drinks.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
