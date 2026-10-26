
import 'dart:async';
import 'package:flutter/material.dart';

const String studentName = 'Samina Shahid';
const String rollNo = '04072313018';

// Seeded settings generated from the roll number. Do not edit.
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
          children: [
  const SettingsCard(),
  const SizedBox(height: 12),
  const Welcome(),
  const SizedBox(height: 12),
  const Clock(),
  const SizedBox(height: 12),
  const SwapBoard(),
  const InfoPanel(),
  const SizedBox(height: 12),
  const SummaryRow(),
  const SizedBox(height: 12),
   ShareRow(),
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
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

/*
STEP 7 ANSWER

Expanded gives each Text a limited share of the Row's available
width. Flutter passes these width constraints down to the Text
widgets, and their resulting sizes go back up. Each Text wraps its
words within its allocated width, preventing the horizontal overflow.
*/

// Steps 1, 2 and 3: Clock, lifecycle and BuildContext experiment.
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
    lifecycleLog.add('initState');

    // The timer starts once here. Starting it inside build() could
    // create repeated timers whenever Flutter rebuilds this widget.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);

      if (_seconds >= stopAt) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        Probe(seconds: _seconds),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  /*
  STEP 2 ANSWERS

  Builds increases once per second because the timer calls setState()
  once per second, requesting a rebuild. The build() method does not
  call setState() again.

  If the timer is not cancelled in dispose(), it could call setState()
  after the widget is removed, causing the error "setState() called
  after dispose()". Cancelling the timer prevents this problem.

  STEP 3 ANSWER

  A Widget is a lightweight description of the interface and new
  Widget objects are created during rebuilds. The Element stays in
  the tree and manages the connection to the Widget and its State.
  The RenderObject handles layout, painting and hit testing.
  */
}

// Step 3: Observe Widget identity, Element identity and BuildContext.
class Probe extends StatelessWidget {
  final int seconds;

  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
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

// STEP 4.1: Composition using small widgets.
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome, $studentName',
        key: const Key('welcome'),
      ),
    );
  }
}

// STEP 4.2: Each Tile maintains its own tap count in its State object.
class Tile extends StatefulWidget {
  const Tile(this.label, {super.key});

  final String label;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => taps++),
      child: Text('${widget.label}: $taps'),
    );
  }
}

/*
STEP 4 ANSWER

This style is called composition. Instead of creating a new class
that extends ElevatedButton, Tile combines an ElevatedButton with
its own State and label. Flutter prefers composition because small,
reusable widgets can be combined and changed easily without creating
a separate subclass for every variation.
*/

 // STEP 5: Swap tiles while preserving their State using ValueKey.
class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  var tiles = [
    Tile(tileA, key: ValueKey(tileA)),
    Tile(tileB, key: ValueKey(tileB)),
    Tile(tileC, key: ValueKey(tileC)),
  ];

  void swap() => setState(() => tiles = tiles.reversed.toList());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: tiles),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}

/*
STEP 5 ANSWER

Without keys, Flutter matches widgets mainly by their type and
position. When the tiles are reordered, the existing Element and
its State can remain at the same position, so the tap count may
stay on the left while the displayed label changes. ValueKey
identifies each tile by its label, allowing Flutter to match the
correct widget and preserve its State when the order changes.
*/

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Start: $startSec s',
              key: const Key('row-a'),
            ),
            const SizedBox(width: 12),
            Text(
              'Tick: $tick s',
              key: const Key('row-b'),
            ),
            const SizedBox(width: 12),
            Text(
              'Stop: $stopAt s',
              key: const Key('row-c'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Name: $studentName',
              key: const Key('col-a'),
            ),
            Text(
              'Roll no: $rollNo',
              key: const Key('col-b'),
            ),
            Text(
              'Course: $course',
              key: const Key('col-c'),
            ),
          ],
        ),
      ],
    );
  }
}

/*
STEP 6 ANSWER

In a Column, the main axis is vertical because its children are
arranged from top to bottom. The cross axis is horizontal, so
CrossAxisAlignment.center moves the children left or right to
the horizontal center instead of moving them up or down.
*/

class ShareRow extends StatelessWidget {
  const ShareRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('share-row'),
      children: [
        SizedBox(
          key: const Key('fixed'),
          width: fixedW,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('F'),
          ),
        ),
        Expanded(
          flex: flexA,
          child: ElevatedButton(
            key: const Key('exp'),
            onPressed: () {},
            child: const Text('Exp'),
          ),
        ),
        Flexible(
          flex: flexB,
          child: ElevatedButton(
            key: const Key('flex'),
            onPressed: () {},
            child: const Text('Flex'),
          ),
        ),
      ],
    );
  }
}

/*
STEP 8 ANSWER

Expanded receives its proportional share of the remaining width and
must fill that space. Flexible also receives a proportional share,
but its child can remain smaller when using its default loose fit.

Expanded is equivalent to Flexible with fit: FlexFit.tight. If we
swap Expanded and Flexible between the two buttons, the Flex button
will be forced to fill its share while the Exp button may stay smaller.
*/


