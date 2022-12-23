import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/button.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  static const routename = '/thank';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: const Alignment(0, 0.65),
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 100.h,
                  width: 92.w,
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'Thank You!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'We’ve successfully recorded\nyour daily vitals. 🎉',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Material(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: InkWell(
               splashColor: const Color.fromRGBO(105, 92, 212, 0.8),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onTap: () async {
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  final email = user!.email;

                  String date = DateTime.now().toIso8601String();
                  date = date.substring(0, 10);

                  final prefs = await SharedPreferences.getInstance();

                  int bp_sys = (prefs.getInt('bp_sys1') ?? 0) * 100;
                  bp_sys += (prefs.getInt('bp_sys2') ?? 0) * 10;
                  bp_sys += (prefs.getInt('bp_sys3') ?? 0) * 1;

                  int bp_dia = (prefs.getInt('bp_dia1') ?? 0) * 100;
                  bp_dia += (prefs.getInt('bp_dia2') ?? 0) * 10;
                  bp_dia += (prefs.getInt('bp_dia3') ?? 0) * 1;

                  double weight = (prefs.getInt('weight1') ?? 0) * 100;
                  weight += (prefs.getInt('weight2') ?? 0) * 10;
                  weight += (prefs.getInt('weight3') ?? 0) * 1;
                  weight += (prefs.getInt('weight3') ?? 0) * 0.1;

                  int glucose = (prefs.getInt('glucose1') ?? 0) * 100;
                  glucose += (prefs.getInt('glucose2') ?? 0) * 10;
                  glucose += (prefs.getInt('glucose3') ?? 0) * 1;

                  int heart_rate = (prefs.getInt('heart_rate1') ?? 0) * 100;
                  heart_rate += (prefs.getInt('heart_rate2') ?? 0) * 10;
                  heart_rate += (prefs.getInt('heart_rate3') ?? 0) * 1;

                  int oxygen = (prefs.getInt('oxygen1') ?? 0) * 10;
                  oxygen += (prefs.getInt('oxygen2') ?? 0) * 1;

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(email)
                      .collection('Vitals')
                      .doc(date)
                      .set({
                    'blood_oxygen': oxygen,
                    'blood_pressure': {
                      'Dia': bp_dia,
                      'Sys': bp_sys,
                    },
                    'body_weight': weight,
                    'glucose_level': glucose,
                    'heart_rate': heart_rate
                  });
                } on FirebaseAuthException catch (error) {
                  //HANDLE ERROR HERE

                } catch (err) {
                  // HANDLE ERROR HERE
                }
              },
              child: Button(
                  text: 'Let\'s Go',
                  width: 360.w,
                  fontsize: 16.sp,
                  fontweight: FontWeight.w600,
                  height: 60.h),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
