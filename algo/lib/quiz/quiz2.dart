import 'package:flutter/material.dart';
import '../login/login3.dart';
import 'dart:async';

class Quiz2 extends StatefulWidget {
  final int time;
  Quiz2({Key? key, required this.time}) : super(key: key);

  @override
  _Quiz2 createState() => _Quiz2();
}

class _Quiz2 extends State<Quiz2> {
  List<String> stepList = [
    'Problem Identification',
    'Problem Scoping',
    'Data Acquisition',
    'Data Exploration',
    'Data Modelling',
    'Evaluation',
    'Deployment',
  ]..shuffle();

  final List<String> correctOrderList = [
    'Problem Identification',
    'Problem Scoping',
    'Data Acquisition',
    'Data Exploration',
    'Data Modelling',
    'Evaluation',
    'Deployment',
  ];

  bool isOrderCorrect() {
    for (int i = 0; i < stepList.length; i++) {
      if (stepList[i] != correctOrderList[i]) {
        return false;
      }
    }
    return true;
  }

  Timer? _timer;
  int _elapsedTimeInSeconds = 0;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTimeInSeconds++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Round 2',
        ),
        automaticallyImplyLeading: false,
        elevation: 20,
      ),
      body: ReorderableListView(
        children: stepList
            .map(
              (step) => Padding(
                key: ValueKey(step),
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      step,
                      style: const TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final String item = stepList.removeAt(oldIndex);
            stepList.insert(newIndex, item);
          });
        },
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Arrange the following steps in development of Machine Learning Model",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isOrderCorrect()) {
            _stopTimer();
            int timeTakenInSeconds = _elapsedTimeInSeconds;
            print('Elapsed time: $timeTakenInSeconds seconds');
            int temptime = timeTakenInSeconds + widget.time;
            // Move to the next page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage3(
                        elapsedtime: timeTakenInSeconds,
                        totaltime: temptime,
                      )),
            );
            print('Order is correct, moving to next page...');
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Try Again'),
                    content: const Text(
                        'The sequence is incorrect. Please try again.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
