import 'package:flutter/material.dart';
class CategoryBottomSheet extends StatefulWidget {
  final Map? a;
  const CategoryBottomSheet({
    required this.a,Key? key}) : super(key: key);

  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  bool greyedOut=false;
  var categoryList= ['Body Weight','Blood Pressure','Heart Rate','Glucose Level', 'Blood Oxygen'];
  int category_index=7;
  @override
  void initState()  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(35, 0, 34, 0),

      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        color: Color.fromARGB(1, 242, 244, 246),
      ),
      height: 490.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(height: 32,),
          const Center(
            child: Text(
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'poppins',
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 320,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 146/83,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14),
                itemCount: categoryList.length,
                itemBuilder: (BuildContext context, index) {
                  greyedOut=true;
                  if(index ==0 && !(widget.a!.containsKey('body_weight'))){
                    greyedOut=false;
                  }
                  if(index ==1 && !(widget.a!.containsKey('blood_pressure'))){
                    greyedOut=false;
                  }if(index ==2 && !(widget.a!.containsKey('heartRate'))){
                    greyedOut=false;
                  }if(index ==3 && !(widget.a!.containsKey('glucose_level'))){
                    greyedOut=false;
                  }if(index ==4 && !(widget.a!.containsKey('blood_oxygen'))){
                    greyedOut=false;
                  }
                  if(greyedOut==true){
                    return Container(
                      padding: const EdgeInsets.fromLTRB(0, 14.5, 0, 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white10,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/categoryIcon$index.png'),
                            color:const Color(0xff695CD4),
                            size: 38,
                          ),
                          Text(
                            categoryList[index],
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 14,
                              color:Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }else{
                    return GestureDetector(
                      child: Container(
                        // height: 83,
                        // width: 146,
                        padding: const EdgeInsets.fromLTRB(0, 14.5, 0, 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (category_index==index) ? const Color(0xff695CD4):const Color.fromARGB(1, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageIcon(
                              AssetImage('assets/images/categoryIcon$index.png'),
                              color:(category_index==index) ? Colors.white:const Color(0xff695CD4),
                              size: 38,
                            ),
                            Text(
                              categoryList[index],
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 14,
                                color:(category_index==index) ? Colors.white:const Color(0xff695CD4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          category_index=index;
                        });
                      },
                    );
                  }

                }),
          ),
          GestureDetector(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                  color: Color(0xff695CD4),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Text(
                  'COMPLETE TODAYS LOG',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            onTap: (){
            },
          ),

        ],
      ),
    );
  }
}