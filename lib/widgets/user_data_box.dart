import 'package:aster_hf/widgets/scroll_digit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBox extends StatelessWidget {
  final String type;

  const DataBox(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      padding: const EdgeInsets.only(bottom: 10),
      width: 46,
      height: 66,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ListWheelScrollView.useDelegate(
        itemExtent: 45,

        // controller: _controller,
        perspective: 0.005,
        diameterRatio: 1.0,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) async {
          try {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setInt(type, index);
          } catch (e) {
            print(e);
          }
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 10,
          builder: (context, index) {
            return DigitScroll(
              data: index,
            );
          },
        ),
      ),
    );
  }
}
