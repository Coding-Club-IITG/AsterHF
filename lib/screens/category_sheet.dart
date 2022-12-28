import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CategoryBottomSheet extends StatefulWidget {
  const CategoryBottomSheet({Key? key}) : super(key: key);

  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  Map a={};
  bool greyedOut=false;
  var categoryList= ['Body Weight','Blood Pressure','Heart Rate','Glucose Level', 'Blood Oxygen'];
  //int choice = 0;
   int category_index=7;
  //String exportFormat='PDF';
  @override
  void initState()  {
    super.initState();
    ()async {
      a = (await get_info(DateTime.now().toIso8601String().substring(0, 10)))!;
      print(DateTime.now().toIso8601String().substring(0, 10));
    }();
    //info();
  }
  // Future<void> info() async {
  //   a = await get_info(DateTime.now().toIso8601String().substring(0, 10));
  // }
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
          // const SizedBox(height: 22),
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
                  if(index ==0 && !(a.containsKey('body_weight'))){
                    greyedOut=false;
                  }
                  if(index ==1 && !(a.containsKey('blood_pressure'))){
                    greyedOut=false;
                  }if(index ==2 && !(a.containsKey('heart_rate'))){
                    greyedOut=false;
                  }if(index ==3 && !(a.containsKey('glucose_level'))){
                    greyedOut=false;
                  }if(index ==4 && !(a.containsKey('blood_oxygen'))){
                    greyedOut=false;
                  }
                  if(greyedOut==true){
                    return Container(
                      // height: 83,
                      // width: 146,
                      padding: const EdgeInsets.fromLTRB(0, 14.5, 0, 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white10,
                          width: 1,
                        ),
                      ),
                      // if(){
                      //
                      // }
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/categoryIcon$index.png'),
                            color:const Color(0xff695CD4),
                            size: 38,
                          ),
                          // const SizedBox(
                          //   height: 11.5,
                          // ),
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
                        // if(){
                        //
                        // }
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ImageIcon(
                              AssetImage('assets/images/categoryIcon$index.png'),
                              color:(category_index==index) ? Colors.white:const Color(0xff695CD4),
                              size: 38,
                            ),
                            // const SizedBox(
                            //   height: 11.5,
                            // ),
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

                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BloodPressureDetails()));
                        setState(() {
                          category_index=index;
                        });
                      },
                    );
                  }

                }),
          ),
          // SizedBox(height: 27,),
          GestureDetector(
            child: Container(
              //margin: good_results? const EdgeInsets.fromLTRB(24, 0, 23, 7) : const EdgeInsets.fromLTRB(24, 17, 23, 7),
              height: 44,
              decoration: BoxDecoration(
                  color: Color(0xff695CD4),
                  //border: Border.all(color: const Color(0xffE0E0E0),),
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
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BloodPressureDetails()));
            },
          ),

        ],
      ),
    );
  }

  Future<Map?> get_info(String date) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final email = user!.email;
      late Map? b;
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .collection('Vitals')
          .doc(date)
          .get();
      b = snapshot.data();
      return b;
    } catch(e){
      print(e);
    }
  }
}