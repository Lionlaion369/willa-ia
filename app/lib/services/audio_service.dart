import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  final stt.SpeechToText speech = stt.SpeechToText();
  final FlutterTts tts = FlutterTts();

  Future<String?> listen() async {
    bool available = await speech.initialize();
    if (!available) return null;

    await speech.listen();
    await Future.delayed(const Duration(seconds: 5));
    await speech.stop();

    return speech.lastRecognizedWords;
  }

  Future<void> speak(String text) async {
    await tts.speak(text);
  }
}
