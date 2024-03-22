import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ReportDetails.dart';
import 'package:flutter_application_1/home/loadingpage.dart';
import 'package:flutter_application_1/services/firestore.dart';
import 'package:flutter_application_1/services/models.dart';
import 'package:flutter_application_1/shared/nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectedProgram extends ChangeNotifier {
  Program? _selectedProgram;

  Program? get selectedProgram => _selectedProgram;

  void setSelectedProgram(Program? program) {
    _selectedProgram = program;
    notifyListeners();
  }
}

class pickProgram extends StatefulWidget {
  final String pid;

  const pickProgram({Key? key, required this.pid}) : super(key: key);

  @override
  _pickProgramState createState() => _pickProgramState();
}

class _pickProgramState extends State<pickProgram> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedProgram(),
      child: Scaffold(
        backgroundColor: const Color(0xFF186257),
        bottomNavigationBar: const NavBar(),
        body: SafeArea(
          child: StreamBuilder<List<Report>>(
              stream: FirestoreService().streamPatientReports(widget.pid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                List<Report> reports = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25, 40, 25, 0),
                      ),
                      StreamBuilder<List<Program>>(
                        stream: FirestoreService()
                            .streamPatientPrograms(widget.pid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LoadingPage();
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          List<Program> programs = snapshot.data!;
                          List<int> pWithReport = [];
                          List<Program> programsWithReport = [];
                          bool have_report = false;

                          for (int i = 0; i < programs.length; i++) {
                            for (int j = 0; j < reports.length; j++) {
                              if (programs[i].pid == reports[j].ProgramID) {
                                have_report = true;
                              }
                            }
                            if (have_report) {
                              pWithReport.add(i);
                              programsWithReport.add(programs[i]);
                            }
                          }
                          programs
                              .sort((a, b) => b.endDate.compareTo(a.endDate));
                          if (programs.isEmpty) {
                            return Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  padding: const EdgeInsets.all(30),
                                  height: 4000,
                                  color: Colors.grey[100],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Select program to generate report',
                                        style: TextStyle(
                                          fontFamily: 'Merriweather',
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Text('No program is found')
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  padding: const EdgeInsets.all(30),
                                  height: 4000,
                                  color: Colors.grey[100],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Select program to generate report',
                                        style: TextStyle(
                                          fontFamily: 'Merriweather',
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: programs.length,
                                          itemBuilder: (context, index) {
                                            Program program = programs[index];

                                            final selectedProgram =
                                                Provider.of<SelectedProgram>(
                                                    context);

                                            bool isSelected = selectedProgram
                                                    .selectedProgram ==
                                                program;

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (isSelected &
                                                      !programsWithReport
                                                          .contains(program)) {
                                                    selectedProgram
                                                        .setSelectedProgram(
                                                            null);
                                                    print(
                                                        'isSelected: $isSelected');
                                                  } else {
                                                    selectedProgram
                                                        .setSelectedProgram(
                                                            program);
                                                    print(
                                                        'isSelected: $isSelected');
                                                  }
                                                },
                                                child: Material(
                                                  elevation:
                                                      5, // Set elevation to 5
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: pWithReport
                                                          .contains(index)
                                                      ? Colors.grey[400]
                                                      : Colors.white,
                                                  borderOnForeground:
                                                      true, // Add this line
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      border: Border.all(
                                                        color: isSelected &
                                                                !pWithReport
                                                                    .contains(
                                                                        index)
                                                            ? Colors.blue
                                                            : Colors
                                                                .transparent, // Black border when isSelected is true
                                                        width: isSelected &
                                                                !pWithReport
                                                                    .contains(
                                                                        index)
                                                            ? 1.5
                                                            : 0, // Border width when isSelected is true
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      leading: Image.asset(
                                                        'images/currentProgram.png',
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                      title: Text(
                                                        'Program ID: ${index + 1}',
                                                      ),
                                                      subtitle: Text(
                                                          'Ended on ${DateFormat('yyyy-MM-dd').format(program.endDate.toDate())}'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          final selectedProgram =
                                              Provider.of<SelectedProgram>(
                                                  context,
                                                  listen: false);
                                          if ((selectedProgram
                                                      ._selectedProgram !=
                                                  null) &
                                              (!programsWithReport.contains(
                                                  selectedProgram
                                                      ._selectedProgram))) {
                                            // Navigator.of(context)
                                            //     .pushNamed('ReportDetails');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReportDetails(
                                                          pid: selectedProgram
                                                              ._selectedProgram!
                                                              .pid)),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please select a program to generate a report.'),
                                            ));
                                          }
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 16),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF186257),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: Colors
                                                  .black, // Add black border
                                              width: 1, // Set border width
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Generate report',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Merriweather',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
