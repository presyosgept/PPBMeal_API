import 'package:flutter/material.dart';
import 'package:recipe_application/helper/constants.dart';
import 'package:recipe_application/models/cocktail/drink_category.dart';
import 'package:recipe_application/pages/page_cocktail/screenDrinkDetails.dart';
import 'package:recipe_application/services/database.dart';

class FavoriteDrink extends StatefulWidget {
  const FavoriteDrink({Key key}) : super(key: key);

  @override
  _FavoriteDrinkState createState() => _FavoriteDrinkState();
}

class _FavoriteDrinkState extends State<FavoriteDrink> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  List listFaveDrink = [];
  Future<CategoryDrink> _faveDrink;
  Stream favoriteDrinks;

  @override
  void initState() {
    databaseMethods.getFavorites(Constants.email, 'drinks').then((result) {
      setState(() {
        favoriteDrinks = result;
      });
    });
    super.initState();
  }

  Widget FaveDrink() {
    // ps becs ngani sa drinkslater
    return StreamBuilder(
        stream: favoriteDrinks,
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
                                builder: (context) => ScreenDrinkDetails(
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
              : Container(child:Text("No favorites drinks yet"));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Favorite Drink'),
      ),
      body: Container(
        child: FaveDrink(),
      ),
    );
  }
}
