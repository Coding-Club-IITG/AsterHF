import 'package:flutter/material.dart';
import 'package:aster_hf/widgets/food_pills.dart';
import 'package:aster_hf/widgets/time.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class formScreen extends StatefulWidget {
  const formScreen({super.key});

  @override
  State<formScreen> createState() => _formScreenState();
}

class _formScreenState extends State<formScreen> {
  set value(String? value) {}
  final itemAmount = ["1","2", "3" ,"4", "5"];
  final itemRepeat = ["1","2", "3" ,"4"];
  final itemFrequency = ["Daily","Alternate days","Once a week", "Twice a week" ];
  final itemHowLong = ["Days","Times"];
  final itemReminders = ["5 minutes before","10 minutes before","30 minutes before","1 hours before"];
  String valueAmount = "1";
  String valueRepeat = "1";
  String valueFrequency = "Daily";
  String valueHowLong = "Days";
  var valueReminder = "5 minutes before";
  var valueTime = "12:00 PM";
  var duringMealList =['','Before Meal','During Meal','After Meal'];
  int duringMeal=2;
  TextEditingController valueHowLongInt = TextEditingController();
  TextEditingController medicineNameController = TextEditingController();

  callbackAmount(varTopic){
    setState(() {
      valueAmount=varTopic;
    });
  }
  callbackRepeat(varTopic){
    setState(() {
      valueRepeat=varTopic;
    });
  }
  callbackFrequency(varTopic){
    setState(() {
      valueFrequency=varTopic;
    });
  }
  callbackHowLong(varTopic){
    setState(() {
      valueHowLong=varTopic;
    });
  }
  callbackReminder(varTopic){
    setState(() {
      valueReminder=varTopic;
    });
  }
  callbackMeal(varTopic){
    print(varTopic);
    setState(() {
      duringMeal=varTopic;
    });
  }
  callbackTime(varTopic){
    setState(() {
      valueTime=varTopic;
    });
  }
  _register() async {
    var data ={
      'medicineName' : medicineNameController.text,
      'amount' : valueAmount,
      'repeat' : valueRepeat,
      'frequency' :valueFrequency,
      'howLong' :valueHowLong,
      'foodAndPills' : duringMealList[duringMeal],
      'reminder' : valueReminder,
      'timeReminder' : valueTime,
      'currentTime': DateTime.now(),
      
    };
    try{await FirebaseFirestore.instance
      .collection('users')
      .doc('mauryakk2004@gmail.com')
      .collection('Reminder')
      .doc(medicineNameController.text)
      .set(data);
    }catch(e){
      print(e);
    }
    print(data);
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
          icon: const Icon(
            Icons.arrow_back,
            // color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(
              Icons.close,
            )
          )
        ],

        title: const Center(
          child: Text('Set Medication Reminder',),
        ),


      ),
      
      
      body: SingleChildScrollView(
              child: GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text('You can add reminders according to how the doctor has prescribed. Prescription automatically gets added if your doctor adds it to your account directly from his side', style: TextStyle(fontSize: 15, color: Color(0xff8C8E97)),),
              
                      ),
                      SizedBox(height: 5,),
                      Heading(heading: 'Medicine Name',),
                      SizedBox(height: 5,),
                      Container(
                        width: double.infinity,
                        height: height*0.08,
                        child: TextField(
                          controller: medicineNameController,
                          style: const TextStyle(
                            color: Color(0xff8C8E97),
                          ),
                          decoration: const InputDecoration(
                            hintText: "Amaterm Softgel",
                            suffixIcon: Icon(Icons.document_scanner_outlined),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xff8C8E97),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              borderSide: BorderSide(),
                            )
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 5,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // height: max(height*0.09,67),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                              child: dropdownWithHeading(items: itemAmount, nameController: valueAmount, callbackFunction: callbackAmount, width: width*0.5, heading: 'Amount',),
                            )
                          ),
                          Expanded(
                            // height: max(height*0.09,67),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                              child: dropdownWithHeading(items: itemRepeat, nameController: valueRepeat, callbackFunction: callbackRepeat, width: width*0.5, heading: 'Repeat',),
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // height: max(height*0.09,67),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                              child: dropdownWithHeading(items: itemFrequency, nameController: valueFrequency, callbackFunction: callbackFrequency, width: width*0.5, heading: 'Frequency',),
                            )
                          ),
                          Expanded(
                            // height: max(height*0.09,67),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                              // child: dropdownWithHeading(items: itemHowLong, nameController: valueHowLong, callbackFunction: callbackHowLong, width: width*0.5, heading: 'How Long',),
                              child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Heading(heading: 'How Long'),
                                SizedBox(height: 5,),
                                Container(
                                  width: width*0.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff8C8E97),
                                    ),
                                    borderRadius: BorderRadius.circular(9)

                                  ),
                                  child: Row(
                                    children: [
                                      // SizedBox(width: 3,),
                                      Flexible(
                                        child: TextField(
                                            controller: valueHowLongInt,
                                            style: const TextStyle(
                                              color: Color(0xff8C8E97),
                                            ),
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              hintText: '00',
                                              hintStyle: TextStyle(
                                                // fontSize: 16,
                                                color: Color(0xff8C8E97),
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                      ),
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              value: valueHowLong,
                                              onChanged: (String? value) {
                                                callbackHowLong(value!);
                                              },
                                              icon: SizedBox.shrink(),
                                              items: itemHowLong.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value,style: TextStyle(color: Color(0xff8C8E97)),),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                            )
                          ),
                        ],
                      ),

                      SizedBox(height: 7,),
                      
                      Container(
                        height: max(height*0.13,103),
                        child: foodandPills(height: max(height*0.1,80),width: width*0.27,callbackFunction: callbackMeal,which_time: duringMeal,)
                      ),
                      
                      SizedBox(height: 7,),
                      Row(
                        children: [
                          SizedBox(
                            height: max(height*0.09,67),
                            child: timeContainer(height: height*0.055,callback_time: callbackTime,),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 3,),
                      SizedBox(
                        height: max(height*0.09,75),
                        child: dropdownWithHeading(items: itemReminders, nameController: valueReminder, callbackFunction: callbackReminder, width: width, heading: 'Remind me',)
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          _register();
                        }, 
                        child: Container(
                          width: double.infinity,
                          height: 46,
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
    );
  }
}













