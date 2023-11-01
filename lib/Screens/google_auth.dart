// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class GoogleAuth {
//   // Google sign in
//   signInWithGoogle() async {

//      // Sign in process which shows multiple accounts
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     // Obtain auth details by request
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;

//     // New credential user
//     final credential = GoogleAuthProvider.credential(accessToken: gAuth.accessToken, idToken: gAuth.idToken);

//     // Finally sign in
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   // Google disconnect
//   disconnectWithGoogle() async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     await googleSignIn.disconnect();
//     await FirebaseAuth.instance.signOut();
//   }
// }
