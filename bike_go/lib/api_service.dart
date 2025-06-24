import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://192.168.56.1:5000/users';  // Remplace par l'URL de ton API

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    return json.decode(response.body);
  }

  Future<void> addUser(String name, int age) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'age': age}),
    );
  }

  
}