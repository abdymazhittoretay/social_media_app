import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Page"), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Icon(Icons.abc, size: 120.0),
              Text("Welcome to our app!", textAlign: TextAlign.center),
              Spacer(),
              ElevatedButton(onPressed: () {}, child: Text("Register")),
              SizedBox(height: 6.0),
              ElevatedButton(onPressed: () {}, child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}
