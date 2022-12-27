import 'package:aster_hf/controllers/user_data.dart';
import 'package:aster_hf/main.dart';
import 'package:aster_hf/screens/thankyou_screen.dart';
import 'package:aster_hf/widgets/user_data_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserData extends StatelessWidget {
  static const routename = '/userdata';

  final String page;
  final int progress;

  UserData({super.key, required this.page, required this.progress});

  String _getTitle(String page) {
    String abc = 'Error';
    print('hello $page');
    switch (page) {
      case 'blood_pressure':
        abc = 'Enter your Blood\nPressure';
        break;
      case 'body_weight':
        abc = 'Enter your Body\nWeight';
        break;
      case 'glucose_level':
        abc = 'Enter your Glucose\nlevel';
        break;
      case 'heart_rate':
        abc = 'Enter your Heart\nRate';
        break;
      case 'blood_oxygen':
        abc = 'Enter your Blood\nOxygen';
        break;
    }
    return abc;
  }

  Widget _sliderWindow(String page) {
    Widget abc = const Text(
      'error',
      style: TextStyle(color: Colors.black),
    );

    switch (page) {
      case 'blood_pressure':
        abc = Column(
          children: [
            Row(
              children: const [
                Spacer(
                  flex: 55,
                ),
                DataBox('bp_sys1'),
                DataBox('bp_sys2'),
                DataBox('bp_sys3'),
                Text(
                  "Sys",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(
                  flex: 45,
                )
              ],
            ),
            Row(
              children: const [
                Spacer(
                  flex: 55,
                ),
                DataBox('bp_dia1'),
                DataBox('bp_dia2'),
                DataBox('bp_dia3'),
                Text(
                  "Dia",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(
                  flex: 45,
                ),
              ],
            ),
            const Text(
              'mmHg',
              style: TextStyle(
                  color: Color.fromRGBO(5, 146, 64, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        );
        break;
      case 'body_weight':
        abc = Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DataBox('weight1'),
                DataBox('weight2'),
                DataBox('weight3'),
                Text(
                  '.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                DataBox('weight4'),
              ],
            ),
            const Text(
              'Kgs',
              style: TextStyle(
                  color: Color.fromRGBO(253, 71, 71, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        );
        break;
      case 'glucose_level':
        abc = Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DataBox('glucose1'),
                DataBox('glucose2'),
                DataBox('glucose3'),
              ],
            ),
            const Text(
              'mg/dl',
              style: TextStyle(
                  color: Color.fromRGBO(253, 71, 71, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        );

        break;
      case 'heart_rate':
        abc = Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DataBox('heart_rate1'),
                DataBox('heart_rate2'),
                DataBox('heart_rate3'),
              ],
            ),
            const Text(
              'BPM',
              style: TextStyle(
                  color: Color.fromRGBO(5, 146, 64, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        );

        break;
      case 'blood_oxygen':
        abc = Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DataBox('oxygen1'),
                DataBox('oxygen2'),
              ],
            ),
            const Text(
              'SpO2',
              style: TextStyle(
                  color: Color.fromRGBO(5, 146, 64, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        );

        break;
    }
    return abc;
  }

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
          onPressed:
              (page != 'blood_pressure') ? Navigator.of(context).pop : null,
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: (page != 'blood_pressure') ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: Stack(
        alignment: const Alignment(0, 0.5),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 5,
              ),
              Text(
                _getTitle(page),
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 25),
              _sliderWindow(page),
              const Spacer(
                flex: 120,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String page1 = '';
                  print(page);

                  switch (page) {
                    case 'blood_pressure':
                      page1 = 'body_weight';

                      prefs.setBool('isBpSkipped', false);
                      break;

                    case 'body_weight':
                      page1 = 'glucose_level';

                      prefs.setBool('isWeightSkipped', false);

                      break;

                    case 'glucose_level':
                      page1 = 'heart_rate';
                      prefs.setBool('isGlucoseSkipped', false);

                      break;

                    case 'heart_rate':
                      page1 = 'blood_oxygen';
                      prefs.setBool('isHeartSkipped', false);
                      break;
                    case 'blood_oxygen':
                      page1 = 'home_screen';
                      prefs.setBool('isOxygenSkipped', false);
                      break;

                    default:
                  }
                  print('page1  == $page1');
                  final data = await UserDataController.getNextScreen();

                  final progress1 = data['progress'];
                  if (page1 == 'home_screen' || progress1 == 100) {
                    Navigator.of(navigatorKey.currentContext!).push(
                        PageTransition(
                            child: const ThankYouScreen(),
                            type: PageTransitionType.fade));
                  } else  {
                    Navigator.of(navigatorKey.currentContext!).push(
                        PageTransition(
                            child: UserData(page: page1, progress: progress1),
                            type: PageTransitionType.fade));
                  }
                },
                child: SvgPicture.asset('assets/home/arrow.svg', height: 75),
              ),
              CircularStepProgressIndicator(
                totalSteps: 120,
                currentStep: progress,
                selectedColor: const Color.fromRGBO(105, 92, 212, 1),
                unselectedColor: Colors.white,
                width: 123,
                height: 123,
                selectedStepSize: 6,
                roundedCap: (_, __) => true,
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.80),
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.purple[50])),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                print(page);

                var page1 = '';

                switch (page) {
                  case 'blood_pressure':
                    page1 = 'body_weight';
                    prefs.setBool('isBpSkipped', true);
                    break;

                  case 'body_weight':
                    page1 = 'glucose_level';
                    prefs.setBool('isWeightSkipped', true);

                    break;

                  case 'glucose_level':
                    page1 = 'heart_rate';
                    prefs.setBool('isGlucoseSkipped', true);

                    break;

                  case 'heart_rate':
                    page1 = 'blood_oxygen';
                    prefs.setBool('isHeartSkipped', true);
                    break;

                  case 'blood_oxygen':
                    page1 = '';
                    prefs.setBool('isOxygenSkipped', true);
                    break;

                  default:
                }
                final data = await UserDataController.getNextScreen();

                final progress1 = data['progress'];
                if (page1 == '') {
                  Navigator.of(navigatorKey.currentContext!).push(
                      PageTransition(
                          child: const ThankYouScreen(),
                          type: PageTransitionType.fade));
                } else {
                  Navigator.of(navigatorKey.currentContext!).push(
                      PageTransition(
                          child: UserData(page: page1, progress: progress1),
                          type: PageTransitionType.fade));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
