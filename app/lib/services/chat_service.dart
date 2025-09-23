import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String serverUrl; // ex: https://willa-server.herokuapp.com
  final String serverToken; // SERVER_API_TOKEN

  ChatService({required this.serverUrl, required this.serverToken});

  Future<String> sendMessage(List<Map<String, String>> messages) async {
    final resp = await http.post(
      Uri.parse('$serverUrl/v1/chat'),
      headers: {
        'Content-Type': 'application/json',
        'x-server-token': serverToken
      },
      body: jsonEncode({
        'messages': messages,
        'model': 'gpt-4o-mini'
      }),
    );
    if (resp.statusCode != 200) {
      throw Exception('Server error: ${resp.body}');
    }
    final json = jsonDecode(resp.body);
    // adapt depending on OpenAI response structure
    return json['choices'][0]['message']['content'] ?? '';
  }
}
