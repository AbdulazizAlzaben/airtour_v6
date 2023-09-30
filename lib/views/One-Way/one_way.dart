import 'package:AirTours/views/One-Way/show_city_name_search.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:AirTours/views/Global/global_var.dart';

import 'available_flights_screen.dart';
import 'fligh_class_for_search.dart';

//azizxx
class OneWay extends StatefulWidget {
  const OneWay({super.key});

  @override
  State<OneWay> createState() => _OneWayState();
}

class _OneWayState extends State<OneWay> {
  String? selectedCity1;
  String? selectedCity2;

  // static List<flightInformation> _flightNameTest = [
  //   flightInformation("Riyadh", "RHD"),
  //   flightInformation("Jeddah", "JEH")
  // ];

  // List<flightInformation> _filter = [];
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _filter = _flightNameTest;
  //   });
  // }

  // // updateList(String value) {
  // //   setState(() {
  // //     _filter = _flightNameTest
  // //         .where((element) =>
  // //             element.cityName!.toLowerCase().contains(value.toLowerCase()))
  // //         .toList();
  // //   });
  // // }

  // updateList(String value) {
  //   setState(() {
  //     _filter = _flightNameTest
  //         .where((element) => element.cityName.toLowerCase().contains(value))
  //         .toList();
  //   });
  // }

  final _formKey = GlobalKey<FormState>();

  void toNext() {
    DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
    print(dateOnly);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OneWaySearch(
            numOfPas: count,
            date: dateOnly,
            flightClass: currentPassenger,
            from: selectedCity1!,
            to: selectedCity2!,
          ),
        ));
  }

  void icreaseCount() {
    setState(() {
      if (count == 6) return;
      count++;
    });
  }

  void decreaseCount() {
    setState(() {
      if (count == 1) return;
      count--;
    });
  }

  void _navigateToCitySelectionPage(BuildContext context, int num) async {
    final city = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FromSearch(fromOrTo: 1)),
    );

    if (city != null) {
      setState(() {
        if (num == 1) {
          selectedCity1 = city;
        }
        if (num == 2) {
          selectedCity2 = city;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        _navigateToCitySelectionPage(context, 1);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.flight_takeoff),
                            SizedBox(width: 8.0),
                            Text(
                              selectedCity1 != null
                                  ? '${selectedCity1}'
                                  : 'Select from',
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _navigateToCitySelectionPage(context, 2);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.flight_land),
                            SizedBox(width: 8.0),
                            Text(
                              selectedCity2 != null
                                  ? '${selectedCity2}'
                                  : 'Select to',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 2,
                              ),
                              const Text("   Departure date"),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 200,
                                            top: 8,
                                            bottom: 8),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        elevation: 0,
                                        backgroundColor: Colors.white),
                                    child: Text(
                                      "${dateTime.day} ${monthNames[dateTime.month - 1]}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                    onPressed: () async {
                                      DateTime? newDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2024));
                                      if (newDate == null) return;
                                      //print(start);
                                      //print("-----------");
                                      setState(() {
                                        dateTime = newDate;
                                        // print(start);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                const Expanded(
                                    flex: 1, child: Text("Passenger: ")),
                                Expanded(
                                    flex: 2,
                                    child: Row(children: [
                                      TextButton(
                                          onPressed: decreaseCount,
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                            size: 15,
                                          )),
                                      Text("$count"),
                                      TextButton(
                                          onPressed: icreaseCount,
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                            size: 15,
                                          )),
                                      const SizedBox(
                                        height: 70,
                                      )
                                    ])),
                              ],
                            ),
                          ),
                          //before children if we want it to be at the end of the container mainAxisAlignment: MainAxisAlignment.end,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                                ],
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    title: const Text("Guest"),
                                    value: passengerType[0],
                                    groupValue: currentPassenger,
                                    onChanged: (value) {
                                      setState(() {
                                        currentPassenger = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    title: const Text("Business"),
                                    value: passengerType[1],
                                    groupValue: currentPassenger,
                                    onChanged: (value) {
                                      setState(() {
                                        currentPassenger = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 70,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          toNext();
                        }
                      },
                      child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(blurRadius: 2, offset: Offset(0, 0))
                              ],
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: const Center(
                              child: Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ))),
                    ),
                  ],
                ),
              ),
            )));
  }
}
