import 'package:aster_hf/decorations/user_data_style.dart';
import 'package:aster_hf/screens/user_data/user_weight.dart';
import 'package:aster_hf/widgets/user_data_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserBp extends StatefulWidget {
  const UserBp({Key? key}) : super(key: key);

  @override
  State<UserBp> createState() => _UserBpState();
}

class _UserBpState extends State<UserBp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Column(
              children: [
                Text("Enter your Blood", style: textStyle,),
                Text("Pressure", style: textStyle,)
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30,),
                  Row(
                    children: [
                      DataBox(),
                      DataBox(),
                      DataBox(),
                  ],
                  ),
                  Text(
                    "Sys",
                    style: GoogleFonts.poppins(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30,),
                    Row(
                      children: [
                        DataBox(),
                        DataBox(),
                        DataBox(),
                      ],
                    ),
                    Text(
                      "Dia",
                      style: GoogleFonts.poppins(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ]
              ),
              Text(
                "mmHg",
                style: GoogleFonts.poppins(
                  color: Color.fromRGBO(5, 146, 64, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            child: Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromRGBO(105, 92, 212, 1)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(38),
                  )
              ),
              child: IconButton(
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserWeight()),
                    );
                },
                icon: const Icon(
                  Icons.arrow_forward_outlined,
                  color: Color.fromRGBO(105, 92, 212, 1),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
