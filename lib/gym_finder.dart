import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GymFinder extends StatefulWidget {
  final bool isAdmin;
  const GymFinder({super.key, required this.isAdmin});

  @override
  State<GymFinder> createState() => _GymFinderState();
}

class _GymFinderState extends State<GymFinder> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _servicesController = TextEditingController();
  final _descController = TextEditingController();

  void _addGym() async {
    await FirebaseFirestore.instance.collection('gyms').add({
      'name': _nameController.text,
      'location': _locationController.text,
      'price': _priceController.text,
      'services': _servicesController.text,
      'description': _descController.text,
    });
    _clearControllers();
  }

  void _updateGym(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Gym Info', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField(_nameController, 'Gym Name'),
                const SizedBox(height: 10),
                _buildInputField(_locationController, 'Location'),
                const SizedBox(height: 10),
                _buildInputField(_priceController, 'Price'),
                const SizedBox(height: 10),
                _buildInputField(_servicesController, 'Services'),
                const SizedBox(height: 10),
                _buildInputField(_descController, 'Description'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('gyms').doc(id).update({
                  'name': _nameController.text,
                  'location': _locationController.text,
                  'price': _priceController.text,
                  'services': _servicesController.text,
                  'description': _descController.text,
                });
                _clearControllers();
                Navigator.pop(context);
              },
              child: const Text('Update', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _deleteGym(String id) {
    FirebaseFirestore.instance.collection('gyms').doc(id).delete();
  }

  void _clearControllers() {
    _nameController.clear();
    _locationController.clear();
    _priceController.clear();
    _servicesController.clear();
    _descController.clear();
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputSection = Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buildInputField(_nameController, 'Gym Name'),
          const SizedBox(height: 10),
          _buildInputField(_locationController, 'Location'),
          const SizedBox(height: 10),
          _buildInputField(_priceController, 'Price'),
          const SizedBox(height: 10),
          _buildInputField(_servicesController, 'Services'),
          const SizedBox(height: 10),
          _buildInputField(_descController, 'Description'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addGym,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Add Gym', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Gyms'),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (widget.isAdmin) inputSection,
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('gyms').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          data['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Location: ${data['location'] ?? ''}, Price: ${data['price'] ?? ''}\n'
                              'Services: ${data['services'] ?? ''}\n${data['description'] ?? ''}',
                        ),
                        isThreeLine: true,
                        trailing: widget.isAdmin
                            ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                              onPressed: () {
                                _nameController.text = data['name'] ?? '';
                                _locationController.text = data['location'] ?? '';
                                _priceController.text = data['price'] ?? '';
                                _servicesController.text = data['services'] ?? '';
                                _descController.text = data['description'] ?? '';
                                _updateGym(data.id);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _deleteGym(data.id),
                            ),
                          ],
                        )
                            : null,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF9F9F9),
    );
  }
}
