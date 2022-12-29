import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aster_hf/widgets/home_screen/home_screen_widgets.dart';

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

List <Widget> vitalWidgets(AsyncSnapshot snapshot){

  List <Widget> toShow =  [];
  if (snapshot.data!.data()!.containsKey('blood_oxygen')) {
    toShow.add(Container(
      margin: const EdgeInsets.only(right: 10),
      width: 145,
      height: 135,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)),
      child: ActivityWidget(
        vitalType: 5,
        parameterValue:
        snapshot.data['blood_oxygen'].toString(),
      ),
    ));
  }
  if (snapshot.data!.data()!.containsKey('body_weight')) {
    toShow.add(Container(
      margin: const EdgeInsets.only(right: 10),
      width: 145,
      height: 135,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)),
      child: ActivityWidget(
        vitalType: 2,
        parameterValue:
        snapshot.data['body_weight'].toString(),
      ),
    ));
  }
  if (snapshot.data!
      .data()!
      .containsKey('blood_pressure')) {
    toShow.add(Container(
      margin: const EdgeInsets.only(right: 10),
      width: 145,
      height: 135,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)),
      child: ActivityWidget(
        vitalType: 1,
        parameterValue:
        "${snapshot.data['blood_pressure']['Sys']}/${snapshot.data['blood_pressure']['Dia']}",
      ),
    ));
  }
  if (snapshot.data!.data()!.containsKey('glucose_level')) {
    toShow.add(Container(
      margin: const EdgeInsets.only(right: 10),
      width: 145,
      height: 135,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)),
      child: ActivityWidget(
        vitalType: 3,
        parameterValue: "${snapshot.data['glucose_level']}",
      ),
    ));
  }
  if (snapshot.data!.data()!.containsKey('heart_rate')) {
    toShow.add(Container(
      margin: const EdgeInsets.only(right: 10),
      width: 145,
      height: 135,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)),
      child: ActivityWidget(
        vitalType: 4,
        parameterValue: "${snapshot.data['heart_rate']}",
      ),
    ));
  }

  return toShow;
}