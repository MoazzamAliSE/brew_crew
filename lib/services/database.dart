import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
// collection referrence

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugar': sugars, 'name': name, 'strength': strength});
  }

//get brews Stream
  Stream<List<Brew>?> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //brew list from snapshot
  List<Brew>? _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '0',
          strength: doc.get('strength') ?? 0);
    }).toList();
  }

  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Brew(
  //       name: doc.get('name') ?? '',
  //       strength: doc.get('strength') ?? 0,
  //       sugars: doc.get('sugars') ?? '0',
  //     );
  //   }).toList();
  // }
 //get user doc stream
  Stream<UserData?> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
  //User data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map docSnap = snapshot.data() as Map;
    return UserData(
        uid: docSnap['uid'],
        name: docSnap['name'],
        sugars: docSnap['sugars'],
        strength: docSnap['strength']);
  }

 
}
