import 'dart:ffi';

import 'package:aster_hf/main.dart';
import 'package:aster_hf/screens/first_screen.dart';
import 'package:aster_hf/screens/home_screen.dart';
import 'package:aster_hf/screens/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/user_data_controller.dart';

class SplashScreen extends StatefulWidget {
  final bool isLogin;

  const SplashScreen(this.isLogin, {super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    //TODO: remove this line , inserted only for testing



    await Future.delayed(const Duration(seconds: 2), () {});
    if (!mounted) return;

    if (!widget.isLogin) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const FirstScreen(), type: PageTransitionType.fade));
    } else {
      final data = await UserDataController.getNextScreen();
      // final bool f = getPercentage() as bool;

      if (data['page'] == 'home_screen') {
        Navigator.pushReplacement(navigatorKey.currentContext!,
            PageTransition(child: const Home(), type: PageTransitionType.fade));
      } else {
        Navigator.pushReplacement(
            navigatorKey.currentContext!,
            PageTransition(
                child: UserData(
                  progress: data['progress'],
                  page: data['page'],
                  isPoppable: false,
                ),
                type: PageTransitionType.fade));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100.h,
              width: 92.w,
              child: Image.asset('assets/images/logo.png'),
            ),
            Text(
              'WellBe',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Future<bool> getPercentage() async {
//   int percent = 0;
//   DateTime today = DateTime.now();
//   var snapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser?.email)
//       .collection('Vitals')
//       .doc(today.toIso8601String().substring(0, 10))
//       .get();
//   if(snapshot.exists) {
//     Map? a = snapshot.data();
//     if (a!['blood_oxygen']!=null){
//       percent += 20;
//     }
//     if (a['body_weight']!=null){
//       percent += 20;
//     }
//     if (a['glucose_level']!=null){
//       percent += 20;
//     }
//     if (a['heartRate']!=null){
//       percent += 20;
//     }
//     if (a['blood_pressure']['Sys']!=null){
//       percent += 20;
//     }
//   }
//   if(percent==100){
//     return true;
//   }
//   return false;
// }
}
