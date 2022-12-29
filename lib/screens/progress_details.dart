import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chart_widget.dart';
import 'category_sheet.dart';
import 'export_bottomsheet.dart';

class ProgressDetails extends StatefulWidget {
  final int index;

  const ProgressDetails({required this.index, Key? key}) : super(key: key);
  static const routename = '/progress_details';

  @override
  State<ProgressDetails> createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  final vital = [
    "blood_pressure",
    "body_weight",
    "glucose_level",
    "heart_rate",
    "blood_oxygen"
  ];
  final vitals = [
    "Blood Pressure",
    "Body Weight",
    "Glucose Level",
    "Heart Rate",
    "Blood Oxygen"
  ];
  final vitalscap = [
    "BLOOD PRESSURE",
    "BODY WEIGHT",
    "GLUCOSE LEVEL",
    "HEART RATE",
    "BLOOD OXYGEN"
  ];
  final healthy = ["80/120-90/140", "50-80", "90-120", "70-90", "95-100"];
  final units = ["mg/dl", "kg", "mg/dl", "bpm", "%"];
  final week = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"];
  int choice = 0;
  bool goodresults = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f4f6),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context, builder: (context) => const newExport(),
                  //backgroundColor: Colors.grey[500],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20 ),
                      )
                  ),
                  isScrollControlled: true,
                );
              },
              icon: Image.asset('assets/images/extract.png'),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            showModalBottomSheet(
                context: context, builder: (context) => const CategoryBottomSheet(),
                //backgroundColor: Colors.grey[500],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20 ),
                    )
                )
            );
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 340,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Current ${vitals[widget.index]}',
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    FutureBuilder<String?>(
                        future: getCurrent(),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData){
                            return const CircularProgressIndicator();
                          }
                          if(snapshot.hasError){
                            return const Text('Error');
                          }
                          return RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: snapshot.data,
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: ' ${units[widget.index]}',
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                choice = 0;
                              });
                            },
                            child: Text(
                              'Day',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: choice == 0
                                      ? FontWeight.w600
                                      : FontWeight.w400),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                choice = 1;
                              });
                            },
                            child: Text(
                              'Week',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: choice == 1
                                      ? FontWeight.w600
                                      : FontWeight.w400),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                choice = 2;
                              });
                            },
                            child: Text(
                              'Month',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: choice == 2
                                      ? FontWeight.w600
                                      : FontWeight.w400),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                choice = 3;
                              });
                            },
                            child: Text(
                              'Year',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: choice == 3
                                      ? FontWeight.w600
                                      : FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List>(
                      future: produceData(widget.index),
                      builder: (context, snapshot){
                        if(!snapshot.hasData){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if(snapshot.hasError){
                          return const Center(
                            child: Text('Error loading data'),
                          );
                        }
                        if(widget.index==0){
                          return BPChart(chartData: snapshot.data![choice],);
                        }
                        else if(widget.index == 1){
                          return BWChart(chartData: snapshot.data![choice],);
                        }
                        else{
                          return OtherChart(chartData: snapshot.data![choice],);
                        }
                      },
                    ),
                  ],
                ),
              ),
              goodresults
                  ? Stack(children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 16, 23, 7),
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffCECECE),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: const ListTile(
                    isThreeLine: true,
                    title: Text(
                      '💫 Good Results',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          color: Color(0xff191D30),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal),
                    ),
                    subtitle: Text(
                      'You are doing great today, a step closer to being more healthy. Lets keep this going',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        color: Color(0xff868686),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 18.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          goodresults = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xffE0E0E0),
                      ),
                    ),
                  ),
                ),
              ])
                  : const SizedBox(
                height: 0,
                width: 0,
              ),
              GestureDetector(
                child: Container(
                  margin: goodresults
                      ? const EdgeInsets.fromLTRB(24, 0, 23, 7)
                      : const EdgeInsets.fromLTRB(24, 17, 23, 7),
                  height: 44,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffE0E0E0),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'UPDATE ${vitalscap[widget.index]}',
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        color: Color(0xff695CD4),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 9),
                child: Text(
                  'Today\'s Progress',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Color(0xff191D30),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(24, 0, 7, 8),
                      height: 60,
                      // width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffCECECE),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Current',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Color(0xff191D30),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              FutureBuilder<String?>(
                                  future: getCurrent(),
                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData){
                                      return const Expanded(child: CircularProgressIndicator());
                                    }
                                    if(snapshot.hasError){
                                      return const Text('Error');
                                    }
                                    return RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: snapshot.data,
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                color: Color(0xff695CD4),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: ' ${units[widget.index]}',
                                            style: const TextStyle(
                                                fontFamily: 'poppins',
                                                color: Color(0xff695CD4),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(7, 0, 24, 8),
                      height: 60,
                      // width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffCECECE),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Healthy Range',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    color: Color(0xff191D30),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: healthy[widget.index],
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: const Color(0xff39CA76),
                                          fontSize: widget.index == 0 ? 12 : 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: ' ${units[widget.index]}',
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          color: Color(0xff39CA76),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Future<List> produceData(int index) async {
    var data = [];
    if (index == 0) {
      final dayData = <ChartBPData>[];
      for (var i = 6; i >= 0; i--) {
        DateTime today = DateTime.now();
        DateTime req = today.subtract(Duration(days: i));
        print(req.toIso8601String().substring(0, 10));
        Map? a = await getInfo(req.toIso8601String().substring(0, 10));
        if (a!['blood_pressure']['Sys'] != null) {
          dayData.add(ChartBPData(week[req.weekday - 1],
              a['blood_pressure']['Dia'], a['blood_pressure']['Sys']));
        }
      }
      data.add(dayData);
      final weekData = <ChartBPData>[];
      for (var i = 4; i >= 0; i--) {
        int sysSum = 0, diaSum = 0, c = 0;
        String x = "";
        for (var j = 6; j >= 0; j--) {
          DateTime today = DateTime.now();
          DateTime req = today.subtract(Duration(days: 7 * i + j));
          print(req.toIso8601String().substring(0, 10));
          if (j == 0 || j == 6) {
            x += req.day.toString();
            if (j == 6) {
              x += "-";
            }
          }
          Map? a = await getInfo(req.toIso8601String().substring(0, 10));
          if (a?['blood_pressure']['Sys'] != null &&
              a?['blood_pressure']['Dia'] != null) {
            sysSum += a?['blood_pressure']['Sys'] as int;
            diaSum += a?['blood_pressure']['Dia'] as int;
            c++;
          }
        }
        c != 0
            ? weekData.add(ChartBPData(x, diaSum ~/ c, sysSum ~/ c))
            : weekData.add(ChartBPData(x, 0, 0));
      }
      data.add(weekData);
    } else if (index != 1) {
      final dayData = <ChartData>[];
      for (var i = 6; i >= 0; i--) {
        DateTime today = DateTime.now();
        DateTime req = today.subtract(Duration(days: i));
        print(req.toIso8601String().substring(0, 10));
        Map? a = await getInfo(req.toIso8601String().substring(0, 10));
        dayData.add(ChartData(week[req.weekday - 1], a![vital[index]]));
      }
      data.add(dayData);
      final weekData = <ChartData>[];
      for (var i = 4; i >= 0; i--) {
        int sum = 0, c = 0;
        String x = "";
        for (var j = 6; j >= 0; j--) {
          DateTime today = DateTime.now();
          DateTime req = today.subtract(Duration(days: 7 * i + j));
          print(req.toIso8601String().substring(0, 10));
          if (j == 0 || j == 6) {
            x += req.day.toString();
            if (j == 6) {
              x += "-";
            }
          }
          Map? a = await getInfo(req.toIso8601String().substring(0, 10));
          if (a?[vital[index]] != null) {
            sum += a?[vital[index]] as int;
            c++;
          }
        }
        c != 0
            ? weekData.add(ChartData(x, sum ~/ c))
            : weekData.add(ChartData(x, 0));
      }
      data.add(weekData);
    } else {
      final dayData = <ChartBWData>[];
      for (var i = 6; i >= 0; i--) {
        DateTime today = DateTime.now();
        DateTime req = today.subtract(Duration(days: i));
        print(req.toIso8601String().substring(0, 10));
        Map? a = await getInfo(req.toIso8601String().substring(0, 10));
        double data = a!['body_weight'].toDouble();
        dayData.add(ChartBWData(week[req.weekday - 1], data));
      }
      data.add(dayData);
      final weekData = <ChartBWData>[];
      for (var i = 4; i >= 0; i--) {
        double sum = 0, c = 0;
        String x = "";
        for (var j = 6; j >= 0; j--) {
          DateTime today = DateTime.now();
          DateTime req = today.subtract(Duration(days: 7 * i + j));
          print(req.toIso8601String().substring(0, 10));
          if (j == 0 || j == 6) {
            x += req.day.toString();
            if (j == 6) {
              x += "-";
            }
          }
          Map? a = await getInfo(req.toIso8601String().substring(0, 10));
          if (a?['body_weight'] != null) {
            sum += a?['body_weight'] as double;
            c++;
          }
        }
        c != 0
            ? weekData.add(ChartBWData(x, sum / c))
            : weekData.add(ChartBWData(x, 0));
      }
      data.add(weekData);
    }
    return data;
  }

  Future<Map?> getInfo(String date) async {
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
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> getCurrent() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Vitals')
        .doc(DateTime.now().toIso8601String().substring(0, 10))
        .get();
    Map? a = snapshot.data();
    String? k = "";
    if (widget.index == 0) {
      k = "${a?['blood_pressure']['Dia']}/${a?['blood_pressure']['Sys']}";
    } else {
      k = a?[vital[widget.index]].toString();
    }
    return k;
  }
}