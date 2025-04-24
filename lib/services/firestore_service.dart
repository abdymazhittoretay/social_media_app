import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/services/auth_service.dart';

final ValueNotifier<FirestoreService> firestoreService = ValueNotifier(
  FirestoreService(),
);

class FirestoreService {
  final CollectionReference _posts = FirebaseFirestore.instance.collection(
    "posts",
  );

  Future<void> addPost(PostModel post) {
    return _posts.add({
      "email": post.email,
      "username": post.username,
      "content": post.content,
      "likes": post.likes,
      "timestamp": post.timestamp,
      "whoLiked": post.whoLiked,
    });
  }

  Stream<QuerySnapshot> getPosts() {
    final postsSnapshot =
        _posts.orderBy("timestamp", descending: true).snapshots();
    return postsSnapshot;
  }

  Future<void> addLike(String docID) async {
    await _posts.doc(docID).update({
      "likes": FieldValue.increment(1),
      "whoLiked": FieldValue.arrayUnion([authService.value.currentUser!.email]),
    });
  }

  Future<void> removeLike(String docID) async {
    await _posts.doc(docID).update({
      "likes": FieldValue.increment(-1),
      "whoLiked": FieldValue.arrayRemove([
        authService.value.currentUser!.email,
      ]),
    });
  }
}
