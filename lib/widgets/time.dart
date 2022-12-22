import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class timeContainer extends StatefulWidget {
  final double height;
  final Function callback_time;
  const timeContainer({Key? mykey, required this.height, required this.callback_time }): super(key: mykey);

  @override
  State<timeContainer> createState() => _timeContainerState();
}

class _timeContainerState extends State<timeContainer> {
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
              height: widget.height,
              width: 45,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: hours_,
                onChanged: (text) {
                  widget.callback_time(_time(hours_, minutes_, zone));
                },
                style: TextStyle(
                  color: Color(0xff8C8E97)
                ),
                inputFormatters: [
                  customRangeTextInputFormatter(rang_: 12),
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5),
                  hintText: "00",
                  hintStyle: TextStyle(
                    color: Color(0xff8C8E97),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    borderSide: BorderSide(),
                  )
                ),
              ),
            ),
            SizedBox(width: 5,),
            Text(':',style: TextStyle(fontSize: 20,color: Color(0xff8C8E97),),),
            SizedBox(width: 5,),
            Container(
              color: Colors.white,
              height: widget.height,
              width: 45,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: minutes_,
                onChanged: (text) {
                  
                  widget.callback_time(_time(hours_, minutes_, zone));
                },
                style: TextStyle(
                  color: Color(0xff8C8E97),
                ),
                inputFormatters: [
                  customRangeTextInputFormatter(rang_: 60),
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5),
                  hintText: "00",
                  hintStyle: TextStyle(
                    color: Color(0xff8C8E97),
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
              height: widget.height,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff8C8E97),
                ),
                borderRadius: BorderRadius.circular(9)
              ),
              alignment: Alignment.center,
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  child: DropdownButton<String>(
                    value: zone,
                    icon: SizedBox.shrink(),
                    onChanged: (String? value) {
                      // callback(value!);
                      zone=value!;
                      widget.callback_time(_time(hours_, minutes_, zone));
                      setState(() {
                        zone=value;
                      });
                    },
                    alignment: Alignment.center,
                    items: item.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: Color(0xff8C8E97),)),
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
  String _time(TextEditingController h,TextEditingController m,String s){
    if(h==null && m == null){
      return '00-00-'+s;
    }
    else if(h==null){
      return '00-'+m.text+'-'+s;
    }
    else if(m==null){
      return h.text+'-00-'+s;
    }
    else{
      return h.text+'-'+m.text+'-'+s;
    }
  }
}

class customRangeTextInputFormatter extends TextInputFormatter {
  final int rang_;

   customRangeTextInputFormatter({required this.rang_});
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue,) { 
    if(newValue.text == '')
      return TextEditingValue();
    else if(int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > rang_ ? TextEditingValue().copyWith(text: rang_.toString()) : newValue;
  }
}



class dropdownWithHeading extends StatefulWidget {
  final List<String> items;
  final String nameController;
  final Function callbackFunction;
  final double width;
  final String heading;

  // const dropdown_heading({super.key});
  const dropdownWithHeading({Key? mykey, required this.items, required this.nameController, required this.callbackFunction, required this.width, required this.heading}) : super(key: mykey);

  @override
  State<dropdownWithHeading> createState() => _dropdownWithHeadingState();
}

class _dropdownWithHeadingState extends State<dropdownWithHeading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Heading(heading: widget.heading),
        SizedBox(height: 5,),
        Container(
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff8C8E97),
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
              child: Text(value,style: TextStyle(color: Color(0xff8C8E97)),),
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

