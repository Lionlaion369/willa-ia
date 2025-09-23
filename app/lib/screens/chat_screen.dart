import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Willa IA")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatService.messages.length,
              itemBuilder: (context, index) {
                final msg = chatService.messages[index];
                return ListTile(
                  title: Text(msg['text'] ?? ''),
                  subtitle: Text(msg['role']),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Fale com a Willa...",
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  chatService.sendMessage(_controller.text);
                  _controller.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
