import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBnFPJdN7JEDM7XzryjAsLmch50Qs4XGdQ",
        authDomain: "gym-mate-dd40f.firebaseapp.com",
        projectId: "gym-mate-dd40f",
        storageBucket: "gym-mate-dd40f.firebasestorage.app",
        messagingSenderId: "749816893354",
        appId: "1:749816893354:web:73bfce347c5d31d51425d3",
        measurementId: "G-BE5RRJFL9G",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GymMate',
      home: SignInPage(),
    );
  }
}
