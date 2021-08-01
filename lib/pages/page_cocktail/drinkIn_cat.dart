import 'package:flutter/material.dart';
import 'package:recipe_application/helper/constants.dart';
import 'package:recipe_application/models/categories.dart';
import 'package:recipe_application/models/categoryMeal.dart';
import 'package:recipe_application/models/cocktail/category.dart';
import 'package:recipe_application/models/cocktail/drink_category.dart';
import 'package:recipe_application/models/recipeMeal.dart';
import 'package:recipe_application/pages/page_cocktail/screenDrinkDetails.dart';
import 'package:recipe_application/pages/searchDrink.dart';
import 'package:recipe_application/services/api_manager.dart';
import 'package:intl/intl.dart';
import 'package:recipe_application/services/database.dart';

String sampleChoice;
List<String> choice = [''];

class DrinkIn extends StatefulWidget {
  final String drinkCat;
  DrinkIn(this.drinkCat);
  @override
  _DrinkInState createState() => _DrinkInState();
}

class _DrinkInState extends State<DrinkIn> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController search_drink = new TextEditingController();
  Future<CategoryDrink> _drinkIn;
  int buttonSelected = 0;

  @override
  void initState() {
    _drinkIn = API_Manager().getCategoryDrink(widget.drinkCat);
    super.initState();
  }

  trappingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.brown[50],
            content: Text(
              'Meal saved to favorites!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Okay',
                  style: TextStyle(),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Drink Details'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<CategoryDrink>(
                future: _drinkIn,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.drinks.length,
                        itemBuilder: (context, index) {
                          var drinkIn = snapshot.data.drinks[index];
                          // var formattedTime = DateFormat('dd MMM - HH:mm')
                          //     .format(article.publishedAt);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenDrinkDetails(
                                          drinkIn.idDrink,
                                          // drinkIn.strDrinkThumb
                                        )),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                              child: Card(
                                child: Container(
                                  height: 100,
                                  margin: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Card(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.network(
                                              drinkIn.strDrinkThumb,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      SizedBox(width: 16),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Text(
                                            drinkIn.strDrink,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        // highlightColor: Colors.red,
                                        // hoverColor: Colors.green,
                                        // focusColor: Colors.purple,
                                        splashColor: Colors.red,
                                        // disabledColor: Colors.amber,
                                        // color: Colors.red,
                                        color: Colors.red,
                                        iconSize: 35,
                                        onPressed: () {
                                          setState(() {
                                            buttonSelected = 2;
                                            trappingDialog(context);
                                            // Text(
                                            //   'View Instructions here',
                                            //   style: TextStyle(
                                            //     fontSize: 16,
                                            //   ),
                                            // );
                                          });

                                          Map<String, dynamic> drinksId = {
                                            "id": drinkIn.idDrink,
                                            "name": drinkIn.strDrink,
                                            "image": drinkIn.strDrinkThumb,
                                          };
                                          databaseMethods.addFavorites(
                                              Constants.email,
                                              'drinks',
                                              drinksId);
                                        },
                                        icon: new Icon(
                                          Icons.bookmark_border_sharp,
                                        ),
                                      )
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
          ],
        ),
      ),
    );
  }
}
