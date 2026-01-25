import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.1.119:8000';//PC IP
  // Use 127.0.0.1 ONLY for web
  // 10.0.2.2 = Android emulator
  // Use your PC IP for real device
static Future<List<dynamic>> getAirports() async {
  final uri = Uri.parse('$baseUrl/airports');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data['airports'] as List<dynamic>; // <- correct
  } else {
    throw Exception('Failed to load airports');
  }
}



}