import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/get_api_screen.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Home Screen'),
      ),
      backgroundColor: Colors.teal.shade100,
      drawer: Drawer(
        child: DrawerHeader(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user.displayName != null
                    ? '${user.displayName}'
                    : '${user.phoneNumber}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                user.email != null ? '${user.email}' : '${user.phoneNumber}',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL.toString()),
              ),
              currentAccountPictureSize: Size.fromRadius(35),
            ),
            Divider(thickness: 1, color: Colors.black),
            ListTile(
              leading: TextButton.icon(
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
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        )),
      ),
      body: GetApiScreen(),
    );
  }
}
