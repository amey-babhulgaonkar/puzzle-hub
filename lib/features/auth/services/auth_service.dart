import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Initialize Google Sign-In
    await _googleSignIn.initialize(
  serverClientId:
      '604518073928-aiursns3gsp22q4fevpt7vseev7utndm.apps.googleusercontent.com',
);

    // Show Google account picker
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    // Get authentication details
    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    // Create Firebase credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Sign in with Firebase
    return await _auth.signInWithCredential(credential);
  }

  Future<UserCredential> signInAsGuest() async {
    return await _auth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}