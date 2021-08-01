import 'package:flutter/material.dart';
import 'package:recipe_application/helper/constants.dart';
import 'package:recipe_application/models/recipeMeal.dart';
import 'package:recipe_application/pages/screenRecipe.dart';
import 'package:recipe_application/services/api_manager.dart';
import 'package:recipe_application/services/database.dart';

class FavoriteMeal extends StatefulWidget {
  const FavoriteMeal({Key key}) : super(key: key);

  @override
  FavoriteMealState createState() => FavoriteMealState();
}

class FavoriteMealState extends State<FavoriteMeal> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  List listFaveMeal = [];
  Future<RecipeMeal> _recipeMeal;

  Stream favoriteMeal;
  @override
  void initState() {
    databaseMethods.getFavorites(Constants.email, 'meals').then((result) {
      setState(() {
        favoriteMeal = result;
      });
    });
    super.initState();
  }

  Widget FaveMeal() {
    // ps becs ngani sa drinkslater
    return StreamBuilder(
        stream: favoriteMeal,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenRecipe(
                                      snapshot.data.docs[index].data()['id'],
                                      // snapshot.data.docs[index].data()['image'],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
                        child: Card(
                          child: Container(
                            height: 100,
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              children: <Widget>[
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        snapshot.data.docs[index]
                                            .data()['image'],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(width: 16),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.docs[index]
                                            .data()['name']
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Text(
                                      //   cat.strCategoryDescription,
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
                  })
              : Container();
          // return Container(
          //   color: Colors.white,
          //   child: Text(listFaveMeal[0].toString()),
          // );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Favorite Meal'),
      ),
      body: Container(
        child: FaveMeal(),
      ),
    );
  }
}
