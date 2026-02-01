import 'dart:convert';
import 'package:http/http.dart' as http;


class FlightAPI{
  static const String FlightbaseUrl= 'http://192.168.1.119:800';
  static Future<Map<String, dynamic>> getflightData({
    required String origin,
    required String destination,
  }) async{
    final uri= Uri.parse('$FlightbaseUrl/flight/prediction');
    final response=await http.get(uri);

    if(response.statusCode==200){
      final decoded=json.decode(response.body) as Map<String,dynamic>;
      }
     final Map<String, dynamic> decoded =
        json.decode(response.body) as Map<String, dynamic>;

    return decoded;
     
  }

}
