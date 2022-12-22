import 'package:aster_hf/screens/thankyou_screen.dart';
import 'package:aster_hf/widgets/user_data_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserData extends StatelessWidget {
  static const routename = '/userdata';

  String _getTitle(String page) {
    String abc = 'Error';
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
              children: [
                Spacer(
                  flex: 55,
                ),
                DataBox('bp_sys1'),
                DataBox('bp_sys2'),
                DataBox('bp_sys3'),
                Text(
                  "Sys",
                  style: GoogleFonts.poppins(
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
              children: [
                Spacer(
                  flex: 55,
                ),
                DataBox('bp_dia1'),
                DataBox('bp_dia2'),
                DataBox('bp_dia3'),
                Text(
                  "Dia",
                  style: GoogleFonts.poppins(
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
              children: [
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
            Text(
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
              children: [
                DataBox('glucose1'),
                DataBox('glucose2'),
                DataBox('glucose3'),
              ],
            ),
            Text(
              'mg/dl',
              style: TextStyle(
                  color: Color.fromRGBO(253, 71, 71, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        );
        ;
        break;
      case 'heart_rate':
        abc = Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DataBox('heart_rate1'),
                DataBox('heart_rate2'),
                DataBox('heart_rate3'),
              ],
            ),
            Text(
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
              children: [
                DataBox('oxygen1'),
                DataBox('oxygen2'),
              ],
            ),
            Text(
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
    final routes =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: (routes['page'] != 'blood_pressure')
                ? Navigator.of(context).pop
                : null,
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: (routes['page'] != 'blood_pressure')
                  ? Colors.black
                  : Colors.white,
            ),
          )),
      body: Stack(
        alignment: Alignment(0, 0.5),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 10,
              ),
              Text(
                _getTitle(routes['page']),
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
                textAlign: TextAlign.center,
              ),
              Spacer(flex: 14),
              _sliderWindow(routes['page']),
              Spacer(
                flex: 61,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  String page = '';

                  switch (routes['page']) {
                    case 'blood_pressure':
                      page = 'body_weight';

                      break;
                    case 'body_weight':
                      page = 'glucose_level';

                      break;

                    case 'glucose_level':
                      page = 'heart_rate';

                      break;
                    case 'heart_rate':
                      page = 'blood_oxygen';

                      break;

                    default:
                  }
                  if (routes['progress'] != 100) {
                    Navigator.of(context).pushNamed(UserData.routename,
                        arguments: {
                          'page': page,
                          'progress': routes['progress'] + 20
                        });
                  } else {
                    Navigator.of(context).pushNamed(ThankYouScreen.routename);
                  }
                },
                child: SvgPicture.asset('assets/home/arrow.svg', height: 75),
              ),
              CircularStepProgressIndicator(
                totalSteps: 120,
                currentStep: routes['progress'],
                selectedColor: Color.fromRGBO(105, 92, 212, 1),
                unselectedColor: Colors.white,
                width: 123,
                height: 123,
                selectedStepSize: 6,
                roundedCap: (_, __) => true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
