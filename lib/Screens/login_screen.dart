import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/apis.dart';
import 'package:flutter_app1/Screens/home_screen.dart';
import 'package:flutter_app1/Screens/register_user_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Phone/login_with_phone_number.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static void disconnectWithGoogle() {}
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));

      // pop the loading circle
      //Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // Show Error Message
      showErrorMessage(e.code);
    }
  }

  // wrong email message popup & wrong password message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

    // Google Authentication Code
  _handleGoogleButtonClick() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');

      // Sign in process which shows multiple accounts
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // Obtain auth details by request
      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;

      // New credential user
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);

      // Finally sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong (Check Internet!)')));
      return null;
    }
  }

  disconnectWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),

                  const FlutterLogo(
                      size: 150,
                      style: FlutterLogoStyle.stacked,
                      curve: Curves.bounceIn,
                      duration: Duration(seconds: 2)),

                  const SizedBox(height: 55),

                  // email textformfield
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: Brightness.dark,
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter Email',
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

                  // password textformfield
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter Password',
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility_sharp),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter correct password';
                      } else if (value.length < 6) {
                        return 'Password length must be atleast 6';
                      }
                      return null;
                    },
                    obscureText: _obscureText,
                  ),
                  const SizedBox(height: 20),

                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                backgroundColor: Colors.grey.shade200),
                          ))),
                  const SizedBox(height: 40),

                  // sign in button
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Processing...')),
                        // );
                      }
                      signUserIn();
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      )),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Row(children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black38,
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or continue with'),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.black38,
                    ))
                  ]),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _handleGoogleButtonClick();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.black12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/google.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 35),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LoginWithPhoneNumber(),
                              ));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.black12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/phone_call.png'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?  ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterUserScreen(),
                              ));
                        },
                        child: const Text('Register Now',
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
