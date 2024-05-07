import 'dart:async';
import 'dart:math';
import 'dart:core';
import 'package:basic_stopwatch/widgets/custom_button.dart';
import 'package:basic_stopwatch/widgets/positioned_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late WatchPainter watchPainter;
  late Stopwatch stopwatch;
  late Timer timer;
  List laps = [];

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }

  final _renderBoxKey = GlobalKey();

  String state = "Start";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    watchPainter = WatchPainter(context: context);
    stopwatch = Stopwatch();

    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String stopwatchTime() {
    var milli = stopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 100).toString().padLeft(2, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");

    return "$minutes:$seconds.$milliseconds";
  }

  Duration parseDuration(String time) {
    List<String> parts = time.split(':');
    int minutes = int.parse(parts[0]);
    List<String> secondsParts = parts[1].split('.');
    int seconds = int.parse(secondsParts[0]);
    int milliseconds = int.parse(secondsParts[1]);
    return Duration(
        minutes: minutes, seconds: seconds, milliseconds: milliseconds);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String twoDigitMilliseconds =
        twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);
    return '$twoDigitMinutes:$twoDigitSeconds.$twoDigitMilliseconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: CustomButton(
              onTap: () {
                if(state == 'Start') return;
                var time = stopwatchTime();
                var difference = stopwatchTime();
                if (laps.isNotEmpty) {
                  Duration startDuration = parseDuration(laps[laps.length-1]['time']);
                  Duration endDuration = parseDuration(stopwatchTime());

                  difference = formatDuration(endDuration - startDuration);
                }
                laps.add({
                  'time': time,
                  'difference': difference,
                });
              },
              text: 'Lap',
              icon: CupertinoIcons.stopwatch_fill,
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: CustomButton(
              onTap: () {
                stopwatch.reset();
                laps.clear();
              },
              text: 'Reset',
              icon: CupertinoIcons.restart,
            ))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.sizeOf(context).width / 1.5,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    offset: const Offset(4, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  stopwatchTime(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Stack(
            children: [
              const Center(
                child: SizedBox(
                  height: 270,
                ),
              ),
              Center(
                child: SizedBox(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: CustomPaint(
                    painter: watchPainter,
                    key: _renderBoxKey,
                  ),
                ),
              ),
              PositionedButton(
                onTap: () {
                  setState(() {
                    if (state == 'Start') {
                      state = 'Stop';
                    } else {
                      state = 'Start';
                    }
                  });
                  handleStartStop();
                },
                renderBoxKey: _renderBoxKey,
                watchPainter: watchPainter,
                child: Text(
                  state,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              )
            ],
          ),
          const SizedBox(height: 60),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (value) {},
                            shape: CircleBorder(),
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Text('Lap ${index + 1}',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Text(laps[index]['time'],
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('+${laps[index]['difference']}',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}

class WatchPainter extends CustomPainter {
  final BuildContext context;
  double rotationAngle = 0.0;

  WatchPainter({
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width;
    var centerY = size.height;
    var radius = min(centerX, centerY);

    var dashBrush = Paint()
      ..color = Theme.of(context).primaryColor
      ..strokeWidth = 3;

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 20;
    for (int i = 0; i < 360; i += 5) {
      var x1 = centerX + -centerY + 50 + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + -centerY + 50 + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    var pointBrush = Paint()
      ..color = Theme.of(context).primaryColor
      ..strokeWidth = 6;

    var pointX = centerX +
        -centerY +
        50 +
        innerCircleRadius * cos(rotationAngle * pi / 180);
    var pointY = centerY + innerCircleRadius * sin(rotationAngle * pi / 180);
    canvas.drawCircle(Offset(pointX - 10, pointY), 5, pointBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

  void updateRotationAngle(double newAngle) {
    rotationAngle = newAngle;
  }
}
