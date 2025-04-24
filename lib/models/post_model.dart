import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String email;
  final String username;
  final String content;
  final Timestamp timestamp;
  final int likes;
  final List<dynamic> whoLiked;

  PostModel({
    required this.email,
    required this.username,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.whoLiked,
  });
}
