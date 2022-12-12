import 'package:aster_hf/widgets/scroll_digit.dart';
import 'package:flutter/material.dart';

class DataBox extends StatefulWidget {
  const DataBox({Key? key}) : super(key: key);

  @override
  State<DataBox> createState() => _DataBoxState();
}

class _DataBoxState extends State<DataBox> {
  // late FixedExtentScrollController _controller;
  int data = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 46,
      height: 66,
      decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          )
      ),
      child: ListWheelScrollView.useDelegate(
          itemExtent: 46,
          // controller: _controller,
          perspective: 0.005,
          diameterRatio: 1.0,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) => {
            setState(() {
              data = index;
            })
          },
          childDelegate: ListWheelChildBuilderDelegate(
              childCount: 10,
              builder: (context, index) {
                return (DigitScroll(
                  data: index,
                )
                );
              }
              )
      ),
    );
  }
}
