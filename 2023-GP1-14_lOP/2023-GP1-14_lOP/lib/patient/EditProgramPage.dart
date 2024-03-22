import 'package:flutter/material.dart';

class EditProgramPage extends StatefulWidget {
  final String currentProgramName;
  final int currentNumberOfActivities;

  const EditProgramPage({
    Key? key,
    required this.currentProgramName,
    required this.currentNumberOfActivities,
  }) : super(key: key);

  @override
  _EditProgramPageState createState() => _EditProgramPageState();
}

class _EditProgramPageState extends State<EditProgramPage> {
  TextEditingController programNameController = TextEditingController();
  int numberOfActivities = 0;

  @override
  void initState() {
    super.initState();
    programNameController.text = widget.currentProgramName;
    numberOfActivities = widget.currentNumberOfActivities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Program'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: programNameController,
              decoration: const InputDecoration(labelText: 'Program Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfActivities = int.tryParse(value) ?? 0;
                });
              },
              decoration: const InputDecoration(labelText: 'Number of Activities'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the updated program name and number of activities
                String updatedProgramName = programNameController.text;
                // Handle saving or updating the data as needed
                // You can navigate back to the previous page with the updated data
                Navigator.pop(context, {
                  'programName': updatedProgramName,
                  'numberOfActivities': numberOfActivities,
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
