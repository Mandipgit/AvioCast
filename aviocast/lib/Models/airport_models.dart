import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'http://192.168.1.119:8000';//PC IP
  // Use 127.0.0.1 ONLY for web
  // 10.0.2.2 = Android emulator
  // Use your PC IP for real device
static Future<List<Map<String, dynamic>>> getAirports() async {
  final uri = Uri.parse('$baseUrl/airports');
  final response = await http.get(uri);

  print("STATUS: ${response.statusCode}");
  print("BODY: ${response.body}");

  if (response.statusCode == 200) {
    final decoded = json.decode(response.body);

    final Map<String, dynamic> airportsMap = decoded['airports'];

    // Convert Map → List
    final List<Map<String, dynamic>> airportsList =
        airportsMap.values.map<Map<String, dynamic>>((e) {
      return Map<String, dynamic>.from(e);
    }).toList();

    return airportsList;
  } else {
    throw Exception('Failed to load airports');
  }
}




}