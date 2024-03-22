import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/loadingpage.dart';
import 'package:flutter_application_1/services/firestore.dart';
import 'package:flutter_application_1/services/models.dart';
import 'package:flutter_application_1/shared/nav_bar.dart';
import 'package:intl/intl.dart';

class ProgramDetails extends StatefulWidget {
  final String pid;
  const ProgramDetails({super.key, required this.pid});

  @override
  State<ProgramDetails> createState() => _PrgramDetailsState();
}

class _PrgramDetailsState extends State<ProgramDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF186257),
      bottomNavigationBar: const NavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<Program>(
              stream: FirestoreService().streamProgram(widget.pid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                Program program = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Positioned(
                          top: 20,
                          left: 10,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: Color(0xFFFFFFFF),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
                      child: StreamBuilder<Patient>(
                          stream: FirestoreService()
                              .streamPatient(program.patientNum),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingPage();
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }

                            Patient patient = snapshot.data!;
                            var avatar = 'man';

                            switch (patient.gender) {
                              case 'F':
                                avatar = 'woman';
                                break;
                              case 'M':
                                avatar = 'man';
                                break;
                            }
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/$avatar.png',
                                    height: 120,
                                    width: 120,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    patient.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            );

                            // return Column(
                            //   children: [
                            //     // Patient avatar and name display
                            //     Container(
                            //       child: Column(
                            //         children: [
                            //           Image.asset(
                            //             'images/man.png',
                            //             height: 120,
                            //             width: 120,
                            //           ),
                            //           const SizedBox(
                            //             height: 15,
                            //           ),
                            //           const Text(
                            //             'Ahmed Alnajar',
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 20,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       height: 30,
                            //     ),
                            //   ],
                            // );
                          }),
                    ),

                    // Patient information section
                    // Patient information section
ClipRRect(
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(50),
    topRight: Radius.circular(50),
  ),
  child: Container(
    padding: const EdgeInsets.all(30),
    height: 500,
    color: Colors.grey[100],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display program information
        const SizedBox(
          height: 60,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Program Information',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Number of Activities: ${program.numofAct}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 7),
            Text(
              'Start Date: ${DateFormat('yyyy-MM-dd').format(program.startDate.toDate())}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 7),
            Text(
              'End Date: ${DateFormat('yyyy-MM-dd').format(program.endDate.toDate())}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            Center(
              child: DataTable(
                columnSpacing: 270.0,
                columns: const [
                  DataColumn(
                    label: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Frequency',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                rows: [
                  for (var activity in program.activities)
                    DataRow(
                      cells: [
                        DataCell(Text(activity.activityName)),
                        DataCell(
                          Center(
                            child: Text('${activity.frequency}'),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  ),
),

                  ],
                );
              }),
        ),
      ),
    );
  }
}
