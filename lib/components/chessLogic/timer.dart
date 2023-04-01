import 'dart:async';

import 'package:ajedrez/components/chessLogic/board.dart';
import 'package:flutter/material.dart';

class CustomTimer extends StatefulWidget {
  final String label;
  final bool isWhite;
  final Duration duration;
  final Function onTimerEnd;

  const CustomTimer ({super.key, 
    required this.label,
    required this.duration,
    required this.onTimerEnd,
    required this.isWhite,
  });

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<CustomTimer> {
  late Timer _timer;
  late Stream<int> _stream;
  int lastTime = 0;

  @override
  void initState() {
    super.initState();
    lastTime = widget.duration.inSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
  _timer = Timer(widget.duration, () {
    widget.onTimerEnd();
  });

  _stream = Stream.periodic(const Duration(seconds: 1), (count) {
  if (widget.isWhite == BoardData().whiteTurn) {
    lastTime -= 1;
  }
  return lastTime;
}).takeWhile((timeRemaining) => timeRemaining >= 0);

}

  String _formatTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        String timeText = '${widget.label}: --:--';
        if (snapshot.hasData) {
          timeText = '${widget.label}: ${_formatTime(snapshot.data!)}';
        }
        return Text(
          timeText,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}