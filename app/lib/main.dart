import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/chat_screen.dart';
import 'services/chat_service.dart';

void main() {
  runApp(const WillaApp());
}

class WillaApp extends StatelessWidget {
  const WillaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Willa IA',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const ChatScreen(),
      ),
    );
  }
}
