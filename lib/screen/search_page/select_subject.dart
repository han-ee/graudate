import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectSubjectScreen extends StatefulWidget {
  final String departmentid;
  final String inputRoute;
  const SelectSubjectScreen(this.departmentid, this.inputRoute, {super.key});

  @override
  State<SelectSubjectScreen> createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  final db = FirebaseFirestore.instance;
  static List<String> dbSubjectList = [];
  late List<String> displayList = [];
  late String lastRoute;

  collectYearList() async {
    lastRoute = "/${widget.inputRoute}/${widget.departmentid}/년도";

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
    // TODO: implement initState
    collectYearList();
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
                collectYearList();
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
                    leading: const Icon(Icons.star, color: Colors.black),
                    subtitle: const Text("subtitle"),
                  ),
                );
              },
              itemCount: displayList.length,
            ),
    );
  }
}
