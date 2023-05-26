import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_gg/screen/Widget/input_info_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final db = FirebaseFirestore.instance;
  final _emailTextController = TextEditingController();
  final _schoolTextController = TextEditingController();
  final _departmentTextController = TextEditingController();
  final _curYearTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  getUserUid() {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        return (FirebaseAuth.instance.currentUser?.uid)!;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("user not found in");
        return e.code.toString();
      }
    }
  }

  UpdateUserInfo() async {
    String userUid = getUserUid();
    final data = await db.collection("학생").doc(userUid).get();
    try {
      //FirebaseAuth.instance.currentUser?.updateEmail(_emailTextController.text);
      await db.collection("학생").doc(userUid).update(
        {
          //"email": _emailTextController.text,
          "name": _nameTextController.text,
          "school": _schoolTextController.text,
          "department": _departmentTextController.text,
          "curriculumyear": _curYearTextController.text
        },
      );
    } catch (e) {
      print("Erorr Occurred $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                children: const [
                  Text(
                    'Grad.gg',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  children: [
                    InputInfoTextField(_emailTextController, "Email",
                        Icons.email, TextInputType.emailAddress),
                    const SizedBox(
                      height: 20,
                    ),
                    InputInfoTextField(_nameTextController, "Name",
                        Icons.account_circle, TextInputType.name),
                    const SizedBox(
                      height: 20,
                    ),
                    InputInfoTextField(_schoolTextController, "School",
                        Icons.school, TextInputType.name),
                    const SizedBox(
                      height: 20,
                    ),
                    InputInfoTextField(_departmentTextController, "department",
                        Icons.book, TextInputType.name)
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InputInfoTextField(_curYearTextController, "CurriculumYear",
                  Icons.featured_play_list, TextInputType.name),
              ElevatedButton(
                onPressed: () {
                  UpdateUserInfo();
                },
                child: const Text("ClickThisButton"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
