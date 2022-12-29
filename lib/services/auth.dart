import 'package:easy2cook/models/user.dart';
import 'package:easy2cook/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The classes have been renamed.
//'AuthResult' has been renamed to 'UserCredential'
//and
//'FirebaseUser' is renamed to 'User'.

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User obj based on FirebaseUser (User)
  FUser? _userFromFirebaseUser(User? user) {
    if (user == null) {
      return null;
    }
    return FUser(uid: user.uid);
    //return user != null ? FUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<FUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // signin anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signin email + pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register email + pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // if user succesfully created create new database record with the uid
      await DatabaseService(uid: user!.uid).updateUserData([]);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
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
