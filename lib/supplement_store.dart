import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupplementStore extends StatefulWidget {
  final bool isAdmin;
  const SupplementStore({super.key, required this.isAdmin});

  @override
  State<SupplementStore> createState() => _SupplementStoreState();
}

class _SupplementStoreState extends State<SupplementStore> {
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _priceController = TextEditingController();
  final _ingredientController = TextEditingController();
  final _searchController = TextEditingController();

  String _searchQuery = '';

  void _addSupplement() async {
    await FirebaseFirestore.instance.collection('supplements').add({
      'name': _nameController.text,
      'weight': _weightController.text,
      'price': _priceController.text,
      'ingredients': _ingredientController.text,
    });
    _clearInputs();
  }

  void _updateSupplement(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Supplement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
                TextField(controller: _weightController, decoration: const InputDecoration(labelText: 'Weight')),
                TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price')),
                TextField(controller: _ingredientController, decoration: const InputDecoration(labelText: 'Ingredients')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('supplements').doc(id).update({
                  'name': _nameController.text,
                  'weight': _weightController.text,
                  'price': _priceController.text,
                  'ingredients': _ingredientController.text,
                });
                _clearInputs();
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSupplement(String id) {
    FirebaseFirestore.instance.collection('supplements').doc(id).delete();
  }

  void _clearInputs() {
    _nameController.clear();
    _weightController.clear();
    _priceController.clear();
    _ingredientController.clear();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _weightController.dispose();
    _priceController.dispose();
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supplement Store')),
      body: Column(
        children: [
          if (widget.isAdmin)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
                TextField(controller: _weightController, decoration: const InputDecoration(labelText: 'Weight')),
                TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price')),
                TextField(controller: _ingredientController, decoration: const InputDecoration(labelText: 'Ingredients')),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: _addSupplement, child: const Text('Add Supplement')),
              ]),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Supplement',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('supplements').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final docs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final name = data['name']?.toString().toLowerCase() ?? '';
                  return name.contains(_searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(data['name'] ?? 'No Name', style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          'Weight: ${data['weight'] ?? 'N/A'}\nPrice: ${data['price'] ?? 'N/A'}\nIngredients: ${data['ingredients'] ?? 'N/A'}',
                        ),
                        isThreeLine: true,
                        trailing: widget.isAdmin
                            ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                _nameController.text = data['name'] ?? '';
                                _weightController.text = data['weight'] ?? '';
                                _priceController.text = data['price'] ?? '';
                                _ingredientController.text = data['ingredients'] ?? '';
                                _updateSupplement(doc.id);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteSupplement(doc.id),
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
    );
  }
}
