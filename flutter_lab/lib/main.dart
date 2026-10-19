import 'dart:async';
import 'package:flutter/material.dart';

const String studentName = 'Samina Shahid';
const String rollNo = '04072313018';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u];
final int startCount = 3 + u;
final int stepSize = 1 + t % 4;
final int maxCount = 20 + 2 * t;
final int startSeconds = 5 + (t + u) % 6;
final int bugStep = 1 + u % 4;
// ===========================================================================

final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Step 1 answer:
// runApp() receives LabApp, the root widget of the application.
// MaterialApp's home property specifies the first page, HomePage.

// Stateless: LabApp configures the app and does not manage changing state.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Study Tracker',
      home: HomePage(),
    );
  }
}

// Stateless: HomePage arranges the screen widgets without storing changing data.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Tracker: $course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(
              name: studentName,
              roll: rollNo,
              course: course,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start: $startCount',
                  key: const Key('info-start'),
                ),
                Text(
                  'Step: $stepSize',
                  key: const Key('info-step'),
                ),
                Text(
                  'Max: $maxCount',
                  key: const Key('info-max'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Tally(),
            const SizedBox(height: 12),
            const Countdown(),
            const SizedBox(height: 12),
            const BuggyCounter(),
          ],
        ),
      ),
    );
  }
}

// Stateless: StudentCard displays the information passed to it.
class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;

  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              key: const Key('student-name'),
            ),
            Text(
              'Roll no: $roll',
              key: const Key('student-roll'),
            ),
            Text(
              'Course: $course',
              key: const Key('student-course'),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateless: GoalBanner calculates and displays progress from given values.
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  const GoalBanner({
    super.key,
    required this.count,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;

    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

// Stateful: Tally uses a separate State object for its changing count.
class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

// Stateful: _TallyState stores and updates the count.
class _TallyState extends State<Tally> {
  int _count = startCount;

  void _plus() {
    setState(() {
      _count += stepSize;

      if (_count > maxCount) {
        _count = maxCount;
      }
    });
  }

  void _minus() {
    setState(() {
      _count -= stepSize;

      if (_count < 0) {
        _count = 0;
      }
    });
  }

  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Count: $_count',
          key: const Key('count'),
        ),
        GoalBanner(
          count: _count,
          max: maxCount,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),
            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// Stateful: Countdown manages a timer and remaining time.
class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

// Stateful: _CountdownState records lifecycle events and counts builds.
class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;
  int _builds = 0;

  @override
  void initState() {
    super.initState();

    lifecycleLog.add('initState');

    _left = startSeconds;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_left > 0) {
          setState(() {
            _left--;
          });
        }

        if (_left <= 0) {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    debugPrint(lifecycleLog.toString());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_left > 0)
          Text(
            'Time left: $_left s',
            key: const Key('time-left'),
          )
        else
          const Text(
            'Time is up!',
            key: Key('time-left'),
          ),
        Text(
          'Builds: $_builds',
          key: const Key('builds'),
        ),
      ],
    );
  }
}

// Stateful: BuggyCounter maintains a changing click count.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

// Stateful: _BuggyCounterState updates the count when its button is pressed.
class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Bug clicks: $_clicks',
          key: const Key('bug-text'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            setState(() {
              _clicks += bugStep;
            });
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}

// Step 6 answer:
// Hot reload usually preserves the existing State, so the count stays.
// Hot restart creates a new State, so the count resets.

// Step 7 answer:
// Before the fix, three taps made _clicks equal to 3,
// but the screen still showed 0 because setState was missing.

// Step 8 answer:
// Without cancelling the timer, it could call setState after the
// widget is removed. Flutter may report "setState() called after dispose()".

// Step 9 answer:
// Builds increases once per second because each timer tick calls
// setState once, causing one rebuild of Countdown.
// Printing lifecycleLog in dispose helps verify that disposal occurred.
