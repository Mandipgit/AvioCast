import 'dart:convert';
import 'package:http/http.dart' as http;


class FlightAPI{
  static const String FlightbaseUrl= 'http://192.168.1.119:8000';
  static Future<Map<String, dynamic>> getflightData({
    required String origin,
    required String destination,
  }) async{
    final uri= Uri.parse('$FlightbaseUrl/flight/prediction?origin=$origin&destination=$destination');
    final response=await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load flight data');
    }

    return json.decode(response.body) as Map<String, dynamic>;
     
  }

}
