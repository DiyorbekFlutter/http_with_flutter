import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void exampleApp() => runApp(const SpeechSampleApp());

class SpeechSampleApp extends StatefulWidget {
  const SpeechSampleApp({super.key});

  @override
  State<SpeechSampleApp> createState() => _SpeechSampleAppState();
}

class _SpeechSampleAppState extends State<SpeechSampleApp> {
  bool _hasSpeech = false;
  final bool _logEvents = false;
  final bool _onDevice = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastStatus = '';
  String _currentLocaleId = 'en_US';
  final SpeechToText speech = SpeechToText();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: _hasSpeech ? null : initSpeechState, child: const Text('Initialize')),
            Container(
              color: Theme.of(context).secondaryHeaderColor,
              child: Center(child: Text(lastWords, textAlign: TextAlign.center)),
            ),
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: .26,
                      spreadRadius: level * 1.5,
                      color: Colors.black.withOpacity(.05))
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: IconButton(
                icon: const Icon(Icons.mic),
                onPressed: startListening,
              ),
            )
          ]
        ),
      ),
    );
  }

  Future<void> initSpeechState() async {
    try {
      var hasSpeech = await speech.initialize(
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) _currentLocaleId = 'en_US';
      setState(() => _hasSpeech = hasSpeech);
    } catch (e) {
      setState(() => _hasSpeech = false);
    }
  }

  void startListening() {
    lastWords = '';
    final pauseFor = int.tryParse('3');
    final listenFor = int.tryParse('30');
    final options = SpeechListenOptions(
      onDevice: _onDevice,
      listenMode: ListenMode.confirmation,
      cancelOnError: true,
      partialResults: true,
      autoPunctuation: true,
      enableHapticFeedback: true
    );

    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      listenOptions: options,
    );
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) => setState(() => lastWords = '${result.recognizedWords} - ${result.finalResult}');
  void statusListener(String status) => setState(() => lastStatus = status);
  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() => this.level = level);
  }
}