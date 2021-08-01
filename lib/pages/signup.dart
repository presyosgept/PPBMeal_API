import 'package:recipe_application/helper/constants.dart';
import 'package:recipe_application/helper/helperfunctions.dart';
import 'package:recipe_application/main.dart';
import 'package:recipe_application/pages/home.dart';
import 'package:recipe_application/services/auth.dart';
import 'package:recipe_application/services/database.dart';
// import 'package:recipe_application/views/home.dart';
// import 'package:recipe_application/views/publishRecipe.dart';
// import 'package:recipe_application/views/chatRoomsScreen.dart';
// import 'package:recipe_application/views/signin.dart';
import 'package:recipe_application/widget/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfo = {
        'name': usernameEditingController.text,
        'email': emailEditingController.text
      };

      HelperFunctions.saveUserEmailSharedPreference(
          emailEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(
          usernameEditingController.text);
      Constants.email = emailEditingController.text;
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) {
        databaseMethods.uploadUserInfo(userInfo);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //resizeToAvoidBottomInset: false,
        // appBar: appBarMain(context),
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/pls.png'),
            // fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
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
                                  style: simpleTextStyle(),
                                  controller: usernameEditingController,
                                  validator: (val) {
                                    return val.isEmpty || val.length < 3
                                        ? "Enter Username 3+ characters"
                                        : null;
                                  },
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
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )),
                              SizedBox(height: 6),
                              TextFormField(
                                  controller: emailEditingController,
                                  style: simpleTextStyle(),
                                  validator: (val) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(val)
                                        ? null
                                        : "Enter correct email";
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.indigo[800],
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )),
                              SizedBox(height: 6),
                              TextFormField(
                                obscureText: true,
                                style: simpleTextStyle(),
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo[800],
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                controller: passwordEditingController,
                                validator: (val) {
                                  return val.length < 6
                                      ? "Password must be 6 above characters"
                                      : null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            singUp();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.red,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Sign Up",
                              style: biggerTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: simpleTextStyle(),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "SignIn Now",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
          ),
        )));
  }
}
