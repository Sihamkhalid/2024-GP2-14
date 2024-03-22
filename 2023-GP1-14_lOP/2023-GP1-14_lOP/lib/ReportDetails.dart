import 'package:flutter/material.dart';
import 'package:flutter_application_1/barChart.dart';
import 'package:flutter_application_1/home/loadingpage.dart';
import 'package:flutter_application_1/services/firestore.dart';
import 'package:flutter_application_1/services/models.dart';
import 'package:flutter_application_1/shared/nav_bar.dart';
// import 'package:icon_forest/icon_forest.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ReportDetails extends StatefulWidget {
  final String pid;
  ReportDetails({super.key, required this.pid});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

// late TabController _tabController;
// int _selectedTabIndex = 0; // Add this line to store the selected tab index
bool status = false;

class _ReportDetailsState extends State<ReportDetails>
    with TickerProviderStateMixin {
  @override
  // void initState() {
  //   initState();
  //   _tabController = TabController(length: 2, vsync: this);
  //   _tabController.addListener(() {
  //     setState(() {
  //       _selectedTabIndex = _tabController.index;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    // Build the main scaffold for the 'reportDetails' screen
    return Scaffold(
      backgroundColor: Color(0xFF186257),
      bottomNavigationBar: NavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              //control the space above the white container
              SizedBox(
                height: 25,
              ),

              // Main content section with community articles
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: EdgeInsets.all(27),
                  height: 1000,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Report details',
                          style: TextStyle(
                            fontFamily: 'Merriweather',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TabBar for filtering articles (Weekly, Monthly)
                        TabBar(
                          controller: tabController,
                          tabs: const [
                            Tab(text: 'Weekly'),
                            Tab(text: 'Monthly'),
                          ],
                          labelColor: const Color(0xFF186257),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          indicatorColor: Colors.black,
                        ),

                        // TabBarView to display content based on the selected tab
                        SizedBox(
                          width: double.maxFinite,
                          height: 3500,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              // Tab: Weekly
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: SingleChildScrollView(
                                    child: StreamBuilder<Report>(
                                        stream: FirestoreService()
                                            .streamReport(widget.pid),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const LoadingPage();
                                          }
                                          if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'));
                                          }

                                          Report report = snapshot.data!;

                                          return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                // Text(report.PatientNumber),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Summary Results',
                                                  style: TextStyle(
                                                    fontFamily: 'Merriweather',
                                                    fontSize: 19,
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      35, 0, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 160,
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            width: 1,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      0,
                                                                      9,
                                                                      0),
                                                              child: Container(
                                                                width: 55,
                                                                height: 55,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          250,
                                                                          207,
                                                                          89)
                                                                      .withOpacity(
                                                                          0.3),
                                                                ),
                                                                child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/icons8-time-32.png',
                                                                    width: 230,
                                                                    height: 230,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            25,
                                                                            0),
                                                                    child: Text(
                                                                      '%${report.OverallPerformance}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Average',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            75,
                                                                            116,
                                                                            133)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 25),
                                                      Container(
                                                        width: 160,
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            width: 1,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      0,
                                                                      9,
                                                                      0),
                                                              child: Container(
                                                                width: 55,
                                                                height: 55,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                          1,
                                                                          95,
                                                                          253,
                                                                          240)
                                                                      .withOpacity(
                                                                          0.3),
                                                                ),
                                                                child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/icons8-what-i-do-36.png',
                                                                    width: 80,
                                                                    height: 80,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            55,
                                                                            0),
                                                                    child: Text(
                                                                      '${report.NumberOfActivities}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Activities',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            75,
                                                                            116,
                                                                            133)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          35, 0, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 160,
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            width: 1,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      0,
                                                                      9,
                                                                      0),
                                                              child: Container(
                                                                width: 55,
                                                                height: 55,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          99,
                                                                          193,
                                                                          248)
                                                                      .withOpacity(
                                                                          0.3),
                                                                ),
                                                                child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/icons8-repeat-34.png',
                                                                    width: 230,
                                                                    height: 230,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            25,
                                                                            0),
                                                                    child: Text(
                                                                      '${report.NumberOfIterations}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Iterations',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          15,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          75,
                                                                          116,
                                                                          133),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 25),
                                                      Container(
                                                        width: 160,
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            width: 1,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      0,
                                                                      9,
                                                                      0),
                                                              child: Container(
                                                                width: 55,
                                                                height: 55,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          252,
                                                                          171,
                                                                          231)
                                                                      .withOpacity(
                                                                          0.3),
                                                                ),
                                                                child: Center(
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/icons8-schedule-36.png',
                                                                    width: 80,
                                                                    height: 80,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            42,
                                                                            0),
                                                                    child: Text(
                                                                      '${report.NumberOfWeeks}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Weeks',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            75,
                                                                            116,
                                                                            133)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 30),
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 0),
                                                    const Text(
                                                      'Patient performance',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Merriweather',
                                                        fontSize: 21,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          110, 0, 0, 0),
                                                      child: FlutterSwitch(
                                                        activeText: "Chart",
                                                        inactiveText: "Text",
                                                        value: status,
                                                        valueFontSize: 17.0,
                                                        width: 100,
                                                        height: 40,
                                                        borderRadius: 35.0,
                                                        showOnOff: true,
                                                        activeColor:
                                                            const Color(
                                                                0xFF1E786B),
                                                        inactiveColor:
                                                            const Color(
                                                                0xFF1E786B),
                                                        onToggle: (val) {
                                                          setState(() {
                                                            status = val;
                                                            // Don't change the tab index if the user is switching between BarChart and Text
                                                            // if (!status) {
                                                            //   _tabController.index =
                                                            //       _selectedTabIndex;
                                                            // }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),

                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              180, 0, 0, 0),
                                                      child: Text(
                                                        'Week 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Merriweather',
                                                          fontSize: 21,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        // Handle the tap event for the icon here
                                                        print(
                                                            'Arrow icon tapped!');
                                                      },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                150, 0, 0, 0),
                                                        child: Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(
                                                    height:
                                                        10), // Adjust spacing as needed
                                                // Conditionally render either the BarChart or Text container
                                                status
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.3),
                                                                spreadRadius: 1,
                                                                blurRadius: 3,
                                                                offset:
                                                                    const Offset(
                                                                        0, 2),
                                                              ),
                                                            ],
                                                          ),
                                                          child:
                                                              BarChartSample2(),
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 160,
                                                        height: 300,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            width: 1,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                  height: 20),
                                                              Row(
                                                                children: [
                                                                  const SizedBox(
                                                                      width:
                                                                          15),
                                                                  Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255)
                                                                          .withOpacity(
                                                                              0.3),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/icons8-circle-36 (1).png',
                                                                        width:
                                                                            230,
                                                                        height:
                                                                            230,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            25,
                                                                            0),
                                                                    child: Text(
                                                                      'Activity 1 ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            160,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '70%',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Row(
                                                                children: [
                                                                  const SizedBox(
                                                                      width:
                                                                          15),
                                                                  Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255)
                                                                          .withOpacity(
                                                                              0.3),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/icons8-circle-36 (1).png',
                                                                        width:
                                                                            230,
                                                                        height:
                                                                            230,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            5,
                                                                            25,
                                                                            0),
                                                                    child: Text(
                                                                      'Activity 2 ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            160,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '30%',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Row(
                                                                children: [
                                                                  const SizedBox(
                                                                      width:
                                                                          15),
                                                                  Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255)
                                                                          .withOpacity(
                                                                              0.3),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/icons8-circle-36 (1).png',
                                                                        width:
                                                                            230,
                                                                        height:
                                                                            230,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            25,
                                                                            0),
                                                                    child: Text(
                                                                      'Activity 3 ',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            160,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      '50%',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Merriweather',
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                              ]);
                                        }),
                                  ),
                                ),
                              ),

                              /////////////// Tab: Monthly
                              Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: SingleChildScrollView(
                                    child: StreamBuilder<Report>(
                                        stream: FirestoreService()
                                            .streamReport(widget.pid),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const LoadingPage();
                                          }
                                          if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'));
                                          }

                                          Report report = snapshot.data!;

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                'Summary Results',
                                                style: TextStyle(
                                                  fontFamily: 'Merriweather',
                                                  fontSize: 19,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        35, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 160,
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          width: 1,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    10,
                                                                    0,
                                                                    9,
                                                                    0),
                                                            child: Container(
                                                              width: 55,
                                                              height: 55,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        250,
                                                                        207,
                                                                        89)
                                                                    .withOpacity(
                                                                        0.3),
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/icons8-time-32.png',
                                                                  width: 230,
                                                                  height: 230,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height: 20),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          25,
                                                                          0),
                                                                  child: Text(
                                                                    '${report.OverallPerformance}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  ' Average',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          15,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          75,
                                                                          116,
                                                                          133)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 25),
                                                    Container(
                                                      width: 160,
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          width: 1,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    10,
                                                                    0,
                                                                    9,
                                                                    0),
                                                            child: Container(
                                                              width: 55,
                                                              height: 55,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: const Color
                                                                        .fromARGB(
                                                                        1,
                                                                        95,
                                                                        253,
                                                                        240)
                                                                    .withOpacity(
                                                                        0.3),
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/icons8-what-i-do-36.png',
                                                                  width: 80,
                                                                  height: 80,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height: 20),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          55,
                                                                          0),
                                                                  child: Text(
                                                                    '${report.NumberOfActivities}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Activities',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          15,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          75,
                                                                          116,
                                                                          133)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        35, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 160,
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          width: 1,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    10,
                                                                    0,
                                                                    9,
                                                                    0),
                                                            child: Container(
                                                              width: 55,
                                                              height: 55,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        99,
                                                                        193,
                                                                        248)
                                                                    .withOpacity(
                                                                        0.3),
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/icons8-repeat-34.png',
                                                                  width: 230,
                                                                  height: 230,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height: 20),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          25,
                                                                          0),
                                                                  child: Text(
                                                                    '${report.NumberOfIterations}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Iterations',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          15,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          75,
                                                                          116,
                                                                          133)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 25),
                                                    Container(
                                                      width: 160,
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          width: 1,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    10,
                                                                    0,
                                                                    9,
                                                                    0),
                                                            child: Container(
                                                              width: 55,
                                                              height: 55,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        252,
                                                                        171,
                                                                        231)
                                                                    .withOpacity(
                                                                        0.3),
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/icons8-schedule-36.png',
                                                                  width: 80,
                                                                  height: 80,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height: 20),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          42,
                                                                          0),
                                                                  child: Text(
                                                                    '${report.NumberOfWeeks}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Months',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          15,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          75,
                                                                          116,
                                                                          133)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 0),
                                                  const Text(
                                                    'Patient performance',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Merriweather',
                                                      fontSize: 21,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(110, 0, 0, 0),
                                                    child: FlutterSwitch(
                                                      activeText: "Chart",
                                                      inactiveText: "Text",
                                                      value: status,
                                                      valueFontSize: 17.0,
                                                      width: 100,
                                                      height: 40,
                                                      borderRadius: 35.0,
                                                      showOnOff: true,
                                                      activeColor: const Color(
                                                          0xFF1E786B),
                                                      inactiveColor:
                                                          const Color(
                                                              0xFF1E786B),
                                                      onToggle: (val) {
                                                        setState(() {
                                                          status = val;
                                                          // Don't change the tab index if the user is switching between BarChart and Text
                                                          // if (!status) {
                                                          //   _tabController.index =
                                                          //       _selectedTabIndex;
                                                          // }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //text view for patient performance
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            180, 0, 0, 0),
                                                    child: Text(
                                                      'Month 1',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Merriweather',
                                                        fontSize: 21,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // Handle the tap event for the icon here
                                                      print(
                                                          'Arrow icon tapped!');
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              150, 0, 0, 0),
                                                      child: Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              // Conditionally render either the BarChart or Text container
                                              status
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 1,
                                                              blurRadius: 3,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child:
                                                            BarChartSample2(),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 160,
                                                      height: 300,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          width: 1,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 1,
                                                            blurRadius: 3,
                                                            offset:
                                                                const Offset(
                                                                    0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 20),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 15),
                                                                Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.3),
                                                                  ),
                                                                  child: Center(
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/icons8-circle-36 (1).png',
                                                                      width:
                                                                          230,
                                                                      height:
                                                                          230,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          25,
                                                                          0),
                                                                  child: Text(
                                                                    'Activity 1 ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          160,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '70%',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 15),
                                                                Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.3),
                                                                  ),
                                                                  child: Center(
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/icons8-circle-36 (1).png',
                                                                      width:
                                                                          230,
                                                                      height:
                                                                          230,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          5,
                                                                          25,
                                                                          0),
                                                                  child: Text(
                                                                    'Activity 2 ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          160,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '30%',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 15),
                                                                Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.3),
                                                                  ),
                                                                  child: Center(
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/icons8-circle-36 (1).png',
                                                                      width:
                                                                          230,
                                                                      height:
                                                                          230,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          25,
                                                                          0),
                                                                  child: Text(
                                                                    'Activity 3 ',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          160,
                                                                          10,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '50%',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Merriweather',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
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
                              ),
                            ],
                          ),
                        ),
                      ],
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
}
