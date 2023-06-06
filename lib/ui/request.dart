import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kenya_yetu_admin/const/AppColors.dart';

import 'bottom_navigation_controller.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  // final TextEditingController _locationController = TextEditingController();
  final TextEditingController _needController = TextEditingController();
  String _location = '';
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  void sendUserDataToDB() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;

    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("Request_for_help_data");
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _location = placemarks[0].street!;
      });
    print(placemarks);
    double latitude = position.latitude;
    double longitude = position.longitude;
    return collectionRef.doc(currentUser!.email)
        .set({
      "name": _nameController.text,
      "phone": _phoneController.text,
      "age": _ageController.text,
      "location": _location,
      "latitude": latitude,
      "longitude": longitude,
      "need": _needController.text,
    })
        .then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (_) => const BottomNavigation())))
        .catchError((error) => print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Request"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            "Post Your Request here",
            style: TextStyle(color: green, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter the data of the person who need help",
            style: TextStyle(color: green, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: dh * 0.7,
                width: 300,
                child: SingleChildScrollView(
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "What is the Need",
                        style: TextStyle(
                          color: green,
                        ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            labelText: 'ex: food, blanket, etc',
                          ),
                          keyboardType: TextInputType.text,
                          controller: _needController,
                        ),
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                          color: green,
                        ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            labelText: 'enter your full name',
                          ),
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                        ),
                      ),
                      Text(
                        "Contact Number",
                        style: TextStyle(
                          color: green,
                        ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            labelText: 'ex: +2541234567890',
                          ),
                          keyboardType: TextInputType.number,
                          controller: _phoneController,
                        ),
                      ),
                      Text(
                        "Age",
                        style: TextStyle(
                          color: green,
                        ),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            labelText: 'ex: 30',
                          ),
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async{
                            sendUserDataToDB();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          label: Text('DONE',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
