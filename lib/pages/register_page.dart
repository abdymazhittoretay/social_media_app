import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Page"), centerTitle: true),
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
                SizedBox(height: 12.0),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    border: OutlineInputBorder(),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.maxFinite, 50),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                  ),
                  onPressed: () {
                    register(
                      email: _emailController.text,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text,
                    );
                  },
                  child: Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        try {
          await authService.value.registerUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        } on FirebaseAuthException catch (e) {
          print(e.message);
        }
      }
    } else {
      print("One of the fields is empty");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
