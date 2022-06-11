import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FirebaseUser

  Users? _userFromFirebase(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Users(uid: user.uid) : null;
  }

  // create user obj based on FirebaseUser
  Stream<Users?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
    // .map(_userFromFirebase);
  }
  // Stream<Users> get user {
  //   return _auth.authStateChanges().map((
  //     firebaseUser,
  //   ) {
  //     return firebaseUser == null ? Users.empty : Users.toUser;
  //   });
  // }

  //sign in anon
  Future signInAnon() async {
    try {
      // AuthResult result = await _auth.signInAnonymously();
      // FirebaseUser user = result.user;

      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user; // changed

      return _userFromFirebase(user!);

      // return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email& password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      e.toString();
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //creating a new document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'brew crew member', 100);
      return _userFromFirebase(user);
    } catch (e) {
      e.toString();
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

// class FirebaseUser {
// }

// class AuthResult {
// }


//54F87E59-444A-42A6-A2D5-484B8693C375 sdk log 