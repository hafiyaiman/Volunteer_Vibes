import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Create a new GoogleSignIn instance
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId:
            '105139890148-049gb12qrl6n39ah79t2r6n3tae9u2bs.apps.googleusercontent.com',
      );

      // Begin interaction sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Check if the user canceled the sign-in process
      if (googleUser == null) {
        return null;
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credentials for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Finally, let's sign in
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Save user details to Firestore
      await updateUserData(userCredential.user);

      return userCredential;
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  Future<void> updateUserData(User? user) async {
    if (user != null) {
      try {
        final CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        DocumentSnapshot userSnapshot = await users.doc(user.uid).get();

        if (!userSnapshot.exists) {
          await users.doc(user.uid).set({
            'name': user.displayName,
            'email': user.email,
          });
        }
      } catch (error) {
        print("Error updating user data: $error");
      }
    }
  }
}
