import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String apiKey = dotenv.env['API_KEY'] ?? 'sh-';
String baseUrl = dotenv.env['BASE_URL'] ?? 'https://api.openai.com';

class AiSpeechClient {
  final http.Client _client;

  AiSpeechClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> convertTextToSpeech({
    // required String apiKey,
    required String text,
    String? model = 'tts-1',
    String? voice = 'alloy',
  }) async {
    final uri = Uri.parse('$baseUrl/v1/audio/speech');

    final response = await _client.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiKey',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode({
        'input': text,
        'model': model,
        'voice': voice,
      }),
    );

    if (response.statusCode == 200) {
      var audioBytes = response.bodyBytes;
      return {'audioBytes': audioBytes};
    } else {
      return {"error": 'Failed to convert text to speech: ${response.body}'};
    }
  }
}
