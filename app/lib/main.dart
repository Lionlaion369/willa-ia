import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const WillaApp());
}

class WillaApp extends StatelessWidget {
  const WillaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Willa Assistant',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ChatScreen(),
    );
  }
}
