import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

final ValueNotifier<FirestoreService> authService = ValueNotifier(
  FirestoreService(),
);

class FirestoreService {
  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    "collection",
  );
}
