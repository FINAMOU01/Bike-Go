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
 Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.56.1:5000/users/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> body = json.decode(response.body);
    return {
      'success': true,
      'user_id': body['user_id'],
      'message': body['message'] ?? 'Login successful',
    };
  } else {
    try {
      final Map<String, dynamic> error = json.decode(response.body);
      return {
        'success': false,
        'message': error['message'] ?? 'Login failed',
      };
    } catch (_) {
      return {
        'success': false,
        'message': 'Erreur lors de la connexion',
      };
    }
  }
}

  
}
