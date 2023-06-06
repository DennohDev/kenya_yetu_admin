// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kenya_yetu_admin/const/AppColors.dart';

import 'noti.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Alert extends StatefulWidget {
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  final CollectionReference _Alerts =
      FirebaseFirestore.instance.collection('Alerts');
  final TextEditingController _alertController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  Future<void> _sendAlert([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _alertController.text = documentSnapshot['alert'];
      _contentController.text = documentSnapshot['Content'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _alertController,
                  decoration: const InputDecoration(labelText: 'Alert Title'),
                ),
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    labelText: 'Alert Message',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String alert = _alertController.text;
                    final String content = _contentController.text;
                    if (alert.isNotEmpty && content.isNotEmpty) {
                      await _Alerts.add({"alert": alert, "content": content});
                      //Show notifications
                      Noti.showBigTextNotification(
                          title: alert,
                          body: content,
                          fln: flutterLocalNotificationsPlugin);
                      _contentController.text = '';
                      _alertController.text = '';
                    } else {
                      Fluttertoast.showToast(msg: 'Please fill in all feilds');
                    }

                    Navigator.pop(ctx);
                  },
                  child: const Text('Send Alert'),
                )
              ],
            ),
          );
        });
  }

  // Update method
  Future<void> _updateAlert([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _alertController.text = documentSnapshot['alert'];
      _contentController.text = documentSnapshot['content'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _alertController,
                  decoration: const InputDecoration(labelText: 'Alert Title'),
                ),
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    labelText: 'Alert Message',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String alert = _alertController.text;
                    final String content = _contentController.text;
                    if (alert.isNotEmpty && content.isNotEmpty) {
                      await _Alerts.doc(documentSnapshot!.id)
                          .update({"alert": alert, "content": content});
                    } else {
                      Fluttertoast.showToast(msg: 'Please fill in all feilds');
                    }
                    // Show Notification
                    Noti.showBigTextNotification(
                        title: alert,
                        body: content,
                        fln: flutterLocalNotificationsPlugin);
                    _alertController.text = '';
                    _contentController.text = '';
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _Alerts.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted an Alert')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Alert'),
        backgroundColor: green,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _Alerts.snapshots(),
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
                    isThreeLine: true,
                    leading: const Icon(Icons.notifications_active_rounded,
                        color: Colors.red),
                    title: Text(documentSnapshot['alert']),
                    subtitle: Text(
                      documentSnapshot['content'],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () => _updateAlert(documentSnapshot),
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () => _delete(documentSnapshot.id),
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendAlert();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.notification_add),
      ),
    );
  }
}
