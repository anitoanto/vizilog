import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();
String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount gSAC = await googleSignIn.signIn();
  final GoogleSignInAuthentication gSA = await gSAC.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: gSA.accessToken,
    idToken: gSA.idToken,
  );
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  if (user != null) {
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    print('sign in with google sucessed $user');
    return '$user';
  }
  return null;
}
