// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
//import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/loadingpage.dart';
import 'package:flutter_application_1/services/authentic.dart';
import 'package:flutter_application_1/services/firestore.dart';
import 'package:flutter_application_1/services/models.dart';
import 'package:flutter_application_1/shared/background.dart';
import 'package:flutter_application_1/shared/nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Write_article extends StatefulWidget {
  const Write_article({super.key});

  @override
  State<Write_article> createState() => _Write_article_State();
}

class _Write_article_State extends State<Write_article> {
  //String imageUrl = '';
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _articleController = TextEditingController();
  final _keywordsController = TextEditingController();
  File? selectedImage;
  String keywordsList = '';
  String? imageUrl;
  bool pressed = false;
  late String name;
  late Stream<Therapist> therapistStream;
  // void initState() {
  //   super.initState();
  //   //name = (FirestoreService().streamTherapist() as Therapist).name;
  // }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload image to Firestore Storage
      Reference storageReference = FirebaseStorage.instanceFor(
              bucket: 'gs://therasense-8f8c3.appspot.com')
          .ref()
          .child('images/${DateTime.now()}.png');
      File imageFile = File(pickedFile.path);
      UploadTask uploadTask = storageReference.putFile(imageFile);

      try {
        // Wait for the upload to complete
        await uploadTask;

        // Get the uploaded image URL
        imageUrl = await storageReference.getDownloadURL();

        // Show a success message or navigate to another screen
        print('Image uploaded successfully! URL: $imageUrl');

        // Refresh the UI to display the uploaded image
        setState(() {});
      } catch (error) {
        // Handle errors during image upload
        print('Error uploading image: $error');
      }
    } else {
      // Handle case when no image is selected
      print('Please pick an image first.');
    }
  }

  var user = AuthService().user;

  Future<void> Publish() async {
    Map<String, dynamic> dataToSave = {
      'AutherID': user!.uid,
      'name': name,
      'PublishTime': FieldValue.serverTimestamp(),
      'Title': _titleController.text,
      'Content': _articleController.text,
      'KeyWords': _keywordsController.text,
      'image': imageUrl,
    };

    bool allFieldsNotEmpty = true;

    dataToSave.forEach((key, value) {
      if (key != 'PublishTime' && (value == null || value.isEmpty)) {
        allFieldsNotEmpty = false;
      }
    });

    if (allFieldsNotEmpty) {
      var docRef = await FirebaseFirestore.instance
          .collection('Article')
          .add(dataToSave);

      // Retrieve the auto-generated ID
      String autoGeneratedId = docRef.id;

      // Update the document with the 'ID' field
      await docRef.update({'ID': autoGeneratedId});

      Navigator.of(context).pushNamed('communitypage');

      QuickAlert.show(
        context: context,
        text: "The article is published now!",
        type: QuickAlertType.success,
      );
    } else {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text('Please fill out all the fields.'),
        ),
      );
    }

    setState(() {
      pressed = imageUrl == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        bottomNavigationBar: NavBar(),

        body: Stack(
          children: [
            Background(),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                color: Color(0xFF186257),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.80,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Write an article',
                            style: TextStyle(
                              fontFamily: 'Merriweather',
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _titleController,
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                  hintText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF186257),
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.title),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Title is required';
                                  } else if (value.length > 75) {
                                    return 'Title must be less than 75 characters';
                                  }
                                  return null;
                                },
                                maxLines: null,
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _keywordsController,
                                decoration: InputDecoration(
                                  labelText: 'Keywords',
                                  hintText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF186257),
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.vpn_key),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Keywords are required';
                                  } else if (value.length > 40) {
                                    return 'Keywords must be less than 40 characters';
                                  }
                                  return null;
                                },
                                maxLines: null,
                              ),

                              SizedBox(height: 15),

                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _articleController,
                                decoration: InputDecoration(
                                  labelText: 'Content',
                                  hintText: '',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF186257),
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.article),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 0, 0, 100),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Article is required';
                                  } else if (value.length > 10000) {
                                    return 'Content must be less than 10000 characters';
                                  }
                                  return null;
                                },
                                maxLines: null,
                              ),

                              //image upload
                              SizedBox(height: 15),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  imageUrl != null
                                      ? Image.network(
                                          imageUrl!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
                                  ElevatedButton(
                                    onPressed: _pickImage,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor:
                                          Color.fromARGB(255, 77, 77, 77),
                                      backgroundColor: Colors
                                          .white, // Set the background color to white
                                      fixedSize: Size(500, 60),
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: Color.fromARGB(
                                                255, 77, 77, 77)),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.upload,
                                          size: 25,
                                          color:
                                              Color.fromARGB(255, 77, 77, 77),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'Upload Image',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  if (selectedImage != null)
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Image.file(
                                        selectedImage!,
                                        width: 120,
                                        height: 120,
                                      ),
                                    ),
                                  if (selectedImage == null && pressed)
                                    Visibility(
                                      visible: selectedImage == null && pressed,
                                      child: Text(
                                        'No image selected',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 196, 0, 0),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              StreamBuilder<Therapist>(
                                stream: FirestoreService().streamTherapist(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return LoadingPage();
                                  }

                                  // Access the therapist object from the snapshot
                                  Therapist therapist =
                                      snapshot.data ?? Therapist();

                                  // Access the name property of the Therapist object
                                  name = therapist.name;
                                  return Container();
                                },
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: GestureDetector(
                            onTap: Publish,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFF186257),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  'Publish',
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

        // ],
      ),
    );
    // );
  }
}

extension StringValidation on String {
  bool get isAlphaOnly => runes.every(
      (rune) => (rune >= 65 && rune <= 90) || (rune >= 97 && rune <= 122));
}
