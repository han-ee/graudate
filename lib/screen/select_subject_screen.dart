import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectSubjectScreen extends StatefulWidget {
  final String subjectid;
  final String inputRoute;
  const SelectSubjectScreen(this.subjectid, this.inputRoute, {super.key});

  @override
  State<SelectSubjectScreen> createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  final db = FirebaseFirestore.instance;
  static List<String> dbSubjectList = [];
  late List<String> displayList = [];
  late String lastRoute;

  collectSubjectList() async {
    lastRoute = widget.inputRoute + widget.subjectid;
    print(lastRoute);
    print(widget.subjectid);
    dbSubjectList = [];
    final collRef = await db.collection("$lastRoute/학과").get();
    print(collRef.docs);
    for (var doc in collRef.docs) {
      print(doc.id);
      dbSubjectList.add(doc.id);
    }
    print(dbSubjectList);
    setState(() {
      displayList = List.from(dbSubjectList.toSet().toList());
      lastRoute = lastRoute;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    collectSubjectList();
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
                collectSubjectList();
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
