import 'package:flutter/material.dart';
import 'supplement_store.dart';
import 'equipment_store.dart';
import 'gym_finder.dart';
import 'admin_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _adminLogin(BuildContext context) {
    String email = '';
    String password = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Admin Login',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (val) => email = val,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (val) => password = val,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (AdminAuth.login(email, password)) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminHome(),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Access Denied')),
                  );
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(200, 48),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('GymMate Home'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: buttonStyle,
              child: const Text('Supplement Store'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SupplementStore(isAdmin: false),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: buttonStyle,
              child: const Text('Equipment Store'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EquipmentStore(isAdmin: false),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: buttonStyle,
              child: const Text('Find Gyms'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GymFinder(isAdmin: false),
                  ),
                );
              },
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              style: buttonStyle.copyWith(
                backgroundColor: MaterialStateProperty.all(Colors.white70),
              ),
              onPressed: () => _adminLogin(context),
              child: const Text('Login as Admin'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFFDFAFA),
    );
  }
}

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(220, 48),
      backgroundColor: Colors.deepPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: buttonStyle,
              child: const Text('Manage Supplements'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SupplementStore(isAdmin: true),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: buttonStyle,
              child: const Text('Manage Equipment'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EquipmentStore(isAdmin: true),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: buttonStyle,
              child: const Text('Manage Gyms'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const GymFinder(isAdmin: true),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
    );
  }
}
