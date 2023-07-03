import 'package:aster_hf/controllers/home_screen_controller.dart';
import 'package:aster_hf/controllers/user_data_controller.dart';
import 'package:aster_hf/screens/first_screen.dart';
import 'package:aster_hf/widgets/home_screen/home_screen_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/button.dart';
import '../widgets/home_screen/medicine_widget.dart';
import 'package:aster_hf/widgets/home_screen/emergency_contacts_lists.dart';
import 'form_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _selectedIndex = 0;
  // final String _username = 'Raghav';
  List<List<Medicine>> morningReminder = List.generate(3, (index) => []);
  List<List<Medicine>> afternoonReminder = List.generate(3, (index) => []);
  List<List<Medicine>> eveningReminder = List.generate(3, (index) => []);
  List<DateTime> medTime = [
    DateFormat.jm().parse('12:00 PM'),
    DateFormat.jm().parse('6:00 PM')
  ];
  List<DateTime> morningTime = [
    DateFormat.jm().parse('9:00 AM'),
    DateFormat.jm().parse('10:00 AM')
  ];
  List<DateTime> afternoonTime = [
    DateFormat.jm().parse('2:00 PM'),
    DateFormat.jm().parse('3:00 PM')
  ];
  List<DateTime> eveningTime = [
    DateFormat.jm().parse('8:00 PM'),
    DateFormat.jm().parse('9:00 PM')
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/home/img.png',
                  width: screenWidth,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('👋 Hello!',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                              FutureBuilder(
                                future: getName(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    );
                                  } else {
                                    return const Text(
                                      "User",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: IconButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                    builder: (context) => FirstScreen()), (Route route) => false);
                              },
                              color: Colors.white,
                              icon: const Icon(Icons.logout,
                                  size: 30),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: screenWidth / 1.5,
                              height: 48,
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  hintText: 'Search doctors, labs...',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.search),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('assets/home/tune_icon.png'),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FutureBuilder(
                        // future: UserDataController.getProgress(),
                        future: getPercentage(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DailyLogWidget(
                                percentComplete:
                                int.parse(snapshot.data.toString()));
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      )

                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    "Today's activity",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.tune,
                      size: 20,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 160,
                width: double.infinity,
                child: FutureBuilder(
                    future: HomeScreenController.getUserData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const SizedBox(height: 135);
                      }
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      List <Widget> toShow = vitalWidgets(snapshot,context);
                      if(toShow.isEmpty){
                        return const Center(
                          child: Text("No updates for today !",
                            style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            ),),
                        );
                      }
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: toShow,
                      );
                    }
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    "Medicine Reminders",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const formScreen()));
                    },
                    child: const Text(
                      "Quick Add",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 110.0),
                  child: Image.asset(
                    'assets/home/img_1.png',
                    width: screenWidth,
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection('Reminder')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      morningReminder = List.generate(3, (index) => []);
                      afternoonReminder = List.generate(3, (index) => []);
                      eveningReminder = List.generate(3, (index) => []);
                      int currReminder, currReminderTime;
                      List<List<List<Medicine>>> reminder = [
                        morningReminder,
                        afternoonReminder,
                        eveningReminder
                      ];
                      if (!snapshot.hasData) {
                        return const SizedBox(
                          height: 0,
                        );
                      }
                      for (var ind = 0;
                      ind < snapshot.data!.docs.length;
                      ind++) {
                        Map<String, dynamic> data = snapshot.data!.docs[ind]
                            .data() as Map<String, dynamic>;
                        Medicine currMed = Medicine(
                            medicineName: data['medicineName'],
                            quantity: data['amount']);
                        DateTime currTime =
                        DateFormat.jm().parse(data['timeReminder']);
                        DateTime addedTime =
                        (data['currentTime'] as Timestamp).toDate();
                       // List<String> howLong = data['howLong'].split(' ');
                        /*if (howLong[1] == 'Days') {
                          if (DateTime.now().isAfter(addedTime
                              .add(Duration(days: int.parse(howLong[0]))))) {
                            continue;
                          }
                        } else {
                          if (DateTime.now().isAfter(addedTime.add(Duration(
                              days: (int.parse(howLong[0]) /
                                  int.parse(data['repeat']))
                                  .ceil())))) {
                            continue;
                          }
                        }*/

                        if (currTime.isBefore(medTime[0])) {
                          currReminder = 0;
                        } else if (currTime.isBefore(medTime[1])) {
                          currReminder = 1;
                        } else {
                          currReminder = 2;
                        }

                        if (data['foodAndPills'] == "Before Meal") {
                          currReminderTime = 0;
                        } else if (data['foodAndPills'] == "During Meal") {
                          currReminderTime = 1;
                        } else {
                          currReminderTime = 2;
                        }

                        reminder[currReminder][currReminderTime].add(currMed);
                      }
                      return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: 215,
                          width: double.infinity,
                          child: ListView(
                            //itemExtent: snapshot.data!.docs.length.toDouble(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              MedicineWidget(
                                // isWidgetActive: true,
                                  timeForMedicineIntake: "Morning",
                                  beforeMeal: morningReminder[0],
                                  duringMeal: morningReminder[1],
                                  afterMeal: morningReminder[2]),
                              MedicineWidget(
                                // isWidgetActive: false,
                                  timeForMedicineIntake: "Afternoon",
                                  beforeMeal: afternoonReminder[0],
                                  duringMeal: afternoonReminder[1],
                                  afterMeal: afternoonReminder[2]),
                              MedicineWidget(
                                // isWidgetActive: false,
                                  timeForMedicineIntake: "Night",
                                  beforeMeal: eveningReminder[0],
                                  duringMeal: eveningReminder[1],
                                  afterMeal: eveningReminder[2]),
                            ],
                          ));
                    }),
                Positioned.fill(
                  top: 230,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Text(
                          'Call for an\nEmergency',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: GestureDetector(
                            child: Button(
                              text: 'Call Now',
                              width: screenWidth * 0.36,
                              fontsize: 16,
                              fontweight: FontWeight.w600,
                              height: 48,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 204,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            23, 0, 41, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            SizedBox(
                                              height: 180,
                                              child: ListView.builder(
                                                  itemCount:
                                                  emergencyContacts.length.compareTo(0),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    return Container(
                                                        color: const Color(
                                                            0xFFFFFFFF),
                                                        height: 60,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Image.asset(
                                                              emergencyContacts[
                                                              index]
                                                                  .contactName ==
                                                                  "Emergency Ambulance"
                                                                  ? 'assets/images/ambulance_logo.png'
                                                                  : 'assets/images/doctor_logo.png',
                                                              height: 25,
                                                              width: 25,
                                                            ),
                                                            const SizedBox(
                                                              width: 27,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                    emergencyContacts[index]
                                                                        .contactName,
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF695CD4),
                                                                        fontSize:
                                                                        14,
                                                                        fontWeight:
                                                                        FontWeight.w600)),
                                                                Text(
                                                                    emergencyContacts[index]
                                                                        .contactSpeciality,
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF000000),
                                                                        fontSize:
                                                                        12,
                                                                        fontWeight:
                                                                        FontWeight.w400)),
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child:
                                                              Image.asset(
                                                                'assets/images/call_logo.png',
                                                                height: 20,
                                                                width: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ));
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/home/img_2.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                        )
                      ],
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

  Future<String?> getName() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    Map? a = snapshot.data();
    return a?['name'];
  }


  Future<int?> getPercentage() async {
    int percent = 0;
    DateTime today = DateTime.now();
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('Vitals')
        .doc(today.toIso8601String().substring(0, 10))
        .get();
    if(snapshot.exists) {
      Map? a = snapshot.data();
      if (a!['blood_oxygen']!=null){
        percent += 20;
      }
      if (a['body_weight']!=null){
        percent += 20;
      }
      if (a['glucose_level']!=null){
        percent += 20;
      }
      if (a['heart_rate']!=null){
        percent += 20;
      }
      if (a['blood_pressure']['Sys']!=null){
        percent += 20;
      }
    }
    return percent;
  }
}
