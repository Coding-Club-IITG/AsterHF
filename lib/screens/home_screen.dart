import 'package:aster_hf/widgets/home_screen/home_screen_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/button.dart';
import '../widgets/home_screen/medicine_widget.dart';
import 'package:aster_hf/widgets/home_screen/emergency_contacts_lists.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _selectedIndex = 0;
  String? _username = 'Raghav';
  CollectionReference firebaseUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.email) as CollectionReference<Object?>;
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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F6),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
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
                                  Text(
                                    _username!,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: IconButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  icon: const Icon(
                                      Icons.notifications_none_rounded,
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
                                child: Container(
                                  width: screenWidth / 1.5,
                                  height: 48,
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
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
                                    child: Image.asset(
                                        'assets/home/tune_icon.png'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FutureBuilder<Object>(
                              future: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc("s.r.ghosarwadkar@gmail.com")
                                  .collection("Vitals")
                                  .doc('23-12-2022')
                                  .get(),
                              builder: (context, AsyncSnapshot snapshot) {
                                int countOfVitals = 0;
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.data!
                                    .data()!
                                    .containsKey('blood_oxygen')) {
                                  countOfVitals++;
                                }
                                if (snapshot.data!
                                    .data()!
                                    .containsKey('body_weight')) {
                                  countOfVitals++;
                                }
                                if (snapshot.data!
                                    .data()!
                                    .containsKey('blood_pressure')) {
                                  countOfVitals++;
                                }
                                if (snapshot.data!
                                    .data()!
                                    .containsKey('glucose_level')) {
                                  countOfVitals++;
                                }
                                if (snapshot.data!
                                    .data()!
                                    .containsKey('heart_rate')) {
                                  countOfVitals++;
                                }
                                return DailyLogWidget(
                                    percentComplete:
                                        ((countOfVitals / 5) * 100).toInt(),
                                    completeDailyLog: () {});
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "Today's activity",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .doc("s.r.ghosarwadkar@gmail.com")
                          .collection("Vitals")
                          .doc('23-12-2022')
                          .get(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        List<Widget> toShow = [];
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.data!
                            .data()!
                            .containsKey('blood_oxygen')) {
                          toShow.add(Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 145,
                            height: 135,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ActivityWidget(
                                vitalType: 5,
                                parameterValue:
                                    snapshot.data['blood_oxygen'].toString(),
                                isProgress: true),
                          ));
                        }
                        if (snapshot.data!.data()!.containsKey('body_weight')) {
                          toShow.add(Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 145,
                            height: 135,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ActivityWidget(
                                vitalType: 2,
                                parameterValue:
                                    snapshot.data['body_weight'].toString(),
                                isProgress: true),
                          ));
                        }
                        if (snapshot.data!
                            .data()!
                            .containsKey('blood_pressure')) {
                          toShow.add(Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 145,
                            height: 135,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ActivityWidget(
                                vitalType: 1,
                                parameterValue:
                                    "${snapshot.data['blood_oxygen']['Sys']}/${snapshot.data['blood_oxygen']['Dia']}",
                                isProgress: true),
                          ));
                        }
                        if (snapshot.data!
                            .data()!
                            .containsKey('glucose_level')) {
                          toShow.add(Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 145,
                            height: 135,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ActivityWidget(
                                vitalType: 3,
                                parameterValue:
                                    "${snapshot.data['glucose_level']}",
                                isProgress: true),
                          ));
                        }
                        if (snapshot.data!.data()!.containsKey('heart_rate')) {
                          toShow.add(Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 145,
                            height: 135,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ActivityWidget(
                                vitalType: 4,
                                parameterValue:
                                    "${snapshot.data['heart_rate']}",
                                isProgress: true),
                          ));
                        }
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: toShow,
                        );
                      })),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children:[
                    const Text(
                      "Medicine Reminders",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
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
                          .doc(firebaseUser.id)
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
                        List<List<DateTime>> reminderTime = [
                          morningTime,
                          afternoonTime,
                          eveningTime
                        ];
                        if (!snapshot.hasData) {
                          return const SizedBox(
                            height: 0,
                          );
                        }
                        for (var ind = 0;
                            ind < snapshot.data!.docs.length;
                            ind++) {
                          Map<String, dynamic> data =
                              snapshot.data!.docs[ind].data() as Map<String, dynamic>;
                          Medicine currMed = Medicine(
                              medicineName: data['medicineName'],
                              quantity: data['amount']);
                          DateTime currTime =
                              DateFormat.jm().parse(data['timeReminder']);
                          if (currTime.isBefore(medTime[0])) {
                            currReminder = 0;
                          } else if (currTime.isBefore(medTime[1])) {
                            currReminder = 1;
                          } else {
                            currReminder = 2;
                          }

                          if (currTime
                              .isBefore(reminderTime[currReminder][0])) {
                            currReminderTime = 0;
                          } else if (currTime
                              .isBefore(reminderTime[currReminder][1])) {
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
                                    backgroundColor: Color(0xFFFFFFFF),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 204,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              23, 0, 41, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 20),
                                              SizedBox(
                                                height: 180,
                                                child: ListView.builder(
                                                    itemCount: emergencyContacts
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Container(
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                          height: 48,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                emergencyContacts[index]
                                                                            .contactName ==
                                                                        "Ambulance"
                                                                    ? 'assets/images/ambulance_logo.png'
                                                                    : 'assets/images/doctor_logo.png',
                                                                height: 20,
                                                                width: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 27,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      emergencyContacts[index]
                                                                          .contactName,
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF695CD4),
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                  Text(
                                                                      emergencyContacts[index]
                                                                          .contactSpeciality,
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xFF000000),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w400)),
                                                                ],
                                                              ),
                                                              Spacer(),
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
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: const Color(0xFFFDFDFD),
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_rounded),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.apartment_rounded),
      //       label: 'Med Card',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.group_outlined),
      //       label: 'Community',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline_rounded),
      //       label: 'Profile',
      //     )
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Theme.of(context).primaryColor,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
