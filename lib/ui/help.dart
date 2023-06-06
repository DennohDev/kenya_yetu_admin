import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kenya_yetu_admin/const/AppColors.dart';
import 'package:kenya_yetu_admin/widgets/dialer_icon.dart';

import 'help_page.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final CollectionReference _requestData =
      FirebaseFirestore.instance.collection('Offer_to_help_data');
  Future<void> _delete(String productId) async {
    await _requestData.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted an Alert')));
  }
  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: dh,
                color: Colors.grey.shade300,
                child: StreamBuilder(
                  stream: _requestData.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(documentSnapshot['name']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Donation: ' +
                                      documentSnapshot['donation']),
                                  Text('phone: ' + documentSnapshot['phone']),
                                  Text('location: ' +
                                      documentSnapshot['location']),
                                  Text('Age: ' + documentSnapshot['age']),
                                ],
                              ),
                              trailing: SizedBox(
                                  width: 96,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () =>
                                              _delete(documentSnapshot.id),
                                          icon: const Icon(Icons.delete)),
                                          DialerIcon(phoneNumber: documentSnapshot['phone'])
                                    ],
                                  )),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
