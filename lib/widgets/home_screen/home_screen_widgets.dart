import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      width: 145,
      decoration: BoxDecoration(
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
              '$parameterWord1\n$parameterWord2 ( $units )\n',
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
                  parameterValue,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isProgress
                        ? const Color(0xFF39CA76)
                        : const Color(0xFFFD4747),
                    fontSize: 16.0,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    isProgress
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
              "Last $lastUpdateTime $lastUpdateTimeUnit ago",
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

class MedicineReminderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
