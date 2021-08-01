import 'package:flutter/material.dart';
import 'package:recipe_application/models/categories.dart';
import 'package:recipe_application/models/categoryMeal.dart';
import 'package:recipe_application/models/cocktail/category.dart';
import 'package:recipe_application/models/cocktail/drinkDetails.dart';
import 'package:recipe_application/models/cocktail/drink_category.dart';
import 'package:recipe_application/models/recipeMeal.dart';
import 'package:recipe_application/services/api_manager.dart';
import 'package:intl/intl.dart';

import 'drinkIn_cat.dart';

class ScreenDrinkDetails extends StatefulWidget {
  final String detailsDrink;
  // final String imageDrink;
  ScreenDrinkDetails(this.detailsDrink);
  @override
  _ScreenDrinkDetailsState createState() => _ScreenDrinkDetailsState();
}

class _ScreenDrinkDetailsState extends State<ScreenDrinkDetails> {
  Future<DrinkDetails> _drinkDetails;

  @override
  void initState() {
    _drinkDetails = API_Manager().getdrinkDetails(widget.detailsDrink);
    super.initState();
  }

  trappingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder<DrinkDetails>(
              future: _drinkDetails,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var snap = snapshot.data.drinks;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          child: AlertDialog(
                            title: Text(
                              snap[0]['strInstructions'].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Done',
                                  style: TextStyle(fontSize: 18),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
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
          child: Container(
              child: FutureBuilder<DrinkDetails>(
                  future: _drinkDetails,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var snap = snapshot.data.drinks;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUbnCWa7PV6hIp0bkUvF1D1SuG029j2ysorZ4e73F6s_Ggwhrge-d7A9KO-77wMj4x3UM&usqp=CAU'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          snap[0]['strDrink'].toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 35,
                                            fontFamily: 'DancingScript',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 200.0,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snap[0]['strDrinkThumb'].toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100.0)),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              trappingDialog(context);
                            },
                            child: Text(
                              'View Instructions here',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Ingredients',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Teko',
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 40, left: 50, right: 50),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 20,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var i = index + 1;
                                      return snap[0]['strIngredient' + '$i'] !=
                                              null
                                          ? Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      snap[0]['strIngredient' +
                                                              '$i']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      snap[0]['strMeasure' +
                                                              '$i']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container();
                                    }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ));
  }
}
