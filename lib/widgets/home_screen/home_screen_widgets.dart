import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ActivityWidget extends StatefulWidget {
  final String parameterWord1;
  final String parameterWord2;
  final String units;
  final String parameterValue;
  final bool isProgress;
  final int lastUpdateTime;
  final String lastUpdateTimeUnit; // can take values mins, hrs or days

  ActivityWidget({
    required this.parameterWord1,
    required this.parameterWord2,
    required this.units,
    required this.parameterValue,
    required this.isProgress,
    required this.lastUpdateTime,
    required this.lastUpdateTimeUnit,
  });

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 145,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 29.0, 9.0, 0.0),
            child: Text(
              '${widget.parameterWord1}\n${widget.parameterWord2} ( ${widget.units} )\n',
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
            padding: const EdgeInsets.fromLTRB(15.0, 11.0, 41.0, 0.0),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 41.0, 0.0),
            child: Text(
              "Last ${widget.lastUpdateTime} ${widget.lastUpdateTimeUnit} ago",
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8C8E97),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DailyLogWidget extends StatefulWidget {
  final int percentComplete;
  Function completeDailyLog;

  DailyLogWidget(
      {super.key,
      required this.percentComplete,
      required this.completeDailyLog});

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
                        : "Your daily log \nis almost done!",
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 24,
                    width: 180.h,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.completeDailyLog;
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF695CD4)),
                      ),
                      child: const Text("COMPLETE TODAY'S LOG",
                          style: TextStyle(
                              fontSize: 8.54, fontWeight: FontWeight.w600)),
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

class Medicine {
  final String medicineName;
  final String
      quantity; // in ml if isTablet is false. if isTablet is true, quantity will be just a number

  Medicine({required this.medicineName, required this.quantity});
}

class MedicineWidget extends StatefulWidget {
  final bool
      isWidgetActive; // true if the medicine is activitely pending and to be taken right next
  final String timeForMedicineIntake;
  List<Medicine> beforeMeal;
  List<Medicine> afterMeal;
  IconData? icon;

  MedicineWidget(
      {super.key,
      required this.isWidgetActive,
      required this.timeForMedicineIntake,
      required this.beforeMeal,
      required this.afterMeal}) {
    if (timeForMedicineIntake == "Morning") {
      icon = Icons.local_cafe;
    } else if (timeForMedicineIntake == "Afternoon") {
      icon = Icons.light_mode_outlined;
    } else {
      icon = Icons.dark_mode_outlined;
    }
  }

  @override
  State<MedicineWidget> createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 195,
      width: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Row(
                children: [
                  const SizedBox(width: 5.0),
                  Icon(
                    widget.icon,
                    size: 20,
                    color: widget.isWidgetActive
                        ? const Color(0xFF695CD4)
                        : const Color(0xFFC5C4C8),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    widget.timeForMedicineIntake,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.isWidgetActive
                          ? const Color(0xFF695CD4)
                          : const Color(0xFFC5C4C8),
                    ),
                  ),
                ],
              ),
            ),
            widget.beforeMeal.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Before Food",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: Color(0xFFC5C4C8)),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 36.0,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: widget.beforeMeal.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.beforeMeal[index].medicineName,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.beforeMeal[index].quantity,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(height: 0),
            widget.afterMeal.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "After Food",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: Color(0xFFC5C4C8)),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 36.0,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: widget.afterMeal.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.afterMeal[index].medicineName,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.afterMeal[index].quantity,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
