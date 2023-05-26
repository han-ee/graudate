import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_gg/screen/login_screen.dart';
import 'package:grad_gg/screen/profile_screen.dart';
import 'package:grad_gg/screen/profile_screen.dart';
import 'package:grad_gg/screen/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

import 'My_Status.dart';
import 'StatusPage.dart';



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

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String userName='';
  String userSchool='';
  String userdoc='';
  double _gpa = 0.0;
  int _credits = 0;
int tnum = 0;
  final List<Widget> pages = [
    ProfileScreen(),
    MyStatusPage(),
    MainScreen(),
    SearchScreen(),
    MyCheckPage()
  ];
 /* Future<void> getStudentData() async {
    FirebaseFirestore.instance.collection("학생").get().then(
          (QuerySnapshot querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot['email'] == user!.email) {

              userdoc = docSnapshot.id;
              userName = docSnapshot['name'];
              userSchool = docSnapshot['school'];
              break;
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }*/
  Future<void> getStudentData() async{
    await FirebaseFirestore.instance.collection("학생").snapshots().listen(
          (QuerySnapshot querySnapshot) {
        print("Data refreshed");
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot['email'] == user!.email) {
            userdoc = docSnapshot.id;
            userName = docSnapshot['name'];
            userSchool = docSnapshot['school'];
            print(userName);
            print(userSchool);
          }
        }
      },
      onError: (e) => print("Error: $e"),
    );
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting().then((_) => setState((){}));
    _loadData();
    getStudentData();

  }

  Future<void> _getStudentData() async{
    await getStudentData();
  }

  Future<void> _saveData() async { //gpa credits 임시 변수생성
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('gpa', _gpa);
    await prefs.setInt('credits', _credits);
  }




  Future<void> _loadData() async { //gpa credits 임시 변수생성
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _gpa = prefs.getDouble('gpa') ?? 0.0;
      _credits = prefs.getInt('credits') ?? 0;
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

            children: <Widget>[
              Container( //stack만 쓰면 높이 제한이 사라져 오류 발생 컨테이너로 묶어서 높이 200으로 지정
                height:800,
                child: Stack(
                    children: [
                      Positioned(
                          top: 70,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, //왼쪽정렬
                            children: [
                              Text('Grad.gg',
                                style: TextStyle( //글자 스타일
                                  color: Colors.black, //글자 색 설정
                                  letterSpacing: 2.0, //글자 자간설정
                                  fontSize: 60.0, //폰트크기설정
                                  fontWeight: FontWeight.w600, //두께설정
                                ),
                              ),

                              FutureBuilder( //userSchool 대기
                                future: getStudentData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {

                                    return Text(userSchool,
                                      style: TextStyle( //글자 스타일
                                        color: Colors.black, //글자 색 설정
                                        letterSpacing: 2.0, //글자 자간설정
                                        fontSize: 30.0, //폰트크기설정
                                        fontWeight: FontWeight.w700, //두께설정
                                      ),);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),


                              SizedBox(
                                height: 25.0,
                              ),
                              Text(' MY SPACE',
                                style: TextStyle( //글자 스타일
                                  color: Colors.black, //글자 색 설정
                                  fontSize: 30.0, //폰트크기설정
                                  fontWeight: FontWeight.w400, //두께설정
                                ),
                              ),
                              SizedBox(
                                height: 3.0,
                              ),

                              Row(
                              children: [
                              Container( //USER_NAME DEPARTMENTS
                                width: 170,
                                height: 170,
                                child: ElevatedButton(
                                  onPressed: () {
                                   // Navigator.push(
                                   //   context,MaterialPageRoute(builder: (context) => ProfileScreen()),
                                   // );


                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white38),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Image.asset( //루트폴더에 assets/images폴더 생성 후 pubspec.yaml에 assets: - assets/images/ 입력
                                          'assets/images/profilepic.JPG',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover, // 이미지 비율 유지
                                        ),
                                      ),
                                      SizedBox(height:15),

                                      FutureBuilder( //userName 대기
                                        future: getStudentData(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            return Text(userName,
                                              style: TextStyle( //글자 스타일
                                                color: Colors.black, //글자 색 설정
                                                fontSize: 20.0, //폰트크기설정
                                                fontWeight: FontWeight.w700, //두께설정
                                              ),);
                                          } else {
                                            return CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                      FutureBuilder( //userSchool 대기
                                        future: getStudentData(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                            return Text(userSchool,
                                              style: TextStyle( //글자 스타일
                                                color: Colors.black, //글자 색 설정
                                                fontSize: 20.0, //폰트크기설정
                                                fontWeight: FontWeight.w700, //두께설정
                                              ),);
                                          } else {
                                            return CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                                SizedBox(width: 20), // 가로 방향으로 간격 추가

                                Container(
                                  width: 180,
                                  height: 170,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, // 오른쪽 열을 왼쪽 정렬로 만듭니다.
                                  children: [
                                    Text(
                                      DateFormat('yyyy년', 'ko_KR').format(DateTime.now()), // 현재 시간 표시
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),Text(
                                      DateFormat('MM월', 'ko_KR').format(DateTime.now()), // 현재 시간 표시
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.bottomRight,
                                    child: Text(
                                      DateFormat('d일', 'ko_KR').format(DateTime.now()), // 현재 일, 요일 표시
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 29.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        DateFormat('EEEE', 'ko_KR').format(DateTime.now()), // 현재 일, 요일 표시
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 29.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                              ],
                              ),



                              SizedBox(height:30),

                              Text(' MY STATUS',
                                style: TextStyle( //글자 스타일
                                  color: Colors.black, //글자 색 설정
                                  fontSize: 30.0, //폰트크기설정
                                  fontWeight: FontWeight.w400, //두께설정
                                ),
                              ),

                              SizedBox(height:5),

                              Container(
                                width: 375,
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {

                                    print("a");
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white38),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 25, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 20),
                                              Text("전체평점",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w700,),
                                              ),
                                              SizedBox(width: 40),
                                              Text("이수학점     ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w700,),),
                                              SizedBox(width: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(width: 1),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 0, bottom: 50),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 40),
                                              Text("4.2 /4.5",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 26.0,
                                                  fontWeight: FontWeight.w700,),
                                              ),
                                              SizedBox(width: 50),
                                              Text(" 65 /130    ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 26.0,
                                                  fontWeight: FontWeight.w700,),),
                                              SizedBox(width: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //onPressed: () {},
                                ),
                              ),

                              SizedBox(height: 15),
                            ],
                          )
                      ),
                    ]
                ),
              ),
            ]
        ),
      ),
    );
  }
}
