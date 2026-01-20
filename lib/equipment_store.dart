import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentStore extends StatefulWidget {
  final bool isAdmin;
  const EquipmentStore({super.key, required this.isAdmin});

  @override
  State<EquipmentStore> createState() => _EquipmentStoreState();
}

class _EquipmentStoreState extends State<EquipmentStore> {
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();

  void _addEquipment() async {
    await FirebaseFirestore.instance.collection('equipment').add({
      'name': _nameController.text,
      'weight': _weightController.text,
      'price': _priceController.text,
      'description': _descController.text,
    });
    _clearControllers();
  }

  void _updateEquipment(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Equipment', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField(_nameController, 'Name'),
                const SizedBox(height: 10),
                _buildInputField(_weightController, 'Weight'),
                const SizedBox(height: 10),
                _buildInputField(_priceController, 'Price'),
                const SizedBox(height: 10),
                _buildInputField(_descController, 'Description'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('equipment').doc(id).update({
                  'name': _nameController.text,
                  'weight': _weightController.text,
                  'price': _priceController.text,
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

  void _deleteEquipment(String id) {
    FirebaseFirestore.instance.collection('equipment').doc(id).delete();
  }

  void _clearControllers() {
    _nameController.clear();
    _weightController.clear();
    _priceController.clear();
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
          _buildInputField(_nameController, 'Name'),
          const SizedBox(height: 10),
          _buildInputField(_weightController, 'Weight'),
          const SizedBox(height: 10),
          _buildInputField(_priceController, 'Price'),
          const SizedBox(height: 10),
          _buildInputField(_descController, 'Description'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addEquipment,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Add Equipment', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Store'),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (widget.isAdmin) inputSection,
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('equipment').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
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
                          'Weight: ${data['weight'] ?? ''}, Price: ${data['price'] ?? ''}\n${data['description'] ?? ''}',
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
                                _weightController.text = data['weight'] ?? '';
                                _priceController.text = data['price'] ?? '';
                                _descController.text = data['description'] ?? '';
                                _updateEquipment(data.id);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _deleteEquipment(data.id),
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
