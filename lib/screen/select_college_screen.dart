import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectCollegeScreen extends StatefulWidget {
  String schoolId = '';
  SelectCollegeScreen(this.schoolId, {super.key});

  @override
  State<SelectCollegeScreen> createState() => _SelectCollegeScreenState();
}

class _SelectCollegeScreenState extends State<SelectCollegeScreen> {
  final db = FirebaseFirestore.instance;
  static List<String> dbCollegeList = [];
  late List<String> displayList = [];

  collectCollegeList() async {
    final collRef = db.collectionGroup(widget.schoolId);
    final querySanpshot = collRef.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TestPage"),
        actions: [
          IconButton(
              onPressed: () {
                collectCollegeList();
              },
              icon: const Icon(Icons.tab))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.orange,
            child: const ListTile(
              trailing: Icon(Icons.device_hub),
              title: Text("Hello"),
              leading: Icon(Icons.local_activity),
              subtitle: Text("subtitle"),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
