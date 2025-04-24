import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/pages/profile_page.dart';
import 'package:social_media_app/services/auth_service.dart';
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
                return Container(
                  margin: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    bottom: 12.0,
                  ),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person, color: Colors.white),
                              SizedBox(width: 6.0),
                              Text(
                                post.username,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          post.content,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (post.whoLiked.contains(
                                  authService.value.currentUser!.email,
                                )) {
                                  firestoreService.value.removeLike(docID);
                                } else {
                                  firestoreService.value.addLike(docID);
                                }
                              },
                              icon: Icon(
                                post.whoLiked.contains(
                                      authService.value.currentUser!.email,
                                    )
                                    ? Icons.favorite
                                    : Icons.favorite_border,

                                color: Colors.white,
                              ),
                            ),
                            Text(
                              post.likes.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
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
