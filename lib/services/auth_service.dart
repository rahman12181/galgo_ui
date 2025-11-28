import 'package:http/http.dart' as http;
import 'dart:convert';
class AuthService {
  static const String baseUrl = "http://10.0.2.2:8080";

  Future<Map<String, dynamic>> signupUser({
    required String username,
    required String email,
    required String password,
    
  })async{
    final url=Uri.parse("$baseUrl/api/auth/signup");

    final response=await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username":username,
        "email": email,
        "password": password,
      })
    );
    return jsonDecode(response.body);
  }
}