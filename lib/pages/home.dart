import 'package:flutter/material.dart';
import 'package:recipe_application/constant/strings.dart';
import 'package:recipe_application/models/categories.dart';
import 'package:recipe_application/models/food_forthe_day/meal_ofthe_day.dart';
import 'package:recipe_application/models/weather/weather.dart';
import 'package:recipe_application/pages/page_cocktail/screenDrink.dart';
import 'package:recipe_application/pages/screenCatMeal.dart';
import 'package:recipe_application/pages/sideBar.dart';
import 'package:recipe_application/services/api_manager.dart';
import 'package:intl/intl.dart';

import 'homepage.dart';

class Home extends StatefulWidget {
  // final String username;
  // final String email;

  // Home(this.username, this.email);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Weather> _weatherMain;
  Future<Clouds> _clouds;
  Future<Coord> _coord;
  Future<Main> _main;
  Future<Sys> _sys;
  Future<WeatherElement> _weatherElement;
  Future<Wind> _wind;

  @override
  void initState() {
    _weatherMain = API_Manager().getWeather();
    _clouds = API_Manager().getClouds();
    _coord = API_Manager().getCoord();
    _main = API_Manager().getMain();
    _sys = API_Manager().getSys();
    _weatherElement = API_Manager().getWeatherElement();
    _wind = API_Manager().getWind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SideBar(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.imgur.com/jP8N6Wr_d.webp?maxwidth=760&fidelity=grand'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // COUNTRY //
                    Container(
                      alignment: Alignment.center,
                      child: FutureBuilder<Weather>(
                        future: _weatherMain,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var sysArea = snapshot.data.sys;
                            return Text(
                              sysArea.country.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          } else
                            return Container();
                        },
                      ),
                    ),
                    // ICON AND DES //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: FutureBuilder<Weather>(
                          future: _weatherMain,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var elementArea = snapshot.data.weather;
                              return Image.network(
                                "http://openweathermap.org/img/w/" +
                                    elementArea[0].icon +
                                    ".png",
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height / 6,
                                width: 100,
                              );
                            } else
                              return Container();
                          },
                        )),
                        Container(
                          child: FutureBuilder<Weather>(
                            future: _weatherMain,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var mainArea = snapshot.data.main;
                                var temp = mainArea.temp - 273.15;
                                var temperature = temp.toStringAsFixed(2);
                                return Text(
                                  '$temperature' + "\u2103",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 70,
                                    fontWeight: FontWeight.w700,
                                  ),
                                );
                              } else
                                return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                    // TEMPERATURE //

                    // NAME//
                    FutureBuilder<Weather>(
                      future: _weatherMain,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var mainArea = snapshot.data.name;
                          return Text(
                            mainArea.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        } else
                          return Container();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
       
          SizedBox(
            height: 30,
          ),
          //  PICTUREEEEEEEEEEEEEEEEEEEEEE HERE //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                  print('Pressed');
                }, // Handle your callback.
                splashColor: Colors.brown.withOpacity(0.5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage('assets/images/meal.png'),
                      height: 190.0,
                      width: 140.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenDrink(),
                      ));
                  print('Pressed');
                }, // Handle your callback.
                splashColor: Colors.brown.withOpacity(0.5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage('assets/images/cocktails.png'),
                      height: 190.0,
                      width: 140.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Hungry? Tap Meals!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Teko'),
              ),
              Text(
                'Thirsty? Go for this!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Teko'),
              ),
            ],
          )
        ],
      ), //MAO NI COLUMN NGA PARENTISIS
    );
  }
}
