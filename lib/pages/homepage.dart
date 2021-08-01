import 'package:flutter/material.dart';
import 'package:recipe_application/constant/strings.dart';
import 'package:recipe_application/models/categories.dart';
import 'package:recipe_application/pages/screenCatMeal.dart';
import 'package:recipe_application/services/api_manager.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Categories> _categories;

  @override
  void initState() {
    _categories = API_Manager().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Meal Category'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: FutureBuilder<Categories>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.categories.length,
                  itemBuilder: (context, index) {
                    var cat = snapshot.data.categories[index];
                    // var formattedTime = DateFormat('dd MMM - HH:mm')
                    //     .format(article.publishedAt);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CatMeal(cat.strCategory)),
                        );
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
                                        cat.strCategoryThumb,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(width: 16),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 70),
                                        child: Text(
                                          cat.strCategory,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // Text(
                                      //   cat.strCategoryDescription,
                                      //   maxLines: 3,
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
