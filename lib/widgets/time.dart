import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Time_container extends StatefulWidget {
  final double height;
  final Function callback_time;
  const Time_container({Key? mykey, required this.height, required this.callback_time }): super(key: mykey);

  @override
  State<Time_container> createState() => _Time_containerState();
}

class _Time_containerState extends State<Time_container> {
  var passController = TextEditingController();
  final item = ['AM','PM'];
  var hours_ = TextEditingController();
  var minutes_ = TextEditingController();
  String zone ='AM';
  String time_='AM';
  callback(varTopic){
    setState(() {
      zone=varTopic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(heading: 'Time'),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.white,
              height: 45,
              width: 45,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: hours_,
                onChanged: (text) {
                  widget.callback_time(hours_.text+'-'+minutes_.text+'-'+zone);
                },
                style: TextStyle(
                  color: Colors.grey
                ),
                inputFormatters: [
                  CustomRangeTextInputFormatter(rang_: 12),
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5),
                  hintText: "00",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide(),
                  )
                ),
              ),
            ),
            SizedBox(width: 4,),
            Text(':',style: TextStyle(fontSize: 20,color: Colors.grey.shade500),),
            SizedBox(width: 4,),
            Container(
              color: Colors.white,
              height: 45,
              width: 45,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: minutes_,
                onChanged: (text) {
                  widget.callback_time(hours_.text+'-'+minutes_.text+'-'+zone);
                },
                style: TextStyle(
                  color: Colors.grey
                ),
                inputFormatters: [
                  CustomRangeTextInputFormatter(rang_: 60),
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5),
                  hintText: "00",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),

            ),
            SizedBox(width: 4,),
            Container(
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey
                ),
                borderRadius: BorderRadius.circular(9)
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    // hint: Text('Select Item:$dropdownValue'),
                    value: zone,
                    icon: SizedBox.shrink(),
                    onChanged: (String? value) {
                      // StepState(() {
                      //   nameController = value!;
                      // });
                      callback(value!);
                    },
                    items: item.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: Colors.grey),),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        Spacer()
      ],
    );
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final int rang_;

   CustomRangeTextInputFormatter({required this.rang_});
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue,) { 
    if(newValue.text == '')
      return TextEditingValue();
    else if(int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > rang_ ? TextEditingValue().copyWith(text: rang_.toString()) : newValue;
  }
}



class dropdown_heading extends StatefulWidget {
  final List<String> items;
  final String nameController;
  final Function callbackFunction;
  final double width;
  final String heading;

  // const dropdown_heading({super.key});
  const dropdown_heading({Key? mykey, required this.items, required this.nameController, required this.callbackFunction, required this.width, required this.heading}) : super(key: mykey);

  @override
  State<dropdown_heading> createState() => _dropdown_headingState();
}

class _dropdown_headingState extends State<dropdown_heading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(heading: widget.heading),
        Spacer(),
        Container(
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(9)

          ),
          child: getText(items: widget.items, nameController: widget.nameController, callbackFunction: widget.callbackFunction),
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
          // hint: Text('Select Item:$dropdownValue'),
          value: widget.nameController,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (String? value) {
            // StepState(() {
            //   nameController = value!;
            // });
            widget.callbackFunction(value!);
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(color: Colors.grey),),
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
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
    );
  }
}

