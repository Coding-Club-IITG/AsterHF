import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aster_hf/widgets/food_pills.dart';
import 'package:aster_hf/widgets/time.dart';
import 'dart:math';


class form_screen extends StatefulWidget {
  const form_screen({super.key});

  @override
  State<form_screen> createState() => _form_screenState();
}

class _form_screenState extends State<form_screen> {
  set value(String? value) {}
  final item_Amount = ["1","2", "3" ,"4", "5"];
  final item_Repeat = ["1","2", "3" ,"4"];
  final item_Frequency = ["Daily","Alternate days","Once a week", "Twice a week" ];
  final item_Howlong = ["Days","Times"];
  final item_NextDosge = ["Item 1","Item 2", "Item 3" ,"Item 4", "Item 5"];
  final item_Remindme = ["5 minutes before","10 minutes before","30 minutes before","1 hours before"];
  String value_amount = "1";
  String value_repeat = "1";
  String value_frequency = "Daily";
  String value_howlong = "Days";
  String value_nextdosge = "Item 1";
  String value_remindme = "5 minutes before";
  String value_time = "12";
  int during_meal=2;
  TextEditingController medecine_name_cont = TextEditingController();

  callback_amount(varTopic){
    setState(() {
      value_amount=varTopic;
    });
  }
  callback_repeat(varTopic){
    setState(() {
      value_repeat=varTopic;
    });
  }
  callback_frequency(varTopic){
    setState(() {
      value_frequency=varTopic;
    });
  }
  callback_howlong(varTopic){
    setState(() {
      value_howlong=varTopic;
    });
  }
  callback_nextdosge(varTopic){
    setState(() {
      value_nextdosge=varTopic;
    });
  }
  callback_remindme(varTopic){
    setState(() {
      value_remindme=varTopic;
    });
  }
  callback_meal(varTopic){
    setState(() {
      during_meal=varTopic;
    });
  }
  callback_time(varTopic){
    setState(() {
      value_time=varTopic;
    });
  }
  _register(){
    var data ={
      'Medecine Name' : medecine_name_cont.text,
      'amount' : value_amount,
      'repeat' : value_repeat,
      'frequency' :value_frequency,
      'howlong' :value_howlong,
      'nextdosge' : value_nextdosge,
      'remindme' : value_remindme
    };
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            // color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(
              Icons.cancel,
              // color: Colors.black,
            )
          )
        ],

        title: Center(
          child: Text(
            'Set Medication Reminder',
            style: TextStyle(
              // color: Colors.black,
            ),
          ),
        ),


      ),
      body: LayoutBuilder(
        builder: (context,constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding: EdgeInsets.all(width*0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('You can add reminders according to how the doctor has prescribed. Prescription automatically gets added if your doctor adds it to your account directly from his side', style: TextStyle(fontSize: 15, color: Colors.grey),),
              
                      ),
                      Heading(heading: 'Medecine Name',),
                      SizedBox(
                        child: TextField(
                          controller: medecine_name_cont,
                          style: TextStyle(
                            color: Colors.grey
                          ),
                          decoration: InputDecoration(
                            hintText: "Amaterm Softgel",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(),
                            )
                          ),
                        ),
                      ),
                      
                    
                      Row(
                        children: [
                          SizedBox(
                            height: max(height*0.09,67),
                            child: dropdown_heading(items: item_Amount, nameController: value_amount, callbackFunction: callback_amount, width: width*0.42, heading: 'Amount',)
                          ),
                          Spacer(),
                          SizedBox(
                            height: max(height*0.09,67),
                            child: dropdown_heading(items: item_Repeat, nameController: value_repeat, callbackFunction: callback_repeat, width: width*0.42, heading: 'Repeat',)
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          SizedBox(
                            height: max(height*0.09,67),
                            child: dropdown_heading(items: item_Frequency, nameController: value_frequency, callbackFunction: callback_frequency, width: width*0.42, heading: 'Frequency',),
                            
                          ),
                          Spacer(),
                          SizedBox(
                            height: max(height*0.09,67),
                            child: dropdown_heading(items: item_Howlong, nameController: value_howlong, callbackFunction: callback_howlong, width: width*0.42, heading: 'How Long',)
                          ),
                        ],
                      ),
                      
                      Container(
                        height: max(height*0.133,103),
                        child: Foodand_Pills(height: max(height*0.1,80),width: width*0.27,callbackFunction: callback_meal,which_time: during_meal,)
                      ),
                      
                      Row(
                        children: [
                          SizedBox(
                            height: max(height*0.09,67),
                            child: Time_container(height: height*0.055,callback_time: callback_time,),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: max(height*0.09,67),
                        child: dropdown_heading(items: item_Remindme, nameController: value_remindme, callbackFunction: callback_remindme, width: width*0.94, heading: 'Remind me',)
                      ),
                      GestureDetector(
                        onTap: () {
                          _register();
                        }, 
                        child: Container(
                          width: double.infinity,
                          height: max(height*0.055,43),
                          alignment: Alignment.center,
                          // child: ElevatedButton(
                            
                          child: Text('Save Medication Reminder'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            color: Color(0xff695CD4),
                          ),
                            
                        ),
                      ),
                    ],
                    
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}













