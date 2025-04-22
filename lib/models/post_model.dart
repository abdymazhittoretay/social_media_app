import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String username;
  final String content;
  final Timestamp timestamp;
  final int likes;

  PostModel({
    required this.username,
    required this.content,
    required this.timestamp,
    required this.likes,
  });
}
