// lib/main.dart

import 'package:flutter/material.dart';
import 'injection.dart' as di; // import file injection.dart dengan alias 'di'
import 'app/presentation/pages/home_page.dart';
import 'package:get/get.dart';

void main() async { // Ubah menjadi async
  // Pastikan semua binding framework siap sebelum menjalankan kode lain
  WidgetsFlutterBinding.ensureInitialized(); 

  // Panggil fungsi init() kita untuk mendaftarkan semua dependency
  di.init(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MovieX',
      theme: ThemeData(
        brightness: Brightness.dark, // Tema gelap agar lebih sinematik
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, 
      home: const HomePage(), 
    );
  }
}