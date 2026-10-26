
import 'dart:async';
import 'package:flutter/material.dart';

const String studentName = 'Samina Shahid';
const String rollNo = '04072313018';

// ===== Seeded settings (generated from roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> courses = [
  'Mobile Dev', 'Data Structures', 'Operating Systems', 'Databases',
  'Networks', 'Software Eng', 'AI', 'Web Engineering', 'Graphics', 'Security',
];

const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];

const List<String> mains = [
  'start', 'center', 'end', 'spaceBetween', 'spaceAround', 'spaceEvenly',
];

const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];

const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: Clock
final int startSec = 5 * (1 + t % 5);
final int tick = 1 + u % 3;
final int ticks = 4 + u % 4;
final int stopAt = startSec + ticks * tick;

// Steps 4-5: Tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3;

// Step 6: Axes
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5];

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);

// Used by the lifecycle experiment in Step 2.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Team Board',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SettingsCard(),
            SizedBox(height: 12),
            Clock(),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC (taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Part A: read the widget tree of the $course board from top to bottom.',
          key: const Key('sum-a'),
        ),
        Text(
          'Part B: build each box from small widgets and never extend a built-in class.',
          key: const Key('sum-b'),
        ),
        Text(
          'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
          key: const Key('sum-c'),
        ),
      ],
    );
  }
}

// STEP 1, 2 AND 3: Clock, lifecycle and BuildContext experiment.
class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0;

  @override
  void initState() {
    super.initState();

    // I record when the State object is first created.
    lifecycleLog.add('initState');

    // The timer starts here only once. Starting it inside build()
    // would create repeated timers whenever Flutter rebuilt the widget.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);

      if (_seconds >= stopAt) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Each call to build is counted for the Step 2 experiment.
    _builds++;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session: $_seconds s',
          key: const Key('clock'),
        ),
        Text(
          'Builds: $_builds',
          key: const Key('builds'),
        ),

        // Step 3: Probe must be the third child and must NOT be const,
        // because seconds changes whenever the timer updates.
        Probe(seconds: _seconds),
      ],
    );
  }

  @override
  void dispose() {
    // I stop the timer before this State object is destroyed.
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  /*
    STEP 2 ANSWERS
   
   * Q1: Why does Builds increase once per second, not twice?
    The timer calls setState() once each second, requesting a rebuild.
    The build() method does not call setState() again.
   
   * Q2: What happens if the timer is not cancelled in dispose()?
     The timer could try to call setState() after the widget is removed.
    Flutter may report "setState() called after dispose()".
    Cancelling the timer prevents this problem.
   
   * STEP 3 ANSWERS
   
    The Widget is the lightweight description of the interface. Flutter
    creates new widget objects during rebuilds. The Element stays at its
    position in the tree and manages the connection to the widget and its
    State. The RenderObject handles layout, painting and hit testing.
   */
}

// STEP 3: Observe Widget identity, Element identity and BuildContext.
class Probe extends StatelessWidget {
  final int seconds;

  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    // BuildContext identifies this widget's location in the Element tree.
    // This checks whether a Scaffold exists above Probe in the tree.
    final bool above =
        context.findAncestorWidgetOfExactType<Scaffold>() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seen at: $seconds s',
          key: const Key('probe-seen'),
        ),
        Text(
          'Widget #${identityHashCode(this)}',
          key: const Key('probe-widget'),
        ),
        Text(
          'Element #${identityHashCode(context)}',
          key: const Key('probe-element'),
        ),
        Text(
          'Context belongs to: ${context.widget.runtimeType}',
          key: const Key('probe-context'),
        ),
        Text(
          'Scaffold above me: $above',
          key: const Key('probe-above'),
        ),
      ],
    );
  }
}

