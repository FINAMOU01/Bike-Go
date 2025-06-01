import 'package:flutter/material.dart';
import 'api_service.dart'; 
import 'add_user_screen.dart';
import 'map_screen.dart'; 

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  ApiService apiService = ApiService();
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      final response = await apiService.fetchUsers();
      users = response.map((user) => user.values.first).toList();
      print(users); // Affiche les utilisateurs dans la console
    } catch (e) {
      print('Erreur: $e'); // Affiche les erreurs éventuelles
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Utilisateurs'),
      ),
      body: users.isNotEmpty
          ? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index]['name']),
                  subtitle: Text('Age: ${users[index]['age']}'),
                );
              },
            )
          : Center(child: Text('Aucun utilisateur trouvé.')),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserScreen()),
              );
            },
            child: Icon(Icons.add), // Icône du bouton pour ajouter un utilisateur
          ),
          SizedBox(height: 10), // Espacement entre les boutons
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapScreen()), // Navigue vers l'écran de la carte
              );
            },
            child: Icon(Icons.map), // Icône du bouton pour afficher la carte
          ),
        ],
      ),
    );
  }
}