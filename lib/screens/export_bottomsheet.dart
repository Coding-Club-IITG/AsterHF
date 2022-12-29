import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class newExport extends StatefulWidget {
  const newExport({Key? key}) : super(key: key);

  @override
  State<newExport> createState() => _newExportState();
}

class _newExportState extends State<newExport> {
  var items=['PDF','CSV'];
  String exportFormat='PDF';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 250.h,
        padding: EdgeInsets.fromLTRB(24.w, 27.h, 23.w, 18.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          color: Color.fromARGB(1, 242, 244, 246),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Name of the File',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Format',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                    fontSize: 14,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter the name of the File',
                      hintStyle: TextStyle(
                        color: const Color.fromRGBO(140, 142, 151, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder:const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedBorder:const  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(224, 224, 224, 224),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45.h,
                  width: 10.w,
                ),
                SizedBox(
                  width: 100.w,
                  child: DropdownButtonFormField(
                    value: exportFormat,
                    items: items.map((String items){
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String ? newValue) {
                      setState(() {
                        exportFormat=newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter the name of the File',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(140, 142, 151, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(224, 224, 224, 224),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12,),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      //margin: good_results? const EdgeInsets.fromLTRB(24, 0, 23, 7) : const EdgeInsets.fromLTRB(24, 17, 23, 7),
                      height: 44,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey,),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(
                        child: Text(
                          'Share',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            color: Color(0xff695CD4),
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
                ),
                SizedBox(height: 44.h,width: 15.w,),
                Expanded(
                  child: GestureDetector(
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
                          'Export',
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
                ),

              ],
            )
          ],
        ),
      ),
    );;
  }
}
