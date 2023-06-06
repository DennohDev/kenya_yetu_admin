import 'package:flutter/material.dart';
import 'package:kenya_yetu_admin/const/AppColors.dart';
import 'package:kenya_yetu_admin/ui/Alert.dart';
import 'package:kenya_yetu_admin/ui/Ambulance_Screen.dart';
import 'package:kenya_yetu_admin/ui/NavBar.dart';
import 'package:kenya_yetu_admin/ui/donation_Screen.dart';
import 'package:kenya_yetu_admin/ui/guidance_Screen.dart';
import 'package:kenya_yetu_admin/ui/request_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text('Kenya Yetu Admin'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Alert()));
            },
             icon: Icon(Icons.notifications),
             )
        ],
      ),
      drawer: NavBar(),
     //bottomNavigationBar: const BottomNavigation(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestScreen()),
                  );
                  },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "asset/req.png",
                        height: 120,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Request',
                      style: TextStyle(
                          color: green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AmbulanceService()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "asset/amb.png",
                        height: 120,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ambulance',
                      style: TextStyle(
                          color: green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DonationScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "asset/donate.png",
                            height: 120,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Donation',
                          style: TextStyle(
                              color: green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GuidanceScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "asset/guide.png",
                            height: 120,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Guidance',
                          style: TextStyle(
                              color: green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

