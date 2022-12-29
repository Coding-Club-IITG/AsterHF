import 'package:flutter/material.dart';
import 'package:aster_hf/widgets/form_field_widgets.dart';
import 'package:flutter_svg/svg.dart';

class FoodAndPills extends StatefulWidget {
  final double height;
  final double width;
  final Function callbackFunction;
  final int whichTime;
  const FoodAndPills(
      {super.key,
      required this.height,
      required this.width,
      required this.callbackFunction,
      required this.whichTime});

  @override
  State<FoodAndPills> createState() => FoodandPillsState();
}

class FoodandPillsState extends State<FoodAndPills> {
  int whichSelected = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Heading(heading: 'Food and Pills'),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  whichSelected = 1;
                  widget.callbackFunction(whichSelected);
                  setState(() {
                    whichSelected = 1;
                  });
                },
                child: Container(
                  height: widget.height,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                   
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: whichSelected != 1
                            ? SvgPicture.asset(
                                'assets/form_images/before_meal.svg',color: const Color.fromRGBO(140, 142, 151, 1),)
                            : SvgPicture.asset(
                                'assets/form_images/before_meal.svg',color: Theme.of(context).primaryColor,),
                      ),
                      Expanded(
                        flex: 1,
                        child: whichSelected != 1
                            ? const Text('Before Meal')
                            : const Text(
                                'Before Meal',
                                style: TextStyle(color: Color(0xff695CD4)),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  whichSelected = 2;
                  widget.callbackFunction(whichSelected);
                  setState(() {
                    whichSelected = 2;
                  });
                },
                child: Container(
                  height: widget.height,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,

  
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: whichSelected != 2
                            ? SvgPicture.asset(
                                'assets/form_images/during_meal.svg',color: const Color.fromRGBO(140, 142, 151, 1),)
                            : SvgPicture.asset(
                                'assets/form_images/during_meal.svg',
                                color: Theme.of(context).primaryColor,
                              ),
                      ),
                 
                      Expanded(
                        child: whichSelected != 2
                            ? const Text('During Meal')
                            : const Text(
                                'During Meal',
                                style: TextStyle(color: Color(0xff695CD4)),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  whichSelected = 3;
                  widget.callbackFunction(whichSelected);
                  setState(() {
                    whichSelected = 3;
                  });
                },
                child: Container(
                  height: widget.height,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,

                    
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Expanded(
                        flex: 2,
                        child: whichSelected != 3
                            ? SvgPicture.asset(
                                'assets/form_images/after_meal.svg', color: const Color.fromRGBO(140, 142, 151, 1),)
                            : SvgPicture.asset(
                                'assets/form_images/after_meal.svg',
                                color: Theme.of(context).primaryColor,
                              ),
                      ),
                      Expanded(
                        child: whichSelected != 3
                            ? const Text('After Meal')
                            : const Text(
                                'After Meal',
                                style: TextStyle(color: Color(0xff695CD4)),
                              ),
                      )
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
