import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_application/constant/strings.dart';
import 'package:recipe_application/models/categories.dart';
import 'package:recipe_application/models/categoryMeal.dart';
import 'package:recipe_application/models/cocktail/category.dart';
import 'package:recipe_application/models/cocktail/drinkDetails.dart';
import 'package:recipe_application/models/cocktail/drink_category.dart';
import 'package:recipe_application/models/food_forthe_day/meal_ofthe_day.dart';
import 'package:recipe_application/models/recipeMeal.dart';
import 'package:recipe_application/models/searchCocktail.dart';
import 'package:recipe_application/models/searchMeal.dart';
import 'package:recipe_application/models/weather/weather.dart';

// ignore: camel_case_types
class API_Manager {
  Future<Categories> getCategories() async {
    var client = http.Client();
    var categoriesModel;

    try {
      var response = await client.get(Uri.parse(Strings.categories_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        categoriesModel = Categories.fromJson(jsonMap);
      }
    } catch (Exception) {
      return categoriesModel;
    }

    return categoriesModel;
  }

  Future<CategoryMeal> getCategoryMeal(String id) async {
    var client = http.Client();
    var categoryMealModel;

    try {
      var response = await client.get(Uri.parse(Strings.meals_url + id));
      print(Strings.meals_url + id);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        categoryMealModel = CategoryMeal.fromJson(jsonMap);
      }
    } catch (Exception) {
      return categoryMealModel;
    }

    return categoryMealModel;
  }

  Future<RecipeMeal> getRecipeMeal(String id) async {
    var client = http.Client();
    var recipeMealModel;

    try {
      var response = await client.get(Uri.parse(Strings.recipe_url + id));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        recipeMealModel = RecipeMeal.fromJson(jsonMap);
      }
    } catch (Exception) {
      return recipeMealModel;
    }

    return recipeMealModel;
  }

  Future<DrinkCategory> getdrinkCat() async {
    var client = http.Client();
    var drinkCatModel;

    try {
      var response = await client.get(Uri.parse(Strings.cat_drink));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        drinkCatModel = DrinkCategory.fromJson(jsonMap);
      }
    } catch (Exception) {
      return drinkCatModel;
    }

    return drinkCatModel;
  }

  Future<CategoryDrink> getCategoryDrink(String id) async {
    var client = http.Client();
    var categoryDrinkModel;

    try {
      var response =
          await client.get(Uri.parse(Strings.drink_in_category + id));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        categoryDrinkModel = CategoryDrink.fromJson(jsonMap);
      }
    } catch (Exception) {
      return categoryDrinkModel;
    }

    return categoryDrinkModel;
  }

  Future<DrinkDetails> getdrinkDetails(String id) async {
    var client = http.Client();
    var drinkDetailsModel;

    try {
      var response = await client.get(Uri.parse(Strings.drink_detials + id));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        drinkDetailsModel = DrinkDetails.fromJson(jsonMap);
      }
    } catch (Exception) {
      return drinkDetailsModel;
    }

    return drinkDetailsModel;
  }


  Future<SearchMeal> getsearchMeal(String id) async {
    var client = http.Client();
    var searchMealModel;

    try {
      var response = await client.get(Uri.parse(Strings.search_meal + id));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        searchMealModel = SearchMeal.fromJson(jsonMap);
      }
    } catch (Exception) {
      return searchMealModel;
    }

    return searchMealModel;
  }

  Future<SearchCocktail> getsearchCock(String id) async {
    var client = http.Client();
    var searchCockModel;

    try {
      var response = await client.get(Uri.parse(Strings.search_cock + id));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        searchCockModel = SearchCocktail.fromJson(jsonMap);
      }
    } catch (Exception) {
      return searchCockModel;
    }

    return searchCockModel;
  }

  // WEATHEEEEEEEEEEEEEEEEEEER HERE //
  Future<Weather> getWeather() async {
    var client = http.Client();
    var weatherModel;

    try {
      var response = await client.get(Uri.parse(Strings.weather));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        weatherModel = Weather.fromJson(jsonMap);
      }
    } catch (Exception) {
      return weatherModel;
    }

    return weatherModel;
  }

  Future<Clouds> getClouds() async {
    var client = http.Client();
    var cloudsModel;

    try {
      var response = await client.get(Uri.parse(Strings.weather));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        cloudsModel = Clouds.fromJson(jsonMap);
      }
    } catch (Exception) {
      return cloudsModel;
    }

    return cloudsModel;
  }

  Future<Coord> getCoord() async {
    var client = http.Client();
    var coordModel;

    try {
      var response = await client.get(Uri.parse(Strings.weather));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        coordModel = Coord.fromJson(jsonMap);
      }
    } catch (Exception) {
      return coordModel;
    }

    return coordModel;
  }

  Future<Main> getMain() async {
    var client = http.Client();
    var mainModel;

    try {
      var response = await client.get(Uri.parse(Strings.weather));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        mainModel = Main.fromJson(jsonMap);
      }
    } catch (Exception) {
      return mainModel;
    }

    return mainModel;
  }

  Future<Sys> getSys() async {
    var client = http.Client();
    var sysModel;

    try {
      var response = await client.get(Uri.parse(Strings.weather));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        sysModel = Sys.fromJson(jsonMap);
      }
    } catch (Exception) {
      return sysModel;
    }

    return sysModel;
  }

  Future<WeatherElement> getWeatherElement() async {
    var client = http.Client();
    var weatherElementModel;

    try {
      var response = await client.get(Uri.parse(Strings.weather));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        weatherElementModel = WeatherElement.fromJson(jsonMap);
      }
    } catch (Exception) {
      return weatherElementModel;
    }

    return weatherElementModel;
  }

  Future<Wind> getWind() async {
    var client = http.Client();
    var windModel;

    try {
      var response = await client.get(Uri.parse(Strings.weather));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        windModel = Wind.fromJson(jsonMap);
      }
    } catch (Exception) {
      return windModel;
    }

    return windModel;
  }
}
