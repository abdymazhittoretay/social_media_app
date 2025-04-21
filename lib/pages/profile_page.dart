import 'package:flutter/material.dart';
import 'package:social_media_app/pages/update_username_page.dart';
import 'package:social_media_app/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page"), centerTitle: true),
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
                Icon(Icons.person, size: 120.0),
                Text(authService.value.currentUser!.displayName ?? ""),
                SizedBox(height: 6.0),
                Text(authService.value.currentUser!.email ?? ""),
                Spacer(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Update username"),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateUsernamePage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                  ),
                  onPressed: () async {
                    await authService.value.signOut();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: Text("Sign Out"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
