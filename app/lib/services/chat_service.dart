import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatService extends ChangeNotifier {
  final List<Map<String, String>> messages = [];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    messages.add({'role': 'user', 'text': text});
    notifyListeners();

    final response = await http.post(
      Uri.parse("http://localhost:3000/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      messages.add({'role': 'assistant', 'text': data['reply']});
      notifyListeners();
    }
  }
}
