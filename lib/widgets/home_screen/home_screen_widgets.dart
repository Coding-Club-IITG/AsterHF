import 'package:aster_hf/controllers/user_data_controller.dart';
import 'package:aster_hf/main.dart';
import 'package:aster_hf/screens/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:aster_hf/widgets/vital_type_list.dart';
import 'package:aster_hf/controllers/is_progress_vitals.dart';

class ActivityWidget extends StatefulWidget {
  final int vitalType;
  final String parameterValue;
  bool isProgress = true;

  ActivityWidget({
    super.key,
    required this.vitalType,
    required this.parameterValue,
  });

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  @override
  void initState() {
    Future<void> asyncInitStateBloodPressure() async {
      String sysValue = widget.parameterValue
          .substring(0, widget.parameterValue.indexOf('/'));
      String diaValue = widget.parameterValue
          .substring(widget.parameterValue.indexOf('/') + 1);
      // extraction of value of sys in reading of form sys/dia
      if (await isProgressForWidgetBloodPressure(
          date, double.parse(sysValue), double.parse(diaValue))) {
        setState(() {
          widget.isProgress = true;
        });
      } else {
        setState(() {
          widget.isProgress = false;
        });
      }
    }

    
    Future<void> asyncInitState() async {
      if (await isProgressForWidget(date, firebaseList[widget.vitalType - 1],
          double.parse(widget.parameterValue))) {
        setState(() {
          widget.isProgress = true;
        });
      } else {
        setState(() {
          widget.isProgress = false;
        });
      }
    }

  

    if (widget.vitalType == 1) {
      asyncInitStateBloodPressure();
    } else {
      asyncInitState();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 145,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 9.0, 0.0),
            child: Text(
              '${vitalTypeWordOne[widget.vitalType - 1]}\n${vitalTypeWordTwo[widget.vitalType - 1]} ( ${vitalTypeUnits[widget.vitalType - 1]} )\n',
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                height: 1.42,
                color: Color(0xFF3D3D3D),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 7.0, 41.0, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.parameterValue,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: widget.isProgress
                        ? const Color(0xFF39CA76)
                        : const Color(0xFFFD4747),
                    fontSize: 16.0,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    widget.isProgress
                        ? 'assets/home/progress.png'
                        : 'assets/home/regress.png',
                    height: 8.0,
                    width: 12.0,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DailyLogWidget extends StatefulWidget {
  final int percentComplete;

  const DailyLogWidget({
    super.key,
    required this.percentComplete,
  });

  @override
  State<DailyLogWidget> createState() => _DailyLogWidgetState();
}

class _DailyLogWidgetState extends State<DailyLogWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(27.0, 20, 27, 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 3.26, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (widget.percentComplete == 100)
                        ? "Your daily log \nis complete!"
                        : (widget.percentComplete > 50)
                            ? "Your daily log \nis almost done!"
                            : "Please complete \nyour daily log!",
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 24,
                    width: 180.h,
                    child: Visibility(
                      visible: widget.percentComplete == 100 ? false : true,
                      child: ElevatedButton(
                        onPressed: () async {
                          final screen =
                              await UserDataController.getNextScreen();
                          final page = screen['page'];
                          final progress = screen['progress'];

                          Navigator.pushReplacement(
                              navigatorKey.currentContext!,
                              PageTransition(
                                  child:
                                      UserData(page: page, progress: progress,isPoppable: false,),
                                  type: PageTransitionType.fade));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF695CD4)),
                        ),
                        child: const Text("COMPLETE TODAY'S LOG",
                            style: TextStyle(
                                fontSize: 8.54, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CircularPercentIndicator(
              radius: 39.0,
              lineWidth: 5.0,
              percent: (widget.percentComplete / 100).toDouble(),
              center: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.percentComplete.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      color: Color(0xFF695CD4),
                    ),
                  ),
                  const SizedBox(width: 2.0),
                  const Text(
                    "%",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0,
                      color: Color(0xFF695CD4),
                    ),
                  ),
                ],
              ),
              progressColor: const Color(0xFF695CD4),
              backgroundColor: const Color(0xFFEFE0FF),
              circularStrokeCap: CircularStrokeCap.round,
            )
          ],
        ),
      ),
    );
  }
}
