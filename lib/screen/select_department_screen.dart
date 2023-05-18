import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectDepartmentScreen extends StatefulWidget {
  final String subjectid;
  final String inputRoute;
  const SelectDepartmentScreen(this.subjectid, this.inputRoute, {super.key});

  @override
  State<SelectDepartmentScreen> createState() => _SelectDepartmentScreenState();
}

class _SelectDepartmentScreenState extends State<SelectDepartmentScreen> {
  final db = FirebaseFirestore.instance;
  static List<String> dbSubjectList = [];
  late List<String> displayList = [];
  late String lastRoute;

  collectDepartmentList() async {
    lastRoute = "${widget.inputRoute}${widget.subjectid}/학과";
    dbSubjectList = [];
    final collRef = await db.collection(lastRoute).get();
    for (var doc in collRef.docs) {
      dbSubjectList.add(doc.id);
    }
    setState(() {
      displayList = List.from(dbSubjectList.toSet().toList());
      lastRoute = lastRoute;
    });
  }

  @override
  void initState() {
    collectDepartmentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TestPage"),
        actions: [
          IconButton(
              onPressed: () {
                collectDepartmentList();
              },
              icon: const Icon(Icons.tab))
        ],
      ),
      body: displayList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.amber,
                  child: ListTile(
                    //trailing: const Icon(Icons.hub_outlined),
                    title: Text(
                      displayList[index],
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.favorite_border_outlined),
                      onPressed: () {
                        print("isPushed");
                      },
                    ),
                    subtitle: const Text("subtitle"),
                  ),
                );
              },
              itemCount: displayList.length,
            ),
    );
  }
}
