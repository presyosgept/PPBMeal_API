import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_application/models/categories.dart';
import 'package:recipe_application/models/categoryMeal.dart';
import 'package:recipe_application/models/cocktail/category.dart';
import 'package:recipe_application/models/cocktail/drink_category.dart';
import 'package:recipe_application/models/recipeMeal.dart';
import 'package:recipe_application/services/api_manager.dart';
import 'package:intl/intl.dart';

import 'drinkIn_cat.dart';

class ScreenDrink extends StatefulWidget {
  // final String mId;
  // ScreenRecipe(this.mId);
  @override
  _ScreenDrinkState createState() => _ScreenDrinkState();
}

class _ScreenDrinkState extends State<ScreenDrink> {
  Future<DrinkCategory> _drinkCat;

  @override
  void initState() {
    _drinkCat = API_Manager().getdrinkCat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Drinks Category'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: FutureBuilder<DrinkCategory>(
          future: _drinkCat,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.drinks.length,
                  itemBuilder: (context, index) {
                    var drinkCateg = snapshot.data.drinks[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DrinkIn(drinkCateg.strCategory)),
                          );
                        },
                        child: Card(
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 50,
                                  // child: ClipOval(

                                  //   child: Text(drinkCateg.strCategory[0],
                                  //   ),

                                  // ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Text(drinkCateg.strCategory[0]),
                                  ),
                                ),
                                // Card(
                                //   clipBehavior: Clip.antiAlias,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(24),
                                //   ),
                                //   child: AspectRatio(
                                //       aspectRatio: 1,
                                //       child: Image.network(
                                //         drinkCateg.strCategoryThumb,
                                //         fit: BoxFit.cover,
                                //       )),
                                // ),
                                SizedBox(width: 16),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        drinkCateg.strCategory,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Text(
                                      //   drinkCateg.strCategory,
                                      //   maxLines: 2,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
