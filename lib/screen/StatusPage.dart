import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:grad_gg/screen/profile_screen.dart';
import 'fuck.dart';


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

class MyStatusPage extends StatefulWidget {
  MyStatusPage({Key? key}) : super(key: key);

  @override
  _MyStatusPageState createState() => _MyStatusPageState();
}

class _MyStatusPageState extends State<MyStatusPage> {


  List<String> currentSub = [];
  List<String> currentCredit = [];
  List<List<String>> subjectGrades = [[]];

  void someFunction(String str) async {
    List<List<String>> result = await printUserFavorite(str);

    setState(() {
      currentSub = result[0];
      currentCredit = result[1];
    });
  }

  List<String> currentGrade = [];

  @override
  void initState() {
    super.initState();
  }


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
                      text: 'Grad.gg\n',
                      style: TextStyle(
                          letterSpacing: 2.0, //글자 자간설정
                          fontSize: 60.0, //폰트크기설정
                          fontWeight: FontWeight.w600, //두께설정
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

            ValueListenableBuilder<String>(
              valueListenable: selectedSeasonNotifier,
              builder: (BuildContext context, String value, Widget? child) {

                String textValue = "";
                List<String> usergrade = ['a', 'b'];


                Color color = Colors.white;

                if (value == '1학년 1학기') {
                  color = Colors.white;
                  textValue = '이수학점 : 17           평점 : 3.5/4.5';

                  someFunction('1-1');
                  currentGrade = List.from(usergrade);

                } else if (value == '1학년 2학기') {
                  color = Colors.white;
                  textValue = '이수학점 : 18           평점 : 3.2/4.5';

                  someFunction('1-2');


                } else if (value == '2학년 1학기') {
                  color = Colors.white;
                  textValue = '이수학점 : 14           평점 : 4.3/4.5';


                  someFunction('2-1');


                } else if (value == '2학년 2학기') {
                  color = Colors.white;
                  textValue = '이수학점 : 18           평점 : 3.65/4.5';


                  someFunction('2-2');



                } else if (value == '3학년 1학기') {
                  color = Colors.white;
                  textValue = '이수학점 : 17           평점 : 3.7/4.5';


                  someFunction('3-1');


                } else if (value == '3학년 2학기') {
                  color = Colors.white;
                  textValue = '이수학점 : 14           평점 : 3.1/4.5';


                  someFunction('3-2');



                } else if (value == '4학년 1학기') {
                  color = Colors.white;
                  textValue = '이수학점 : 10           평점 : 3.75/4.5';


                  someFunction('4-1');



                } else if (value == '4학년 2학기') {
                  color = Colors.white;
                  textValue = '이수학점 : 11           평점 : 3.4/4.5';


                  someFunction('4-2');


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
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text(
                                  '과목',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  '학점',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  '성적',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              currentSub.length,
                                  (index) =>
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(currentSub[index])),
                                      DataCell(Text(currentCredit[index])),
                                      DataCell(Text(currentGrade[index])),
                                    ],
                                  ),
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ]
      ),
    );
}}
