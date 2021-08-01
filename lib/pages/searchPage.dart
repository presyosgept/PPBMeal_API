import 'package:flutter/material.dart';
import 'package:recipe_application/models/searchMeal.dart';
import 'package:recipe_application/pages/searchDrink.dart';
import 'package:recipe_application/pages/searchMeal.dart';
import 'package:recipe_application/services/api_manager.dart';

class SearchPageScreen extends StatefulWidget {
  // final String id;
  // SearchPageScreen(
  //   this.id,
  // );

  @override
  _SearchPageScreenState createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  TextEditingController search_cat = new TextEditingController();
  TextEditingController search_drink = new TextEditingController();
  // Future<SearchMeal> _searchMeal;

  // @override
  // void initState() {
  //   _searchMeal = API_Manager().getsearchMeal();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Already know what youre looking for? Hungry? Thirsty? Wanna satisfy cravings? Search it on!',
                      style: TextStyle(
                        fontFamily: 'Teko',
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: search_cat,
                    decoration: InputDecoration(
                        labelText: "Search Meal",
                        labelStyle: TextStyle(color: Colors.red, fontSize: 16),
                        fillColor: Colors.black,
                        prefixIcon: GestureDetector(
                            onTap: () {
                              print("pislut");
                              print(search_cat.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SearchMealScreen(search_cat.text),
                                  ));
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ))),
              ),
            ),
          ),
          Container(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                  controller: search_drink,
                  decoration: InputDecoration(
                      labelText: "Search Drink",
                      labelStyle: TextStyle(color: Colors.red, fontSize: 16),
                      fillColor: Colors.black,
                      prefixIcon: GestureDetector(
                        onTap: () {
                          print("pislut");
                          print(search_drink.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchDrinkScreen(search_drink.text),
                              ));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
