import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectSubjectScreen extends StatefulWidget {
  final String inputRoute;
  final String termid;
  const SelectSubjectScreen(this.termid, this.inputRoute, {super.key});

  @override
  State<SelectSubjectScreen> createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  final db = FirebaseFirestore.instance;
  static List<String> dbSubjectList = [];
  late List<String> displayList = [];
  late String lastRoute;

  collectSubjectList() async {
    print("여기는 과목 선택 페이지");
    lastRoute = "${widget.inputRoute}/${widget.termid}";

    dbSubjectList = [];
    final collRef = db.collection(widget.inputRoute).doc(widget.termid);
    collRef.get().then((value) async {
      value.data();
    });
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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.tab))],
      ),
      body: displayList.isEmpty
          ? const Center(
              child: Text("ㅁㄴㅇㅁㅇ"),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.amber,
                  child: ListTile(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SelectTermScreen(
                      //       displayList[index],
                      //       lastRoute,
                      //     ),
                      //   ),
                      // );
                    },
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
