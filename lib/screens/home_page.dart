import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:frontend/services/apiService.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:graphview/GraphView.dart'; // Import the graphview package

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  final TextEditingController currentController = TextEditingController();
  final TextEditingController finalController = TextEditingController();

  List<dynamic> directions = [];
  int directionIndex = 0; // Index to keep track of the current direction

  bool isListening = false;
  String currentPosition = "";
  String finalPosition = "";

  @override
  void initState() {
    super.initState();
    _speakPrompt();
  }

  Future<void> _speakPrompt() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.6);

    String textToSpeak =
        "Hello, Welcome to SVNIT Campus. Where are you currently?";

    await flutterTts.speak(textToSpeak);
    await Future.delayed(const Duration(seconds: 5));
    print("Listening for current position...");
    await _startListeningCurrent();
    print("Current: $currentPosition");
    await Future.delayed(const Duration(seconds: 5));
    print("Final: $finalPosition");

    _speakResponse("From the $currentPosition, where do you want to reach?");
    await Future.delayed(const Duration(seconds: 5));
    print("Listening for final position...");
    await _startListeningFinal();

    await Future.delayed(const Duration(seconds: 5));
    if (currentPosition == finalPosition) {
      _speakResponse("You are already in $currentPosition");
      return;
    }

    // await Future.delayed(Duration(seconds: 5));

    directions = await fetchDirection(currentPosition, finalPosition);

    print(directions);
    _speakDirections();
  }
  Future<void> _waitForSpeechCompletion() async {
    bool speaking = true;
    flutterTts.setCompletionHandler(() {
      speaking = false;
    });

    while (speaking) {
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  Future<void> _speakDirections() async {
    for (var direction in directions) {
      final instruction = direction['instruction']?.toString() ?? "follow the path";
      final distance = direction['distance']?.toStringAsFixed(1) ?? "unknown";
      await flutterTts.speak("$instruction for $distance meters.");

      // Wait until speaking finishes before continuing to next
      await _waitForSpeechCompletion();
    }

    // Final message when done
    await flutterTts.speak("$finalPosition is in front of you");
  }

  Future<void> _startListeningCurrent() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print("Speech recognition status: $status");
        if (status == 'done') {
          _speech.stop(); // Ensure it stops
        }
      },
    );

    if (available) {
      _speech.listen(
        onResult: (result) {
          final recognizedWords = result.recognizedWords;
          print("User said: $recognizedWords");
          setState(() {
            currentPosition = recognizedWords.toLowerCase();
          });
          _speech.stop(); // Stop after recognition
        },
      );
      setState(() {
        isListening = true;
      });
    } else {
      print("Speech recognition is not available");
    }
  }

  Future<void> _startListeningFinal() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print("Speech recognition status: $status");
        if (status == 'done') {
          _speech.stop(); // Ensure it stops
        }
      },
    );

    if (available) {
      _speech.listen(
        onResult: (result) {
          final recognizedWords = result.recognizedWords;
          print("User said: $recognizedWords");
          setState(() {
            finalPosition = recognizedWords.toLowerCase();
          });
          _speech.stop(); // Stop after recognition
        },
      );
      setState(() {
        isListening = true;
      });
    } else {
      print("Speech recognition is not available");
    }
  }

  Future<void> _speakResponse(String text) async {
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _speakDirections();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("PathEase"),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              "Welcome to SVNIT Campus!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Current Position: $currentPosition",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "Final Position: $finalPosition",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Divider(height: 30),
            const Text(
              "Manual Input",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: currentController,
              decoration: const InputDecoration(
                labelText: 'Current Position',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: finalController,
              decoration: const InputDecoration(
                labelText: 'Final Position',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                setState(() {
                  currentPosition = currentController.text.trim().toLowerCase();
                  finalPosition = finalController.text.trim().toLowerCase();
                  directionIndex = 0;
                });

                if (currentPosition == finalPosition) {
                  _speakResponse("You are already in $currentPosition");
                  return;
                }

                directions =
                await fetchDirection(currentPosition, finalPosition);
                _speakDirections();
              },
              icon: const Icon(Icons.send),
              label: const Text("Get Directions"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
            const Divider(height: 30),
            SizedBox(
              height: 1000,
              child: GraphVisualization(
                currentPosition: currentPosition,
                finalPosition: finalPosition,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            setState(() {
              currentPosition = "";
              finalPosition = "";
            });
            directionIndex = 0; // Index to keep track of the current direction

            _speakPrompt();
          },
          child: const Icon(Icons.mic),
        ),
      ),
    );
  }
}

class GraphVisualization extends StatelessWidget {
  final String currentPosition;
  final String finalPosition;

  GraphVisualization(
      {required this.currentPosition, required this.finalPosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: GraphPainter(
              currentPosition: currentPosition, finalPosition: finalPosition),
        ),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final String currentPosition;
  final String finalPosition;

  GraphPainter({required this.currentPosition, required this.finalPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final scaleFactor = 20.0;

    // Define the positions of nodes
    final nodePositions = {
      "lobby": const Offset(0, 0) * scaleFactor,
      "lift": const Offset(0, -5) * scaleFactor,
      "stairs": const Offset(0, -10) * scaleFactor,
      "hallway": const Offset(-5, -10) * scaleFactor,
      "cafeteria": const Offset(-5, -15) * scaleFactor,
      "exit": const Offset(-5, -20) * scaleFactor,
      "office2": const Offset(0, -20) * scaleFactor,
      "office1": const Offset(5, -20) * scaleFactor,
      "gym": const Offset(5, -15) * scaleFactor,
      "washroom": const Offset(5, -10) * scaleFactor,
    };

    // Define the edges between nodes
    final edges = [
      ["lobby", "lift"],
      ["lift", "stairs"],
      ["stairs", "hallway"],
      ["stairs", "washroom"],
      ["hallway", "cafeteria"],
      ["cafeteria", "exit"],
      ["exit", "office2"],
      ["office2", "office1"],
      ["office1", "gym"],
      ["gym", "washroom"],
    ];

    nodePositions.forEach((node, position) {
      Paint nodePaint;
      // Paint nodePaint;
      if (node == currentPosition) {
        // Highlight the currentPosition node with a different color
        nodePaint = Paint()
          ..color = Colors.green // Change the color as desired
          ..style = PaintingStyle.fill;
      } else if (node == finalPosition) {
        // Highlight the finalPosition node with a different color
        nodePaint = Paint()
          ..color = Colors.red // Change the color as desired
          ..style = PaintingStyle.fill;
      } else {
        nodePaint = Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.fill;
      }

      canvas.drawCircle(position, 30, nodePaint);

      final textSpan = TextSpan(
        text: node,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
          minWidth: 0, maxWidth: 100); // Adjust the width as needed
      textPainter.paint(
        canvas,
        position - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    });

    // Draw edges
    final edgePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    edges.forEach((edge) {
      final start = nodePositions[edge[0]];
      final end = nodePositions[edge[1]];
      canvas.drawLine(start!, end!, edgePaint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
