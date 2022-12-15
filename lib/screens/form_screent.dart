import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample/time.dart';

import 'food_pills.dart';


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
                      Heading(heading: 'Medecine Name'),
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
                            height: height*0.085,
                            child: dropdown_heading(items: item_Amount, nameController: value_amount, callbackFunction: callback_amount, width: width*0.42, heading: 'Amount',)
                          ),
                          Spacer(),
                          SizedBox(
                            height: height*0.085,
                            child: dropdown_heading(items: item_Repeat, nameController: value_repeat, callbackFunction: callback_repeat, width: width*0.42, heading: 'Repeat',)
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          SizedBox(
                            height: height*0.085,
                            child: dropdown_heading(items: item_Frequency, nameController: value_frequency, callbackFunction: callback_frequency, width: width*0.42, heading: 'Frequency',)
                            
                          ),
                          Spacer(),
                          SizedBox(
                            height: height*0.085,
                            child: dropdown_heading(items: item_Howlong, nameController: value_howlong, callbackFunction: callback_howlong, width: width*0.42, heading: 'How Long',)
                          ),
                        ],
                      ),
                      
                      Container(
                        height: height*0.133,
                        child: Foodand_Pills(height: height*0.1,width: width*0.27,callbackFunction: callback_meal,which_time: during_meal,)
                      ),
                      
                      Row(
                        children: [
                          SizedBox(
                            height: height*0.084,
                            child: Time_container(height: height*0.084,callback_time: callback_time,),
                          ),
                          Spacer(),
                          SizedBox(
                            height: height*0.084,
                            child: dropdown_heading(items: item_NextDosge, nameController: value_nextdosge, callbackFunction: callback_nextdosge, width: width*0.42, heading: 'Next Dosage',)
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height*0.085,
                        child: dropdown_heading(items: item_Remindme, nameController: value_remindme, callbackFunction: callback_remindme, width: width*0.94, heading: 'Remind me',)
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          
                          onPressed: () {
                            _register();
                          }, 
                          child: Text('Save Medication Reminder'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 139, 49, 155), 
                            shape: RoundedRectangleBorder( 
                              borderRadius: BorderRadius.circular(9)
                            ),
                            
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
































// Widget buildTextField(String labelText, String placeholder , bool isPasswordTextField){
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 15),
//     child: TextField(
//       obscureText: isPasswordTextField ? false : false,
//       decoration: InputDecoration(
//         suffixIcon: isPasswordTextField ?
//         IconButton(
//           onPressed: () {
//           }, 
//           icon: const Icon(
//             Icons.remove_red_eye,
//             color: Colors.grey,
//           )
//         ):null,
//         contentPadding: const EdgeInsets.only(bottom: 5),
//         labelText: labelText,
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         hintText: placeholder,
//         hintStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         )
//       ),
//     ),
//   );
// }



// class DropdownButtonExample extends StatefulWidget {
//   const DropdownButtonExample({super.key});

//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }

// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   List<String> list = <String>[
//       "Item 1","Item 2", "Item 3" ,"Item 4", "Item 5"
//     ];
//   String dropdownValue = "Item 1";

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
