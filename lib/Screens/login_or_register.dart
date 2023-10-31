import 'package:flutter/material.dart';
import 'package:flutter_app1/Screens/login_screen.dart';
import 'package:flutter_app1/Screens/register_user_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
bool showLoginPage = true;

void togglePage() {
  setState(() {
    showLoginPage =! showLoginPage;
  });
}

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(onTap: togglePage);
    }
    else {
      return RegisterUserScreen(onTap: togglePage);
    }
  }
}