import 'package:flutter/material.dart';
import 'package:aster_hf/widgets/time.dart';

class foodandPills extends StatefulWidget {
  final double height;
  final double width;
  final Function callbackFunction;
  final int which_time ;
  const foodandPills({super.key, required this.height, required this.width, required this.callbackFunction, required this.which_time});

  @override
  State<foodandPills> createState() => _foodandPillsState();
}

class _foodandPillsState extends State<foodandPills> {
  int which_selected=1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Heading(heading: 'Food and Pills'),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    which_selected=1;
                    widget.callbackFunction(which_selected);
                    setState(() {
                      which_selected=1;
                    });
                  },
                  child: Container(
                    height: widget.height,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal:5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 202, 201, 201),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: which_selected!=1 ? rowImage(which_color: 0, selected: 1,height: widget.height,width: widget.width,) :rowImage(which_color: 1, selected: 1,height: widget.height,width: widget.width,),
                        ),
                        Expanded(
                          flex: 1,
                          child: which_selected!=1 ? const Text('Before Meal') : const Text('Before Meal' ,style: TextStyle(color: Color(0xff695CD4)),),
                        )
                      ],
                    ),
                  ),
                ),
            ),
            
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    which_selected=2;
                    widget.callbackFunction(which_selected);
                    setState(() {
                      which_selected=2;
                    });
                  },
                  child: Container(
                    height: widget.height,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal:5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 202, 201, 201),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child:which_selected!=2 ? rowImage(which_color: 0, selected: 2,height: widget.height,width: widget.width,) :rowImage(which_color: 1, selected: 2,height: widget.height,width: widget.width,),
                        ),
                        Expanded(
                          child:which_selected!=2 ? const Text('During Meal') : const Text('During Meal' ,style: TextStyle(color: Color(0xff695CD4)),),
                        )
                      ],
                    ),
                  ),
                ),
            ),
        
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    which_selected=3;
                    widget.callbackFunction(which_selected);
                    setState(() {
                      which_selected=3;
                    });
                  },
                  child: Container(
                    height: widget.height,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal:5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 202, 201, 201),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: which_selected!=3 ? rowImage(which_color: 0, selected: 3,height: widget.height,width: widget.width,) :rowImage(which_color: 1, selected: 3,height: widget.height,width: widget.width,),),
                        Expanded(
                          child:which_selected!=3 ? const Text('After Meal') : const Text('After Meal' ,style: TextStyle(color: Color(0xff695CD4)),),)
                      ],
                    ),
                  ),
                ),
            ),
    
          ],
        )
      ],
    );
  }
}


class rowImage extends StatefulWidget {
  final int which_color;
  final int selected;
  final double height;
  final double width;
  const rowImage({super.key, required this.which_color, required this.selected, required this.height, required this.width});

  @override
  State<rowImage> createState() => _rowImageState();
}

class _rowImageState extends State<rowImage> {
  final List<List<String>> _Urls=[['assets/form_images/madicine.png','assets/form_images/medicine_color.png'],['assets/form_images/plate.png','assets/form_images/plate_color.png'],['assets/form_images/fork.png','assets/form_images/fork_color.png']];

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
