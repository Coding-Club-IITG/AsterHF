import 'package:cloud_firestore/cloud_firestore.dart';


String date = "23-12-2022";

final db = FirebaseFirestore.instance.collection("users").doc("s.r.ghosarwadkar@gmail.com").collection("Vitals");

Future <bool> isProgressForWidget (String todayDate, String parameterType, double currentValue) async {
  double value = 0.0;
     await  db.get().then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      if(doc.id.compareTo(todayDate) == -1 && (doc.data() as Map<String, dynamic>).containsKey(parameterType)){
        value = double.parse(doc.get(parameterType).toString());
      }
    }
  });

     if(value > currentValue){
       return false;
     }else{
       return true;
     }
}


Future <bool> isProgressForWidgetBloodPressure (String todayDate, double currentSysValue, double currentDiaValue) async {
  double value = 0.0;
  await  db.get().then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      if(doc.id.compareTo(todayDate) == -1 && (doc.data() as Map<String, dynamic>).containsKey('blood_pressure')){
        value = double.parse((doc.get('blood_pressure')['Sys'] + doc.get('blood_pressure')['Dia']).toString());
      }
    }
  });

  if(value > (currentSysValue + currentDiaValue)){
    return false;
  }else{
    return true;
  }
}


