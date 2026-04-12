import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'features/auth/login_page.dart';
import 'features/auth/signup_page.dart';
import 'features/splash/splash_screen.dart';
import 'features/home/home_page.dart';

/// 🔥 WAJIB: background handler harus top-level + entry point
@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Background notif: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCQa8o5lQc8Izf1lPwxwcAkbI9Yt7Qwwro",
      authDomain: "marketplace-uts.firebaseapp.com",
      projectId: "marketplace-uts",
      storageBucket: "marketplace-uts.firebasestorage.app",
      messagingSenderId: "608464027335",
      appId: "1:608464027335:web:6b8f04fbb00fdbaeb9c8e2",
    ),
  );
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🔥 GANTI ke splash
      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
