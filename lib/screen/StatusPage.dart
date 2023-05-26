import 'package:flutter/material.dart';
import 'package:grad_gg/screen/profile_screen.dart';
import 'mainscreen.dart';

class Season_Category extends StatefulWidget {
  const Season_Category({Key? key}) : super(key: key);
  @override
  State<Season_Category> createState() => _Season_CategoryState();
}

final ValueNotifier<String> selectedSeasonNotifier = ValueNotifier<String>("");

class _Season_CategoryState extends State<Season_Category> {

  int selectedCategory = 0;

  List<String> season = ["1학년 1학기", "1학년 2학기", "2학년 1학기", "2학년 2학기", "3학년 1학기",
    "3학년 2학기", "4학년 1학기", "4학년 2학기"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: season.length,
          itemBuilder: (context, index) => buildCategory(index, context)),
    );
  }

  Padding buildCategory(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: GestureDetector(
        onTap: (){
          setState(() {
            selectedCategory = index;
          });
          selectedSeasonNotifier.value = season[index];


        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                season[index],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: index == selectedCategory
                        ? Colors.black
                        : Colors.black.withOpacity(0.4),
                    fontSize: 12.0)
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: index == selectedCategory
                      ? Colors.grey
                      : Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStatusPage extends StatelessWidget {
  MyStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.0,
          ),
          TextButton(
            onPressed: () {
              print('졸업 시켜줘');
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '졸업.GG\n',
                    style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: '경상국립대학교',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '\n\nMY STATUS',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text('\n     ●  이수학점',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '       65 / 130',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text('\n     ●  평점',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '       4.2 / 4.5',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(
            height: 50,
          ),

          Season_Category(),

          ValueListenableBuilder(
            valueListenable: selectedSeasonNotifier,
            builder: (BuildContext context, String value, Widget? child) {

              Color color = Colors.grey;
              String textValue = "";
              List<String> currentSub = [];
              List<String> currentCredit = [];
              List<String> currentGrade = [];

              List<String> userSub1_1 = ['C언어', 'C언어 실습'];
              List<String> userCredit1_1 = ['2학점', '1학점'];
              List<String> userGrade1_1 = ['A0', 'A+'];

              List<String> userSub1_2 = ['파이썬', '파이썬 실습'];
              List<String> userCredit1_2 = ['2학점', '1학점'];
              List<String> userGrade1_2 = ['B+', 'A0'];

              List<String> userSub2_1 = ['기초설계PBL', '컴퓨터시스템개론', '이산수학', '리눅스시스템', '리눅스시스템 실습'];
              List<String> userCredit2_1 = ['3학점', '3학점', '3학점', '2학점', '1학점'];
              List<String> userGrade2_1 = ['A+', 'C+', 'B0', 'D', 'A+'];

              List<String> userSub2_2 = ['자료구조', '웹프로그래밍', '웹프로그래밍 실습', '컴퓨터구조', '소프트웨어공학론'];
              List<String> userCredit2_2 = ['3학점', '2학점', '1학점', '3학점', '3학점'];
              List<String> userGrade2_2 = ['A0', 'B+', 'C+', 'A+', 'B0'];

              List<String> userSub3_1 = ['소프트웨어설계PBL', '데이터베이스', '데이터베이스 실습', '데이터과학',
                '프로그래밍 언어론', '컴퓨터네트워크'];
              List<String> userCredit3_1 = ['3학점', '2학점', '1학점', '3학점', '3학점', '3학점'];
              List<String> userGrade3_1 = ['A+', 'A0', 'A+', 'B+', 'A0', 'A+'];

              List<String> userSub3_2 = ['인공지능', '빅데이터', '컴퓨터그래픽스', '운영체제', '알고리즘', '정보보안공학'];
              List<String> userCredit3_2 = ['3학점', '3학점', '3학점', '3학점', '3학점', '3학점'];
              List<String> userGrade3_2 = ['A0', 'A+', 'B+', 'A+', 'A0', 'A+'];

              List<String> userSub4_1 = ['종합설계PBL', '가상현실', '영상처리'];
              List<String> userCredit4_1 = ['3학점', '3학점', '3학점'];
              List<String> userGrade4_1 = ['A0', 'B+', 'B+'];

              List<String> userSub4_2 = ['사물인터넷', '기계학습', 'Java프로그래밍'];
              List<String> userCredit4_2 = ['3학점', '3학점', '2학점'];
              List<String> userGrade4_2 = ['A+', 'A+', 'A0'];

              if(value == '1학년 1학기'){

                color = Colors.grey;
                textValue = '이수학점 : 17           평점 : 3.5/4.5';

                currentSub = List.from(userSub1_1);
                currentCredit = List.from(userCredit1_1);
                currentGrade = List.from(userGrade1_1);

              } else if(value == '1학년 2학기'){

                color = Colors.grey;
                textValue = '이수학점 : 18           평점 : 3.2/4.5';

                currentSub = List.from(userSub1_2);
                currentCredit = List.from(userCredit1_2);
                currentGrade = List.from(userGrade1_2);

              } else if(value == '2학년 1학기'){

                color = Colors.grey;
                textValue = '이수학점 : 14           평점 : 4.3/4.5';

                currentSub = List.from(userSub2_1);
                currentCredit = List.from(userCredit2_1);
                currentGrade = List.from(userGrade2_1);

              } else if(value == '2학년 2학기'){

                color = Colors.grey;
                textValue = '이수학점 : 18           평점 : 3.65/4.5';

                currentSub = List.from(userSub2_2);
                currentCredit = List.from(userCredit2_2);
                currentGrade = List.from(userGrade2_2);

              } else if(value == '3학년 1학기'){
                color = Colors.grey;
                textValue = '이수학점 : 17           평점 : 3.7/4.5';

                currentSub = List.from(userSub3_1);
                currentCredit = List.from(userCredit3_1);
                currentGrade = List.from(userGrade3_1);

              } else if(value == '3학년 2학기'){
                color = Colors.grey;
                textValue = '이수학점 : 14           평점 : 3.1/4.5';

                currentSub = List.from(userSub3_2);
                currentCredit = List.from(userCredit3_2);
                currentGrade = List.from(userGrade3_2);

              } else if(value == '4학년 1학기'){

                color = Colors.grey;
                textValue = '이수학점 : 10           평점 : 3.75/4.5';

                currentSub = List.from(userSub4_1);
                currentCredit = List.from(userCredit4_1);
                currentGrade = List.from(userGrade4_1);

              } else if(value == '4학년 2학기'){

                color = Colors.grey;
                textValue = '이수학점 : 11           평점 : 3.4/4.5';

                currentSub = List.from(userSub4_2);
                currentCredit = List.from(userCredit4_2);
                currentGrade = List.from(userGrade4_2);

              }

              return Container(
                  height: 300,
                  color: color,
                  child: Center(
                      child: Column(
                        children: [
                          Text(
                              textValue,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          Container(
                            height: 230,  // Set the height according to your need
                            child: ListView(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          '과목',
                                          style: TextStyle(fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          '학점',
                                          style: TextStyle(fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          '성적',
                                          style: TextStyle(fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ],

                                    rows: List<DataRow>.generate(
                                      currentSub.length,
                                          (index) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(currentSub[index])),
                                          DataCell(Text(currentCredit[index])),
                                          DataCell(Text(currentGrade[index])),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  )
              );
            },
          ),
          // Add additional widgets as needed
        ],
      ),
    );
  }
}
