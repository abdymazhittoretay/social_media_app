import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/pages/profile_page.dart';
import 'package:social_media_app/services/firestore_service.dart';

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
            final List<PostModel> posts =
                snapshot.data!.docs.map((doc) {
                  return PostModel(
                    email: doc["email"],
                    username: doc["username"],
                    content: doc["content"],
                    timestamp: doc["timestam"],
                    likes: doc["likes"],
                  );
                }).toList();
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(posts[index].content));
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
                  _controller.clear();
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
