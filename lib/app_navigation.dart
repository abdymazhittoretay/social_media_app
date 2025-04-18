import 'package:flutter/material.dart';
import 'package:social_media_app/pages/home_page.dart';
import 'package:social_media_app/pages/welcome_page.dart';
import 'package:social_media_app/services/auth_service.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, value, child) {
        return StreamBuilder(
          stream: value.authState,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return WelcomePage();
            }
          },
        );
      },
    );
  }
}
