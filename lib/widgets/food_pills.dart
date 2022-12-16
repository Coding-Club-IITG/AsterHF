import 'package:flutter/material.dart';
import 'package:aster_hf/widgets/time.dart';

class Foodand_Pills extends StatefulWidget {
  final double height;
  final double width;
  final Function callbackFunction;
  final int which_time ;
  const Foodand_Pills({super.key, required this.height, required this.width, required this.callbackFunction, required this.which_time});

  @override
  State<Foodand_Pills> createState() => _Foodand_PillsState();
}

class _Foodand_PillsState extends State<Foodand_Pills> {
  int which_selected=1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Food and Pills',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                which_selected=1;
                widget.callbackFunction(which_selected!);
                setState(() {
                  which_selected=1;
                });
              },
              child: Container(
                height: widget.height,
                width: widget.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 202, 201, 201),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    which_selected!=1 ? Row_image(which_color: 0, selected: 1,height: widget.height,width: widget.width,) :Row_image(which_color: 1, selected: 1,height: widget.height,width: widget.width,),
                    which_selected!=1 ? Text('Before Meal') : Text('Before Meal' ,style: TextStyle(color: Color(0xff695CD4)),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                which_selected=2;
                widget.callbackFunction(which_selected!);
                setState(() {
                  which_selected=2;
                });
              },
              child: Container(
                height: widget.height,
                width: widget.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 202, 201, 201),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    which_selected!=2 ? Row_image(which_color: 0, selected: 2,height: widget.height,width: widget.width,) :Row_image(which_color: 1, selected: 2,height: widget.height,width: widget.width,),
                    which_selected!=2 ? Text('During Meal') : Text('During Meal' ,style: TextStyle(color: Color(0xff695CD4)),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.callbackFunction(which_selected!);
                setState(() {
                  which_selected=3;
                });
              },
              child: Container(
                height: widget.height,
                width: widget.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 202, 201, 201),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    which_selected!=3 ? Row_image(which_color: 0, selected: 3,height: widget.height,width: widget.width,) :Row_image(which_color: 1, selected: 3,height: widget.height,width: widget.width,),
                    which_selected!=3 ? Text('After Meal') : Text('After Meal' ,style: TextStyle(color: Color(0xff695CD4)),),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}


class Row_image extends StatefulWidget {
  final int which_color;
  final int selected;
  final double height;
  final double width;
  const Row_image({super.key, required this.which_color, required this.selected, required this.height, required this.width});

  @override
  State<Row_image> createState() => _Row_imageState();
}

class _Row_imageState extends State<Row_image> {
  List<List<String>> _Urls=[['assets/form_images/madicine.png','assets/form_images/medicine_color.png'],['assets/form_images/plate.png','assets/form_images/plate_color.png'],['assets/form_images/fork.png','assets/form_images/fork_color.png']];

  List<List<int>> cordina=[[0,1,2],[2,0,1],[2,1,0]];


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Image.asset(_Urls[cordina[widget.selected-1][0]][widget.which_color],height: widget.height*0.4,),
        Spacer(),
        Image.asset(_Urls[cordina[widget.selected-1][1]][widget.which_color],height: widget.height*0.4,),
        Spacer(),
        Image.asset(_Urls[cordina[widget.selected-1][2]][widget.which_color],height: widget.height*0.4,),
        Spacer(),
      ],
    );
  }
}
