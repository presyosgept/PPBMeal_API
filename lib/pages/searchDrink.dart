import 'package:flutter/material.dart';
import 'package:recipe_application/constant/strings.dart';
import 'package:recipe_application/helper/constants.dart';
import 'package:recipe_application/models/categories.dart';
import 'package:recipe_application/models/categoryMeal.dart';
import 'package:recipe_application/models/cocktail/drinkDetails.dart';
import 'package:recipe_application/models/searchCocktail.dart';
import 'package:recipe_application/models/searchMeal.dart';
import 'package:recipe_application/pages/page_cocktail/screenDrinkDetails.dart';
import 'package:recipe_application/pages/screenRecipe.dart';
import 'package:recipe_application/pages/searchMeal.dart';
import 'package:recipe_application/services/api_manager.dart';
import 'package:intl/intl.dart';
import 'package:recipe_application/services/database.dart';

String sampleChoice;
List<String> choice = [''];

class SearchDrinkScreen extends StatefulWidget {
  final String id;
  SearchDrinkScreen(this.id);
  @override
  _SearchDrinkScreenState createState() => _SearchDrinkScreenState();
}

class _SearchDrinkScreenState extends State<SearchDrinkScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  int buttonSelected = 0;
  Future<SearchCocktail> _searchDrink;
  @override
  void initState() {
    _searchDrink = API_Manager().getsearchCock(widget.id);
    super.initState();
  }

  trappingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.brown[50],
            content: Text('Drink saved to favorites!'),
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
        title: Text('Meals'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<SearchCocktail>(
                future: _searchDrink,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.drinks.length,
                        itemBuilder: (context, index) {
                          var catMeal = snapshot.data.drinks[index];
                          // var formattedTime = DateFormat('dd MMM - HH:mm')
                          //     .format(article.publishedAt);
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScreenDrinkDetails(
                                      snapshot.data.drinks[index]['idDrink']
                                      // catMeal.strMealThumb
                                      )),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                                              snapshot.data.drinks[index]
                                                  ['strDrinkThumb'],
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Text(
                                            snapshot
                                                .data.drinks[index]['strDrink']
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        splashColor: Colors.purple,
                                        color: Colors.red,
                                        iconSize: 35,
                                        onPressed: () {
                                          setState(() {
                                            buttonSelected = 2;
                                            trappingDialog(context);
                                          });

                                          Map<String, dynamic> drinkId = {
                                            "id": snapshot.data.drinks[index]
                                                ['idDrink'],
                                            "name": snapshot.data.drinks[index]
                                                ['strDrink'],
                                            "image": snapshot.data.drinks[index]
                                                ['strDrinkThumb'],
                                          };
                                          databaseMethods.addFavorites(
                                              Constants.email, 'drinks', drinkId);
                                        },
                                        icon: new Icon(
                                          Icons.bookmark_border_sharp,
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
          ],
        ),
      ),
    );
  }
}
