import 'package:flutter/material.dart';
import 'api_service.dart'; // Assure-toi d'importer ton service API

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  void addUser() async {
    String name = nameController.text;
    int age = int.tryParse(ageController.text) ?? 0;

    if (name.isNotEmpty && age > 0) {
      await apiService.addUser(name, age);
      Navigator.pop(context); // Retourne à l'écran précédent après l'ajout
    } else {
      // Afficher un message d'erreur si les champs sont invalides
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Veuillez entrer des informations valides.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Âge'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addUser,
              child: Text('Ajouter Utilisateur'),
            ),
          ],
        ),
      ),
    );
  }
}