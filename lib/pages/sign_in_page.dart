import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In Page"), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Your email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Your password",
                    border: OutlineInputBorder(),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    signIn(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  },
                  child: Text("Sign In"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await authService.value.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
    } else {
      print("One of the fields is empty");
    }
  }
}
