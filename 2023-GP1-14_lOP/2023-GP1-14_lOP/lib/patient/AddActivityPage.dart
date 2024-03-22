import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/background.dart';
import 'package:flutter_application_1/shared/nav_bar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddActivitiesPage extends StatefulWidget {
  final String pid;
  final int numberOfActivities;
  final DateTime startDate;
  final DateTime endDate;

  const AddActivitiesPage({
    Key? key,
    required this.numberOfActivities,
    required this.startDate,
    required this.endDate,
    required this.pid,
  }) : super(key: key);

  @override
  State<AddActivitiesPage> createState() => _AddActivitiesPageState();
}

class _AddActivitiesPageState extends State<AddActivitiesPage> {
  List<String?> _selectedActivities = [];
  List<int?> _frequencies = [];
  final List<String> _availableActivities = [
    'Abduction',
    'Elbow-Extension',
    'Elbow-Flexion',
    'External-Rotation',
    'Internal-Rotation',
    'Shoulder-Extension',
    'Shoulder-Flexion',
  ];

  bool _showError = false; // Flag to indicate whether to show error

  @override
  void initState() {
    super.initState();
    _selectedActivities =
        List<String?>.generate(widget.numberOfActivities, (index) => null);
    _frequencies = List<int?>.generate(widget.numberOfActivities, (index) => 1);
  }

  void _onActivityChanged(String? newValue, int index) {
    setState(() {
      _selectedActivities[index] = newValue;

      // Remove the selected activity from other dropdown lists
      for (int i = 0; i < widget.numberOfActivities; i++) {
        if (i != index && _selectedActivities[i] == newValue) {
          _selectedActivities[i] = null;
        }
      }
    });
  }

  Future<void> _submitActivities(String pid) async {
    // Check if at least one activity is selected
    if (_selectedActivities.contains(null)) {
      setState(() {
        _showError = true; // Set showError flag to true
      });
      return;
    }
    // Reset showError flag if no error
    setState(() {
      _showError = false;
    });
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Use the user's UID as the therapist ID
        String therapistId = user.uid;

        // Fetch current counter value for the therapist
        DocumentSnapshot therapistDocSnapshot = await FirebaseFirestore.instance
            .collection('Therapist')
            .doc(therapistId)
            .get();

        int currentCounter = therapistDocSnapshot.exists
            ? (therapistDocSnapshot.data() as Map<String, dynamic>?) != null
                ? (therapistDocSnapshot.data()
                        as Map<String, dynamic>?)!['programCounter'] ??
                    0
                : 0
            : 0;

        // Use the current counter value as the program ID
        String programId = (currentCounter + 1).toString();

        // Increment the counter for the therapist
        await FirebaseFirestore.instance
            .collection('Therapist')
            .doc(therapistId)
            .set({'programCounter': currentCounter + 1},
                SetOptions(merge: true));

        // Proceed with adding the program using the programId
        List<Map<String, dynamic>> activitiesList = [];

        for (int i = 0; i < widget.numberOfActivities; i++) {
          String? selectedActivity = _selectedActivities[i];
          int frequency = _frequencies[i] ?? 1;

          // Check if the activity is selected before adding it to the list
          if (selectedActivity != null) {
            activitiesList.add({
              'Activity Name': selectedActivity,
              'Frequency': frequency,
            });
          }
        }

        Map<String, dynamic> dataToSave = {
          'Therapist ID': therapistId,
          'Patient Number':
              pid, // Add patient ID to associate program with patient
          'Program ID': programId,
          'Start Date': widget.startDate,
          'End Date': widget.endDate,
          'NumberOfActivities': widget.numberOfActivities,
          'Activities': activitiesList,
        };

        // Add the program using the therapist's ID
        await FirebaseFirestore.instance
            .collection('Program')
            .doc(programId)
            .set(dataToSave);

        Navigator.of(context).pushNamed('homepage');

        QuickAlert.show(
          context: context,
          text: "The Program is in your list now!",
          type: QuickAlertType.success,
        );
      } else {
        print('User is not authenticated');
      }
    } catch (e) {
      print('Error adding to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(),
      body: Stack(
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
          Background(),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.8,
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
                    children: <Widget>[
                      const Text(
                        'Add Activities',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(
                        widget.numberOfActivities,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ), // Add spacing between each ActivityForm
                          child: ActivityForm(
                            activityNumber: index + 1,
                            activities: _availableActivities,
                            selectedActivity: _selectedActivities[index],
                            frequency: _frequencies[index] ?? 1,
                            onActivityChanged: (newValue) =>
                                _onActivityChanged(newValue, index),
                            onFrequencyChanged: (newValue) {
                              setState(() {
                                _frequencies[index] = newValue;
                              });
                            },
                            showError: _showError, 
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _submitActivities(widget.pid),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF186257),
                          // background
                          foregroundColor: Colors.white,
                          // foreground
                        ),
                        child: const Text('Submit Activities'),
                      )
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

class ActivityForm extends StatefulWidget {
  final int activityNumber;
  final List<String> activities;
  final String? selectedActivity;
  final int frequency;
  final Function(String?) onActivityChanged;
  final Function(int) onFrequencyChanged;
  final bool showError;

  const ActivityForm({
    Key? key,
    required this.activityNumber,
    required this.activities,
    this.selectedActivity,
    required this.frequency,
    required this.onActivityChanged,
    required this.onFrequencyChanged,
    required this.showError,
  }) : super(key: key);

  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Activity ${widget.activityNumber}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: widget.selectedActivity,
            decoration: InputDecoration(
              labelText: 'Select Activity',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.showError && widget.selectedActivity == null
                      ? Colors.red
                      : Color(0xFF186257),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              errorText: widget.showError && widget.selectedActivity == null
                  ? 'Please select an activity'
                  : null,
            ),
            onChanged: widget.onActivityChanged,
            items:
                widget.activities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Frequency: ${widget.frequency} times',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (widget.frequency > 1) {
                    widget.onFrequencyChanged(widget.frequency - 1);
                  }
                },
                icon: const Icon(Icons.remove),
              ),
              IconButton(
                onPressed: () {
                  widget.onFrequencyChanged(widget.frequency + 1);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
