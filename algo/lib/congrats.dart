import 'package:flutter/material.dart';

class CongratulationsPage extends StatefulWidget {
  final String message;
  final int elapsedtime;
  final int time;
  CongratulationsPage(
      {Key? key,
      required this.time,
      required this.elapsedtime,
      required this.message})
      : super(key: key);

  @override
  _CongratulationsPageState createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations You\'ve completed the Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100.0,
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                '${widget.message}\nTime taken in Quiz 3 is ${widget.elapsedtime} seconds\nTotal Time Taken: ${widget.time}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
