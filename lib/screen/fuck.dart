import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

getUserUid() {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  } catch (e) {
    print("Error getting user UID: $e");
    return null;
  }
}

getdoc() async {
  late String docid;
  String userUid = getUserUid();
  final query =
      await db.collection("학생").where("uuid", isEqualTo: userUid).get();
  docid = query.docs.first.id;
  return docid.toString();
}

List<String> currentSub = [];
List<String> currentCredit = [];
List<List<String>> subjectGrades = [[]];

Future<List<List<String>>> printUserFavorite(String targetKey) async {
  try {
    String? userId = 'F28OjwaI4eOgU4J8vuUNofcrYsH3';

    DocumentSnapshot userSnapshot =
    await FirebaseFirestore.instance.collection('학생').doc(userId).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
      userSnapshot.data() as Map<String, dynamic>;

      if (userData.containsKey('favorite') && userData['favorite'] is Map) {
        Map<String, dynamic> favoriteData =
        userData['favorite'] as Map<String, dynamic>;

        if (favoriteData.containsKey(targetKey) &&
            favoriteData[targetKey] is Map) {
          Map<String, dynamic> innerFavoriteData =
          favoriteData[targetKey] as Map<String, dynamic>;

          currentSub = [];
          currentCredit = [];

          innerFavoriteData.forEach((key, value) {
            if (value is Map) {
              currentSub.add(value['교과목명']);
              currentCredit.add(value['학점']);
            }
          });

          return [currentSub, currentCredit];
        } else {
          print('Target key data not found.');
        }
      } else {
        print('User favorite data not found.');
      }
    } else {
      print('User document not found.');
    }
  } catch (e) {
    print('Error retrieving user favorite: $e');
  }

  return [[], []]; // 기본적으로 빈 리스트를 반환
}