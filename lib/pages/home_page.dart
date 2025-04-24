import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/pages/profile_page.dart';
import 'package:social_media_app/services/auth_service.dart';
import 'package:social_media_app/services/firestore_service.dart';
import 'package:social_media_app/widgets/post_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: firestoreService.value.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot document = docs[index];
                final String docID = document.id;
                final PostModel post = PostModel(
                  email: document["email"],
                  username: document["username"],
                  content: document["content"],
                  timestamp: document["timestamp"],
                  likes: document["likes"],
                  whoLiked: document["whoLiked"],
                );
                return PostContainer(post: post, docID: docID);
              },
            );
          } else {
            return Center(child: Text("The feed is empty"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          openDialog();
        },
      ),
    );
  }

  void openDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: LinearBorder(),
            content: TextField(
              autofocus: true,
              controller: _controller,
              decoration: InputDecoration(hintText: "Your message to the feed"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    firestoreService.value.addPost(
                      PostModel(
                        email:
                            authService.value.currentUser!.email ??
                            "Error with email",
                        username:
                            authService.value.currentUser!.displayName ??
                            "Error with username",
                        content: _controller.text,
                        timestamp: Timestamp.now(),
                        likes: 0,
                        whoLiked: [],
                      ),
                    );
                    _controller.clear();
                  }
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
