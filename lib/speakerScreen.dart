import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeakerScreen extends StatefulWidget {

  final String text;

  SpeakerScreen({this.text});

  @override
  _SpeakerScreenState createState() => _SpeakerScreenState();
}

class _SpeakerScreenState extends State<SpeakerScreen> {

  FlutterTts flutterTts = FlutterTts();

  Future _speak() async{
      await flutterTts.setLanguage("fr-FR");
      await flutterTts.setPitch(1.0);
      await flutterTts.setVolume(1.0);
      await flutterTts.setSpeechRate(1.0);
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.speak(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          // ignore: deprecated_member_use
          child: IconButton(
            icon: Icon(Icons.mic_rounded),
            onPressed: () =>{
              _speak()
            },
          ),
      ),
    );
  }
}
