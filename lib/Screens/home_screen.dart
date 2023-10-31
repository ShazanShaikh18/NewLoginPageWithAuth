import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() async {
    if (FirebaseAuth.instance.currentUser != null) {
      LoginScreen.disconnectWithGoogle();
      await FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Logged In As: ",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Text(
            //   '${user.email}',
            //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            Text(
              user.email != null ? '${user.email}' : '${user.phoneNumber}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Text(
            //   '${user.phoneNumber}',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) async {
                    await GoogleSignIn().signOut().then((value) {
                      //FirebaseAuth.instance = FirebaseAuth.instance;
                      //Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    });
                    // Navigator.pop(context);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const LoginScreen(),
                    //     ));
                  });
                },
                label: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
