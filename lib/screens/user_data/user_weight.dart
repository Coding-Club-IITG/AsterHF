import 'package:aster_hf/decorations/user_data_style.dart';
import 'package:aster_hf/screens/user_data/user_bp.dart';
import 'package:aster_hf/screens/user_data/user_weight.dart';
import 'package:aster_hf/widgets/user_data_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWeight extends StatefulWidget {
  const UserWeight({Key? key}) : super(key: key);

  @override
  State<UserWeight> createState() => _UserWeightState();
}

class _UserWeightState extends State<UserWeight> {
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
                Text("Enter your Body", style: textStyle,),
                Text("Weight", style: textStyle,)
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataBox(),
                  DataBox(),
                  DataBox(),
                  Text("."),
                  DataBox(),
                ],
              ),
              Text(
                "Kgs",
                style: GoogleFonts.poppins(
                  color: Color.fromRGBO(253, 71, 71, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Column(
            children: [
              Center(
                child: CustomPaint(
                  size: Size(123,123),
                  painter: OpenPainter(),
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
                ),
              ),
              SizedBox(height: 40,),
              Container(
                child: TextButton(
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        color: Color.fromRGBO(105, 92, 212, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserBp()),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromRGBO(105, 92, 212, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    //draw arc
    canvas.drawArc(Offset(-23, -23) & Size(123, 123),
        4.68, //radians
        1.3, //radians
        false,
        paint1);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}