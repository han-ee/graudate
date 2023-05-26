import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_gg/screen/search_page.dart';

import 'My_Status.dart';
import 'StatusPage.dart';
import 'mainscreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class NavPage extends StatefulWidget {
  @override
  State<NavPage> createState() => _MyStatusPageState();


}



class _MyStatusPageState extends State<NavPage> {

  final List<Widget> pages = [
    ProfileScreen(),
    MyStatusPage(),
    MainScreen(),
    SearchScreen(),
    MyCheckPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(

        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: "프로필",),
          NavigationDestination(icon: Icon(Icons.calculate), label: "학점계산기"),
          NavigationDestination(icon: Icon(Icons.home), label: '홈'),
          NavigationDestination(icon: Icon(Icons.search), label: '검색'),
          NavigationDestination(icon: Icon(Icons.done), label: '졸업요소'),
        ],

        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            print("마이스테터스");
            currentIndex = index;

            print(index);
          });
        },
      ),
    );
  }
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
