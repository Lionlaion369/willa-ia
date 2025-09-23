import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String,String>> messages = []; // {role,content}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Willa')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: messages.map((m) => ListTile(
                title: Text(m['role'] == 'user' ? 'Você' : 'Willa'),
                subtitle: Text(m['content'] ?? ''),
              )).toList(),
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.mic), onPressed: (){/*start STT*/}),
                Expanded(child: TextField(controller: _controller)),
                IconButton(icon: Icon(Icons.send), onPressed: (){/*send*/}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
