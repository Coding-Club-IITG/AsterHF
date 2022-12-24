import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressDetails extends StatefulWidget {
  final int index;

  const ProgressDetails({
    required this.index,
    Key? key}) : super(key: key);
  static const routename = '/progress_details';

  @override
  State<ProgressDetails> createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  final vital = ["blood_pressure", "body_weight", "glucose_level", "heart_rate", "blood_oxygen"];
  final vitals = ["Blood Pressure", "Body Weight", "Glucose Level", "Heart Rate", "Blood Oxygen"];
  final vitalscap = ["BLOOD PRESSURE", "BODY WEIGHT", "GLUCOSE LEVEL", "HEART RATE", "BLOOD OXYGEN"];
  final healthy = ["80/120-90/140", "50-80", "90-120", "70-90", "95-100"];
  final units = ["mg/dl", "kg", "mg/dl", "bpm", "%"];
  int choice = 0;
  bool goodresults = true;
  final bpChartData = <List<ChartBPData>>[];
  final chartData = [];
  final bwChartData = [];
  String? s = "";
  @override
  void initState(){
    super.initState();
    produce_data(widget.index);
    get_current(DateTime.now().toIso8601String().substring(0, 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/extract.png'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: s,
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
                  ),
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
                  widget.index==0
                      ? BPChart(chartData: bpChartData[choice],)
                      : widget.index==1
                        ? BWChart(chartData: bwChartData[choice],)
                        : OtherChart(chartData: chartData[choice],)
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
                      padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: s,
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
                            ),
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
                      padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
                                        color: Color(0xff39CA76),
                                        fontSize: widget.index == 0
                                          ? 12
                                          : 14,
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
      ),
    );
  }

  final week = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"];
  Future<void> produce_data(int index) async {
    if(index == 0){
      final dayData = <ChartBPData>[];
      for(var i = 6; i>=0; i--){
        DateTime today = DateTime.now();
        DateTime req = today.subtract(Duration(days: i));
        print(req.toIso8601String().substring(0, 10));
        Map? a = await get_info(req.toIso8601String().substring(0, 10));
        if(a!['blood_pressure']['Sys'] != null) {
          dayData.add(ChartBPData(
              week[req.weekday - 1], a['blood_pressure']['Dia'], a['blood_pressure']['Sys']));
        }
      }
      bpChartData.add(dayData);
      final weekData = <ChartBPData>[];
      for(var i = 4; i>=0; i--){
        int sysSum = 0, diaSum = 0, c = 0;
        String x = "";
        for(var j = 6; j>=0; j--){
          DateTime today = DateTime.now();
          DateTime req = today.subtract(Duration(days: 7*i + j));
          print(req.toIso8601String().substring(0, 10));
          if(j==0 || j==6){
            x+=req.day.toString();
            if(j==6){
              x+="-";
            }
          }
          Map? a = await get_info(req.toIso8601String().substring(0, 10));
          if(a?['blood_pressure']['Sys'] != null && a?['blood_pressure']['Dia'] != null){
            sysSum += a?['blood_pressure']['Sys'] as int;
            diaSum += a?['blood_pressure']['Dia'] as int;
            c++;
          }
        }
        c != 0 ? weekData.add(ChartBPData(x, diaSum~/c, sysSum~/c)) : weekData.add(ChartBPData(x, 0, 0));
      }
      bpChartData.add(weekData);
    }
    else if(index != 1){
      final dayData = <ChartData>[];
      for(var i = 6; i>=0; i--){
        DateTime today = DateTime.now();
        DateTime req = today.subtract(Duration(days: i));
        print(req.toIso8601String().substring(0, 10));
        Map? a = await get_info(req.toIso8601String().substring(0, 10));
        dayData.add(ChartData(week[req.weekday-1], a![vital[index]]));
      }
      chartData.add(dayData);
      final weekData = <ChartData>[];
      for(var i = 4; i>=0; i--){
        int sum = 0, c = 0;
        String x = "";
        for(var j = 6; j>=0; j--){
          DateTime today = DateTime.now();
          DateTime req = today.subtract(Duration(days: 7*i + j));
          print(req.toIso8601String().substring(0, 10));
          if(j==0 || j==6){
            x+=req.day.toString();
            if(j==6){
              x+="-";
            }
          }
          Map? a = await get_info(req.toIso8601String().substring(0, 10));
          if(a?[vital[index]] != null){
            sum += a?[vital[index]] as int;
            c++;
          }
        }
        c != 0 ? weekData.add(ChartData(x, sum~/c)) : weekData.add(ChartData(x, 0));
      }
      chartData.add(weekData);
    }
    else{
      final dayData = <ChartBWData>[];
      for(var i = 6; i>=0; i--){
        DateTime today = DateTime.now();
        DateTime req = today.subtract(Duration(days: i));
        print(req.toIso8601String().substring(0, 10));
        Map? a = await get_info(req.toIso8601String().substring(0, 10));
        double data = a!['body_weight'].toDouble();
        dayData.add(ChartBWData(week[req.weekday-1], data));
      }
      bwChartData.add(dayData);
      final weekData = <ChartBWData>[];
      for(var i = 4; i>=0; i--){
        double sum = 0, c = 0;
        String x = "";
        for(var j = 6; j>=0; j--){
          DateTime today = DateTime.now();
          DateTime req = today.subtract(Duration(days: 7*i + j));
          print(req.toIso8601String().substring(0, 10));
          if(j==0 || j==6){
            x+=req.day.toString();
            if(j==6){
              x+="-";
            }
          }
          Map? a = await get_info(req.toIso8601String().substring(0, 10));
          if(a?['body_weight'] != null){
            sum += a?['body_weight'] as double;
            c++;
          }
        }
        c != 0 ? weekData.add(ChartBWData(x, sum/c)) : weekData.add(ChartBWData(x, 0));
      }
      bwChartData.add(weekData);
    }
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

  Future<void> get_current(String data) async {
    Map? a = await get_info(data);
    if(widget.index==0){
      s = "${a?['blood_pressure']['Dia']}/${a?['blood_pressure']['Sys']}";
    }
    else{
      s = a?[vital[widget.index]].toString();
    }
  }
}

class ChartBPData {
  ChartBPData(this.x, this.high, this.low);
  final String x;
  final int high;
  final int low;
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}

class ChartBWData {
  ChartBWData(this.x, this.y);
  final String x;
  final double y;
}

class BPChart extends StatelessWidget {
  final chartData;
  BPChart({super.key, this.chartData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfCartesianChart(
          palette: const [
            Colors.white,
          ],
          primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(width: 0)),
          primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
              axisLine: const AxisLine(width: 0),
              minimum: 50,
              interval: 10,
              maximumLabels: 5),
          plotAreaBorderWidth: 0,
          series: <ChartSeries>[
            RangeColumnSeries<ChartBPData, String>(
                dataSource: chartData,
                xValueMapper: (ChartBPData data, _) => data.x,
                lowValueMapper: (ChartBPData data, _) => data.low,
                highValueMapper: (ChartBPData data, _) => data.high,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                width: 0.3,
                emptyPointSettings:
                EmptyPointSettings(mode: EmptyPointMode.average))
          ],
        ),
      ),
    );
  }
}

class BWChart extends StatelessWidget {
  final chartData;
  BWChart({super.key, this.chartData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfCartesianChart(
          palette: const [
            Colors.white,
          ],
          primaryXAxis:
          CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(width: 0)
          ),
          primaryYAxis:
          NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
              axisLine: const AxisLine(width: 0),
              interval: 10,
              maximumLabels: 5
          ),
          plotAreaBorderWidth: 0,
          series: <ChartSeries>[
            LineSeries<ChartBWData, String>(
                dataSource: chartData,
                xValueMapper: (ChartBWData data, _) => data.x,
                yValueMapper: (ChartBWData data, _) => data.y,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                ),
                emptyPointSettings:
                EmptyPointSettings(mode: EmptyPointMode.average))
          ],
        ),
      ),
    );
  }
}

class OtherChart extends StatelessWidget {
  final chartData;
  OtherChart({super.key, this.chartData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfCartesianChart(
          palette: const [
            Colors.white,
          ],
          primaryXAxis:
          CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(width: 0)
          ),
          primaryYAxis:
          NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
              axisLine: const AxisLine(width: 0),
              minimum: 50,
              interval: 10,
              maximumLabels: 5
          ),
          plotAreaBorderWidth: 0,
          series: <ChartSeries>[
            LineSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                ),
                emptyPointSettings:
                EmptyPointSettings(mode: EmptyPointMode.average))
          ],
        ),
      ),
    );
  }
}
