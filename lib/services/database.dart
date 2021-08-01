import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserbyUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: username)
        .get();
  }

  getUserbyUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: userEmail)
        .snapshots();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  addFavorites(String email, String type, mealId) async {
    FirebaseFirestore.instance
        .collection('favorites')
        .doc(email)
        .collection(type)
        .doc()
        .set(mealId)
        .catchError((e) {
      print(e.toString());
    });
  }

  getFavorites(String email, String type) async {
    return await FirebaseFirestore.instance
        .collection('favorites')
        .doc(email)
        .collection(type)
        .snapshots();
  }
}
