import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/app/presentation/pages/home_page.dart';
import '/app/presentation/pages/login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Saat sedang mengecek status auth
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // Jika user sudah login (ada data user)
        if (snapshot.hasData) {
          return const HomePage();
        }

        // Jika user belum login
        return LoginPage();
      },
    );
  }
}