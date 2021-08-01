import 'package:flutter/material.dart';
import 'package:recipe_application/helper/authenticate.dart';
import 'package:recipe_application/helper/constants.dart';
import 'package:recipe_application/pages/favoriteDrink.dart';
import 'package:recipe_application/pages/favoriteMeal.dart';
import 'package:recipe_application/pages/home.dart';
import 'package:recipe_application/pages/homepage.dart';
import 'package:recipe_application/pages/page_cocktail/screenDrink.dart';
import 'package:recipe_application/pages/searchPage.dart';
import 'package:recipe_application/pages/signin.dart';
import 'package:recipe_application/services/auth.dart';
import 'package:recipe_application/services/database.dart';

class SideBar extends StatefulWidget {
  // const ({ Key? key }) : super(key: key);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream users;

  Widget UsersList() {
    return StreamBuilder(
        stream: users,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Text(snapshot.data.docs[0].data()['name'].toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              : Container();
        });
  }

  @override
  void initState() {
    databaseMethods.getUserbyUserEmail(Constants.email).then((result) {
      setState(() {
        users = result;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: UsersList(),
            accountEmail: Text(
              Constants.email,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  'https://images.wallpapershd.info/image/wallpaper-light-red-line-1583857982-1280x960.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          ListTile(
              leading: Icon(Icons.bookmark, color: Colors.red),
              title: Text(
                'Favorite Meals',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteMeal()),
                );
              }),
          ListTile(
              leading: Icon(Icons.bookmark, color: Colors.red),
              title: Text(
                'Favorite Drinks',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteDrink()),
                );
              }),
          ListTile(
              leading: Icon(Icons.search, color: Colors.red),
              title: Text(
                'Search',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPageScreen()),
                );
              }),
          ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Log Out',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Colors.white,
                    content: Text(
                      "Are you sure you want to log out?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                          // minWidth: 12,
                          // color: Colors.indigo[400],
                          onPressed: () {
                            authMethods.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Authenticate()));
                            // Navigator.of(ctx).pop(); itry daw ni dzai
                          },
                          child: Text("YES"),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.red))),
                      ElevatedButton(
                          // minWidth: 12,
                          // color: Colors.indigo[400],
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("NO"),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.red))),
                    ],
                  ),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SearchPageScreen()),
                // );
                // ListTile(
                //     leading: Icon(Icons.notifications),
                //     title: Text('Home'),
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => Home()),
                //       );
                //     }),
                // ListTile(
                //     leading: Icon(Icons.note),
                //     title: Text('Meal Page'),
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => HomePage()),
                //       );
                //     }),
                // ListTile(
                //     leading: Icon(Icons.person),
                //     title: Text('Screen Drink'),
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => ScreenDrink()),
                //       );
                //     }),
              })
        ],
      ),
    );
  }
}
