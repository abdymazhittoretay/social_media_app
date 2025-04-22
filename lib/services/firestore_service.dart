import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_app/models/post_model.dart';

final ValueNotifier<FirestoreService> authService = ValueNotifier(
  FirestoreService(),
);

class FirestoreService {
  final CollectionReference _posts = FirebaseFirestore.instance.collection(
    "posts",
  );

  Future<void> addPost(PostModel post) {
    return _posts.add({
      "username": post.username,
      "content": post.content,
      "likes": post.likes,
      "timestamp": post.timestamp,
    });
  }
}
