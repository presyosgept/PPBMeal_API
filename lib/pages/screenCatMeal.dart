import 'package:flutter/material.dart';
import 'package:recipe_application/constant/strings.dart';
import 'package:recipe_application/helper/constants.dart';
import 'package:recipe_application/models/categories.dart';
import 'package:recipe_application/models/categoryMeal.dart';
import 'package:recipe_application/pages/screenRecipe.dart';
import 'package:recipe_application/pages/searchMeal.dart';
import 'package:recipe_application/services/api_manager.dart';
import 'package:intl/intl.dart';
import 'package:recipe_application/services/database.dart';

String sampleChoice;
List<String> choice = [''];

class CatMeal extends StatefulWidget {
  final String catId;
  CatMeal(this.catId);
  @override
  _CatMealState createState() => _CatMealState();
}

class _CatMealState extends State<CatMeal> {
  Future<CategoryMeal> _categoriesMeal;
  TextEditingController search_cat = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  int buttonSelected = 0;
  @override
  void initState() {
    print('mao nani');
    print(widget.catId.toString());
    _categoriesMeal = API_Manager().getCategoryMeal(widget.catId);
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
        title: Text('Meals'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<CategoryMeal>(
                future: _categoriesMeal,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.meals.length,
                        itemBuilder: (context, index) {
                          var catMeal = snapshot.data.meals[index];
                          // var formattedTime = DateFormat('dd MMM - HH:mm')
                          //     .format(article.publishedAt);
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScreenRecipe(
                                        catMeal.idMeal,
                                        // catMeal.strMealThumb
                                      )),
                            ),
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
                                              catMeal.strMealThumb,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      SizedBox(width: 16),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Text(
                                            catMeal.strMeal,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
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

                                          Map<String, dynamic> mealId = {
                                            "id": catMeal.idMeal,
                                            "name": catMeal.strMeal,
                                            "image": catMeal.strMealThumb,
                                          };
                                          databaseMethods.addFavorites(
                                              Constants.email, 'meals', mealId);
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
