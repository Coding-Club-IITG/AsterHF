import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeContainer extends StatefulWidget {
  final double height;
  final Function callbackTime;
  const TimeContainer(
      {Key? mykey, required this.height, required this.callbackTime})
      : super(key: mykey);

  @override
  State<TimeContainer> createState() => TimeContainerState();
}

class TimeContainerState extends State<TimeContainer> {
  var passController = TextEditingController();
  final item = ['AM', 'PM'];
  var hours_ = TextEditingController();
  var minutes_ = TextEditingController();
  String zone = 'AM';
  String time_ = 'AM';
  callback(varTopic) {
    setState(() {
      zone = varTopic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Heading(heading: 'Time'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: widget.height,
              width: 45,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: hours_,
                onChanged: (text) {
                  widget.callbackTime(_time(hours_, minutes_, zone));
                },
                inputFormatters: [
                  CustomRangeTextInputFormatter(rang_: 12),
                ],
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xff8C8E97),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  hintText: '00',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(top: 6),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(140, 142, 151, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(224, 224, 224, 224),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              ':',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff8C8E97),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              height: widget.height,
              width: 45,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: minutes_,
                onChanged: (text) {
                  widget.callbackTime(_time(hours_, minutes_, zone));
                },
                
                inputFormatters: [
                  CustomRangeTextInputFormatter(rang_: 60),
                ],
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xff8C8E97),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  hintText: '00',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(top: 6),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(140, 142, 151, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(224, 224, 224, 224),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              height: widget.height,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff8C8E97),
                  ),
                  borderRadius: BorderRadius.circular(9)),
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  child: DropdownButton<String>(
                    value: zone,
                    icon: const SizedBox.shrink(),
                    onChanged: (String? value) {
                      // callback(value!);
                      zone = value!;
                      widget.callbackTime(_time(hours_, minutes_, zone));
                      setState(() {
                        zone = value;
                      });
                    },
                    alignment: Alignment.center,
                    items: item.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(
                              color: Color(0xff8C8E97),
                            )),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer()
      ],
    );
  }

  String _time(TextEditingController h, TextEditingController m, String s) {
    if ((h.text == '') && (m.text == '')) {
      return '00:00 $s';
    } else if (h.text == '') {
      return '00:${m.text} $s';
    } else if (m.text == '') {
      return '${h.text}:00 $s';
    } else {
      return '${h.text}:${m.text} $s';
    }
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final int rang_;

  CustomRangeTextInputFormatter({required this.rang_});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (int.parse(newValue.text) < 1) {
      return const TextEditingValue().copyWith(text: '1');
    }

    return int.parse(newValue.text) > rang_
        ? const TextEditingValue().copyWith(text: rang_.toString())
        : newValue;
  }
}

class DropdownWithHeading extends StatefulWidget {
  final List<String> items;
  final String nameController;
  final Function callbackFunction;
  final double width;
  final String heading;

  // const dropdown_heading({super.key});
  const DropdownWithHeading(
      {Key? mykey,
      required this.items,
      required this.nameController,
      required this.callbackFunction,
      required this.width,
      required this.heading})
      : super(key: mykey);

  @override
  State<DropdownWithHeading> createState() => _dropdownWithHeadingState();
}

class _dropdownWithHeadingState extends State<DropdownWithHeading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(heading: widget.heading),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: widget.width,
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff8C8E97),
              ),
              borderRadius: BorderRadius.circular(9)),
          child: getText(
              items: widget.items,
              nameController: widget.nameController,
              callbackFunction: widget.callbackFunction),
        ),
      ],
    );
  }
}

class getText extends StatefulWidget {
  final List<String> items;
  final String? nameController;
  final Function callbackFunction;
  final bool? show;

  const getText({
    Key? key,
    required this.items,
    required this.nameController,
    required this.callbackFunction,
    this.show,
  }) : super(key: key);

  @override
  State<getText> createState() => _getTextState();
}

class _getTextState extends State<getText> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: widget.nameController,
          // icon: const Padding(
          //   padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
          //   child: Icon(Icons.down,size: 15,color: Color(0xff8C8E97),),
          // ),
          onChanged: (String? value) {
            widget.callbackFunction(value!);
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Color(0xff8C8E97)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Heading extends StatelessWidget {
  final String heading;

  const Heading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }
}
