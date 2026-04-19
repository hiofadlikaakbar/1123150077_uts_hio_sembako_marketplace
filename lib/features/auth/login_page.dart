import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../services/auth_services.dart';

Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  Future<void> loginEmail() async {
    setState(() => isLoading = true);

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = credential.user;

      if (user != null) {
        await user.reload();

        if (!user.emailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email belum diverifikasi!")),
          );
          setState(() => isLoading = false);
          return;
        }

        final firebaseToken = await AuthService.getFirebaseToken();

        if (firebaseToken != null) {
          final jwt = await AuthService.sendTokenToBackend(firebaseToken);
          await AuthService.saveJWT(jwt);

          print("JWT: $jwt");
        }

        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      print("LOGIN ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login gagal: $e")));
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "images/logo-marketplace.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Selamat datang kembali",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Masukkan email",
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Masukkan password",
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : loginEmail,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final user = await signInWithGoogle();

                      if (user != null) {
                        Navigator.pushReplacementNamed(context, '/home');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Google berhasil"),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Google dibatalkan"),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Login dengan Google"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .redAccent, // opsional biar beda dari login biasa
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum ada akun? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "Gas dulu Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
