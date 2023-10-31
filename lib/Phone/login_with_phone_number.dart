import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/Phone/verify_code.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _countryCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.asset('assets/images/img1.png')),
              const SizedBox(
                height: 50,
              ),
              IntlPhoneField(
                disableLengthCheck: true,
                controller: phoneNumberController,
                initialCountryCode: 'IN',
                decoration: const InputDecoration(
                    hintText: 'Enter Phone Number',
                    hintStyle: TextStyle(fontSize: 15),
                    labelText: 'Phone Number',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.completeNumber.isEmpty) {
                    return "Enter valid phone number";
                  }
                  return null;
                },
                onChanged: (value) {
                  countryCodeController.text = value.countryCode;
                },
              ),
              // TextFormField(
              //   controller: phoneNumberController,
              //   keyboardType: TextInputType.phone,
              //   decoration: const InputDecoration(hintText: '+1 234 567'),
              // ),
              const SizedBox(height: 40),
              // ElevatedButton(
              //     onPressed: () {
              //       setState(() {
              //         loading = true;
              //       });
              //       auth.verifyPhoneNumber(
              //           phoneNumber: phoneNumberController.text,
              //           verificationCompleted: (_) {
              //             setState(() {
              //               loading = false;
              //             });
              //           },
              //           verificationFailed: (e) {
              //             showDialog(
              //               context: context,
              //               builder: (context) {
              //                 setState(() {
              //                   loading = false;
              //                 });
              //                 return Text(e.toString());
              //               },
              //             );
              //           },
              //           codeSent: (String verificationId, int? token) {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => VerifyCodeScreen(
              //                       verificationId: verificationId),
              //                 ));
              //             setState(() {
              //               loading = false;
              //             });
              //           },
              //           codeAutoRetrievalTimeout: (e) {
              //             showDialog(
              //               context: context,
              //               builder: (context) {
              //                 setState(() {
              //                   loading = false;
              //                 });
              //                 return Text(e.toString());
              //               },
              //             );
              //           });
              //     },
              //     child: const Text('Login')),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Processing...')),
                    // );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    auth.verifyPhoneNumber(
                        phoneNumber: countryCodeController.text +
                            phoneNumberController.text,
                        verificationCompleted: (_) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                        verificationFailed: (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(title: Text(e.toString()));
                            },
                          );
                        },
                        codeSent: (String verificationId, int? token) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                    verificationId: verificationId),
                              ));
                        },
                        codeAutoRetrievalTimeout: (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(title: Text(e.toString()));
                            },
                          );
                        });
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                      child: Text(
                    'Confirm Number',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
