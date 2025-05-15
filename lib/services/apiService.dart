import 'dart:convert';
import 'package:http/http.dart' as http;

String baseUrl = 'https://nav-backend-nqo0.onrender.com';

Future<bool> getBackendStatusAPI() async {
  try {
    var url = Uri.parse('$baseUrl/navapi');
    final response = await http.get(url);

    return true;
  } catch (e) {
    return false;
  }
}

Future<List<dynamic>> fetchDirection(
  String currentPosition,
  String finalPosition,
) async {
  final apiUrl = '$baseUrl/navapi';
  final Map<String, String> requestData = {
    'start': currentPosition,
    'goal': finalPosition,
  };

  final response = await http.post(Uri.parse(apiUrl),
      body: json.encode(requestData),
      headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // List<dynamic> path = data['Path'];
    List<dynamic> instructions = data['Instructions'] ?? [
      {"instruction": "Incorrect input", "distance": "unknown"}
    ];
    return instructions;
  } else {
    // throw Exception('Failed to fetch direction');
    return [
      ["The input is incorrect", "Please try again"]
    ];
  }
}
