import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenController with ChangeNotifier {
  static Future getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final email = user!.email;
      String date = DateTime.now().toIso8601String();
      date = date.substring(0, 10);
      print(email);
      print(date);

      final abc = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .collection("Vitals")
          .doc(date)
          .get();

      return abc;
    } on FirebaseAuthException catch (e) {
      print(e);
      //handle error here
    }
  }
}
