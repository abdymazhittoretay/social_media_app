import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

final ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  User? get currentUser => _instance.currentUser;

  Stream<User?> get authState => _instance.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
