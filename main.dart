import 'package:flutter/material.dart';

/*
  Name: Samina Shahid
  Roll Number: 04072313018

  Last 3 digits: 0, 1, 8
  myThreshold = 0 + 1 + 8 + 5 = 14

  mySeedColor:
  First name starts with S.
  Last name also starts with S.
  No standard Flutter Colors value starts with S.
  Temporary fallback: Colors.teal
*/

const int myThreshold = 14;

// TASK 4 - Personalised Theme

const Color mySeedColor = Colors.teal;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      // TASK 4 - Personalised Theme
      theme: ThemeData(
        colorSchemeSeed: mySeedColor,
        useMaterial3: true,
      ),

      home: const MyHomePage(
        title: 'CS 442 MAD Hot Reload Demo',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // TASK 3 - Tracks how many times Reset is pressed
  int _resetCount = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;

      // TASK 3
      _resetCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Times you Pushed the :',
            ),

            Text(
              '$_counter',
              style:
                  Theme.of(context).textTheme.headlineMedium,
            ),

            // TASK 2 - Conditional Threshold Message
            if (_counter > myThreshold)
              const Text(
                "You're on a roll!",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),

            const SizedBox(height: 15),

            // TASK 3 - Display reset count
            Text(
              'Resets used: $_resetCount',
            ),

            const SizedBox(height: 40),

            // TASK 5 - About Line
            const Text(
              'Built by Samina Shahid · 04072313018',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'resetButton',
            onPressed: _resetCounter,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),

          const SizedBox(width: 10),

          FloatingActionButton(
            heroTag: 'incrementButton',
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}