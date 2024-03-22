import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/background.dart';
import 'package:flutter_application_1/shared/nav_bar.dart';

class GenerateReport extends StatefulWidget {
  const GenerateReport({super.key});

  @override
  State<GenerateReport> createState() => _GenerateReportState();
}

class _GenerateReportState extends State<GenerateReport> {
  String selectedProgram = 'Program 1';
  // bool isProgramSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF186257),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          const Background(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              color: const Color(0xFF186257),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.95,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'Generate a report',
                          style: TextStyle(
                            fontFamily: 'Merriweather',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Select a program to generate a report',
                              style: TextStyle(
                                fontFamily: 'Merriweather',
                                fontSize: 21.5,
                              ),
                            ),
                            const SizedBox(height: 20),

                            DropdownButton<String>(
                              value: selectedProgram,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedProgram = newValue!;
                                  // isProgramSelected =
                                  //     true; // Set to true when a program is selected
                                });
                              },
                              items: <String>[
                                'Program 1',
                                'Program 2',
                                'Program 3',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                );
                              }).toList(),
                              underline: Container(),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('ReportDetails'),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF186257),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                'Generate',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Merriweather',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
