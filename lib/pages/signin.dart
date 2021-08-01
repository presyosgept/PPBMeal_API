import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_application/helper/constants.dart';
import 'package:recipe_application/helper/helperfunctions.dart';
import 'package:recipe_application/pages/home.dart';
import 'package:recipe_application/services/auth.dart';
import 'package:recipe_application/services/database.dart';
// import 'package:recipe_application/views/home.dart';
// import 'package:recipe_application/views/chatRoomsScreen.dart';
import 'package:recipe_application/widget/widget.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  int flag = 0;
  singIn() async {
    String username;
    flag = 0;
    log("sdfsfse");
    if (formKey.currentState.validate()) {
      log("1");
      HelperFunctions.saveUserEmailSharedPreference(
          emailEditingController.text);
      log("2");
      log(emailEditingController.text);
      Constants.email = emailEditingController.text;
      log("g" + emailEditingController.text);
      databaseMethods
          .getUserbyUserEmail(emailEditingController.text)
          .then((result) {
        snapshotUserInfo = result;
        log("o" + emailEditingController.text);
        print(flag.toString);
        username = snapshotUserInfo.docs[0].data()["name"];
        log("e" + emailEditingController.text);
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()["name"]);
      });
      setState(() {
        log("we" + emailEditingController.text);
        
      });

      await authMethods
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) {
        if (result != null) {
          log("dzaaa" + emailEditingController.text);
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          setState(() {
            isLoading = true;
            flag = 1;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
          print(username);
        } else {
         setState(() {
            flag = 1;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // resizeToAvoidBottomInset: false,
        // appBar: appBarMain(context),
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/final.png'),
            fit: BoxFit.fitWidth,
          )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading && flag == 1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Center(
                            child: CircularProgressIndicator()
                               ),
                      ),
                      Text("Wait For A While", style: biggerTextStyle())
                    ],
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Spacer(),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                  cursorColor: Colors.black,
                                  validator: (val) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(val)
                                        ? null
                                        : "Please Enter Correct Email";
                                  },
                                  controller: emailEditingController,
                                  style: simpleTextStyle(),
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                    hintText: 'Email',
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  cursorColor: Colors.black,
                                  obscureText: true,
                                  validator: (val) {
                                    return val.length > 6
                                        ? null
                                        : "Password must be 6 above characters";
                                  },
                                  style: simpleTextStyle(),
                                  controller: passwordEditingController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    hoverColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: 'Password',
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            singIn();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.red),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Sign In",
                              style: biggerTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                       flag == 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have account? ",
                                    style: simpleTextStyle(),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.toggle();
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Register Now",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                decoration:
                                                    TextDecoration.underline),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0)
                                ],
                              )
                            : Row(
                              children: [
                                 Text(
                                    "Account not found",
                                    style: simpleTextStyle(),
                                  ),
                                GestureDetector(
                                    onTap: () {
                                      widget.toggle();
                                    },
                                    child:  Text(
                                            "Register Now",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                  ),
                              ],
                            ),
                      ],
                    ),
                  ),
          ),
        )));
  }
}
