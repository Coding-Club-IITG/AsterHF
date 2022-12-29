import 'package:aster_hf/main.dart';
import 'package:aster_hf/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/button.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  static const routename = '/thank';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          iconSize: 21,
          splashRadius: 22,
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        alignment: const Alignment(0, 0.65),
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 220.h,
                ),
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

                  int bpSys = (prefs.getInt('bp_sys1') ?? 0) * 100;
                  bpSys += (prefs.getInt('bp_sys2') ?? 0) * 10;
                  bpSys += (prefs.getInt('bp_sys3') ?? 0) * 1;

                  prefs.remove('bp_sys1');
                  prefs.remove('bp_sys2');
                  prefs.remove('bp_sys3');

                  int bpDia = (prefs.getInt('bp_dia1') ?? 0) * 100;
                  bpDia += (prefs.getInt('bp_dia2') ?? 0) * 10;
                  bpDia += (prefs.getInt('bp_dia3') ?? 0) * 1;

                  prefs.remove('bp_dia1');
                  prefs.remove('bp_dia2');
                  prefs.remove('bp_dia3');

                  double weight = (prefs.getInt('weight1') ?? 0) * 100;
                  weight += (prefs.getInt('weight2') ?? 0) * 10;
                  weight += (prefs.getInt('weight3') ?? 0) * 1;
                  weight += (prefs.getInt('weight4') ?? 0) * 0.1;

                  prefs.remove('weight1');
                  prefs.remove('weight2');
                  prefs.remove('weight3');
                  prefs.remove('weight4');

                  int glucose = (prefs.getInt('glucose1') ?? 0) * 100;
                  glucose += (prefs.getInt('glucose2') ?? 0) * 10;
                  glucose += (prefs.getInt('glucose3') ?? 0) * 1;

                  prefs.remove('glucose1');
                  prefs.remove('glucose2');
                  prefs.remove('glucose3');

                  int heartRate = (prefs.getInt('heart_rate1') ?? 0) * 100;
                  heartRate += (prefs.getInt('heart_rate2') ?? 0) * 10;
                  heartRate += (prefs.getInt('heart_rate3') ?? 0) * 1;

                  prefs.remove('heart_rate1');
                  prefs.remove('heart_rate2');
                  prefs.remove('heart_rate3');

                  int oxygen = (prefs.getInt('oxygen1') ?? 0) * 10;
                  oxygen += (prefs.getInt('oxygen2') ?? 0) * 1;

                  prefs.remove('oxygen1');
                  prefs.remove('oxygen2');

                  bool isBpSkipped = prefs.getBool('isBpSkipped') ?? true;
                  bool isWeightSkipped =
                      prefs.getBool('isWeightSkipped') ?? true;
                  bool isGlucoseSkipped =
                      prefs.getBool('isGlucoseSkipped') ?? true;
                  bool isHeartSkipped = prefs.getBool('isHeartSkipped') ?? true;
                  bool isOxygenSkipped =
                      prefs.getBool('isOxygenSkipped') ?? true;


                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(email)
                      .collection('Vitals')
                      .doc(date)
                      .set({
                    if (!isOxygenSkipped && oxygen != 0) 'blood_oxygen': oxygen,
                    if (!isBpSkipped)
                      if (bpDia != 0 && bpSys != 0)
                        'blood_pressure': {
                          'Dia': bpDia,
                          'Sys': bpSys,
                        },
                    if (!isWeightSkipped && weight != 0) 'body_weight': weight,
                    if (!isGlucoseSkipped && glucose != 0)
                      'glucose_level': glucose,
                    if (!isHeartSkipped && heartRate != 0)
                      'heartRate': heartRate
                  },SetOptions(merge: true));

                  Navigator.pushReplacement(
                      navigatorKey.currentContext!,
                      PageTransition(
                          child: const Home(), type: PageTransitionType.fade));
                } on FirebaseAuthException catch (error) {
                  print(error);
                  //HANDLE ERROR HERE

                } catch (err) {
                  print(err);
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
  }
}
