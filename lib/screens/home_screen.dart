import 'package:aster_hf/widgets/home_screen/home_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                                children: const [
                                  Text('👋 Hello!',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                  Text(
                                    'Raghav',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              const Spacer(),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(
                                  Icons.notifications_none_rounded,
                                  size: 30,
                                  color: Colors.white,
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
                              Padding(
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
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            height: 128,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )
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
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 145,
                          height: 135,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ActivityWidget(
                              parameterWord1: 'Blood',
                              parameterWord2: 'Pressure',
                              units: 'bpm',
                              parameterValue: '141/90',
                              isProgress: true,
                              lastUpdateTime: 4,
                              lastUpdateTimeUnit: 'hrs'),
                        );
                      })),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFDFDFD),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment_rounded),
            label: 'Med Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
