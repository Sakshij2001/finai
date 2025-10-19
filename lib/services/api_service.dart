import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_response_model.dart';

class ApiService {
  static const String baseUrl =
      'https://itefswc2wmg3csag2st23b3zfe0cddno.lambda-url.us-east-1.on.aws/';

  static Future<InstagramAnalysisResponse> analyzeInstagram(
    String username,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return InstagramAnalysisResponse.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to analyze Instagram: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }
}
