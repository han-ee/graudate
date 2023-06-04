import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Text('Welcome to ${user!.email} profile page'),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  FirebaseAuth.instance.signOut();
                  print("로그아웃후 $user");
                });
                //Navigator.pushReplacementNamed(context, '/loginPage');
              },
              icon: const Icon(
                Icons.logout_outlined,
              ))
        ],
      ),
    );
  }
}
