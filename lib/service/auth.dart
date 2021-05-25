import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vizilog/pages/models/user_details.dart';
import 'package:vizilog/service/database.dart';
import 'package:vizilog/service/error_handling/auth_exception_handler.dart';
import 'package:vizilog/service/error_handling/auth_result_status.dart';

class AuthService {
  String errorSignIn = "";
  String errorSignUp = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthResultStatus _status;
  UserDetails _userFromFirebase(User user) {
    return user != null
        ? UserDetails(uid: user.uid, name: user.displayName,imageURL: user.photoURL)
        : null;
  }

  Stream<UserDetails> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon() async {
    UserCredential userCredential = await _auth.signInAnonymously();
    User user = userCredential.user;
    return _userFromFirebase(user);
  }

  Future signOut() async {
    try {
      print("signout");
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerEmailAndPassword(
      {String email,
      String password,
      String address,
      String pincode,
      bool vaccinationStatus,
      String name}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      await userCredential.user.updateProfile(displayName: name);
      await user.reload();
      await DatabaseService(uid: user.uid).updateUserData(
        name: name,
        address: address,
        email: email,
        pincode: pincode,
        vaccinationStatus: vaccinationStatus,
        
      );
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        errorSignUp = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        errorSignUp = "The account already exists for that email";
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        errorSignUp = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        errorSignUp = "The account already exists for that email";
      }
      _status = AuthExceptionHandler.handleException(e);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //google sigin
    Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}






}
