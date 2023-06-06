import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kenya_yetu_admin/const/AppColors.dart';
import 'package:kenya_yetu_admin/widgets/dialer_icon.dart';


class AmbulanceService extends StatefulWidget {
  const AmbulanceService({Key? key}) : super(key: key);

  @override
  State<AmbulanceService> createState() => _AmbulanceServiceState();
}

class _AmbulanceServiceState extends State<AmbulanceService> {
  final CollectionReference _ambulanceData =
      FirebaseFirestore.instance.collection('Ambulance_Request_Data');
  Future<void> _delete(String productId) async {
    await _ambulanceData.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted an Emergency item')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Ambulance Requests Service"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _ambulanceData.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                    title: Text(documentSnapshot['emergency']),
                    subtitle: Column(
                      children: [
                        Text('name: ' + documentSnapshot['name']),
                        Text('phone: ' + documentSnapshot['phone']),
                        Text('location: ' + documentSnapshot['location']),
                        Text('Age: ' + documentSnapshot['age']),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 96,
                      child: Row(
                        children: [
                          IconButton(
                                  onPressed: () => _delete(documentSnapshot.id),
                                  icon: const Icon(Icons.delete)),
                          DialerIcon(phoneNumber: documentSnapshot['phone'])
                        ],
                      )
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
