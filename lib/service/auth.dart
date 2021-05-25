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
        ? UserDetails(uid: user.uid, name: user.displayName)
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
        // shop: ['shop1', 'shop2', 'shop3'],
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





  //google signin

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  String name;
  String email;
  String imageUrl;

  // Future<String> signInWithGoogle() async {
  //   // await Firebase.initializeApp();
  //   final GoogleSignInAccount gSAC = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication gSA = await gSAC.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: gSA.accessToken,
  //     idToken: gSA.idToken,
  //   );
  //   final UserCredential authResult =
  //       await _auth.signInWithCredential(credential);
  //   final User user = authResult.user;
  //   if (bool != null) {
  //     assert(user.email != null);
  //     assert(user.displayName != null);
  //     assert(user.photoURL != null);
  //     name = user.displayName;
  //     email = user.email;
  //     imageUrl = user.photoURL;
  //     if (name.contains(" ")) {
  //       name = name.substring(0, name.indexOf(" "));
  //     }
  //     assert(!user.isAnonymous);
  //     assert(await user.getIdToken() != null);
  //     final User currentUser = _auth.currentUser;
  //     assert(user.uid == currentUser.uid);
  //     print('sign in with google sucessed $user');
  //     return '$user';
  //   }
  //   return null;
  // }
}
