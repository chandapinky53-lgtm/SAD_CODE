import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String message = '';

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() => message = "Passwords do not match");
      return;
    }

    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() {
        message = "Registration successful! You can login now.";
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        message = e.message ?? 'Registration failed';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration:
                    const InputDecoration(labelText: "Confirm Password"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isLoading ? null : signUp,
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 10),
                  Text(message, style: const TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
