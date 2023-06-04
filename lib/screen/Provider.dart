import 'package:flutter/material.dart';
import 'package:grad_gg/screen/profile_screen.dart';

import 'package:grad_gg/screen/search_page//search_page.dart';

//import 'StatusPage.dart';
import 'mainscreen.dart';
//네비게이션 전환용 provider 다트파일
//메인스크린에 버튼을 눌렀을때 네비게이션 바를 누른 효과처럼 작동하게 해줌
class NavigationIndexProvider with ChangeNotifier {
  int _selectedIndex = 2;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}