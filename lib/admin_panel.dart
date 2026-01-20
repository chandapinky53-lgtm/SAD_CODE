import 'package:flutter/material.dart';
import 'supplement_store.dart';
import 'equipment_store.dart';
import 'gym_finder.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 60),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      foregroundColor: Colors.black87,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Manage Sections',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
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
      backgroundColor: const Color(0xFF109292),
    );
  }
}
