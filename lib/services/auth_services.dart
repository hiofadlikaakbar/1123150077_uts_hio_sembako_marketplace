import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<String?> getFirebaseToken() async {
    return await FirebaseAuth.instance.currentUser?.getIdToken();
  }

  static Future<String> sendTokenToBackend(String firebaseToken) async {
    await Future.delayed(const Duration(seconds: 1));

    final user = FirebaseAuth.instance.currentUser;

    final header = {"alg": "HS256", "typ": "JWT"};

    final payload = {
      "uid": user?.uid,
      "email": user?.email,
      "iat": DateTime.now().millisecondsSinceEpoch,
      "exp": DateTime.now()
          .add(const Duration(hours: 1))
          .millisecondsSinceEpoch,
      "iss": "marketplace-app",
    };
