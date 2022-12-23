import 'package:flutter/material.dart';

class Medicine {
  final String medicineName;
  final String
  quantity; // in ml if isTablet is false. if isTablet is true, quantity will be just a number

  Medicine({required this.medicineName, required this.quantity});
}

class MedicineWidget extends StatefulWidget {
  bool isWidgetActive =
  true; // true if the medicine is activitely pending and to be taken right next
  final String timeForMedicineIntake;
  List<Medicine> beforeMeal;
  List<Medicine> duringMeal;
  List<Medicine> afterMeal;
  IconData? icon;

  MedicineWidget(
      {super.key,
        required this.timeForMedicineIntake,
        required this.beforeMeal,
        required this.afterMeal,
        required this.duringMeal}) {
    if (timeForMedicineIntake == "Morning") {
      icon = Icons.local_cafe;
    } else if (timeForMedicineIntake == "Afternoon") {
      icon = Icons.light_mode_outlined;
    } else {
      icon = Icons.dark_mode_outlined;
    }
  }

  @override
  State<MedicineWidget> createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 195,
      width: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Row(
                children: [
                  const SizedBox(width: 5.0),
                  Icon(
                    widget.icon,
                    size: 20,
                    color: widget.isWidgetActive
                        ? const Color(0xFF695CD4)
                        : const Color(0xFFC5C4C8),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    widget.timeForMedicineIntake,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.isWidgetActive
                          ? const Color(0xFF695CD4)
                          : const Color(0xFFC5C4C8),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.beforeMeal.isNotEmpty
                          ? Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Before Food",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: Color(0xFFC5C4C8)),
                            ),
                            const SizedBox(height: 6),
                            Column(children: [
                              for (var index = 0;
                              index < widget.beforeMeal.length;
                              index++)
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.beforeMeal[index].medicineName,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.beforeMeal[index].quantity,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                )
                            ]),
                          ],
                        ),
                      )
                          : const SizedBox(height: 0),
                      widget.duringMeal.isNotEmpty
                          ? Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "During Food",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: Color(0xFFC5C4C8)),
                            ),
                            const SizedBox(height: 6),
                            Column(children: [
                              for (var index = 0;
                              index < widget.duringMeal.length;
                              index++)
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.duringMeal[index].medicineName,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.duringMeal[index].quantity,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                )
                            ]),
                          ],
                        ),
                      )
                          : const SizedBox(height: 0),
                      widget.afterMeal.isNotEmpty
                          ? Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "After Food",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: Color(0xFFC5C4C8)),
                            ),
                            const SizedBox(height: 6),
                            Column(children: [
                              for (var index = 0;
                              index < widget.afterMeal.length;
                              index++)
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.afterMeal[index].medicineName,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.afterMeal[index].quantity,
                                      style: TextStyle(
                                        color: widget.isWidgetActive
                                            ? const Color(0xFF3D3D3D)
                                            : const Color(0xFFC5C4C8),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                )
                            ]),
                          ],
                        ),
                      )
                          : const SizedBox(height: 0),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
