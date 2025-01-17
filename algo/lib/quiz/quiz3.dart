import 'package:flutter/material.dart';
import 'dart:async';

import '../congrats.dart';

class Quiz3 extends StatefulWidget {
  final int time;
  Quiz3({Key? key, required this.time}) : super(key: key);

  @override
  _Quiz3State createState() => _Quiz3State();
}

class _Quiz3State extends State<Quiz3> {
  List<String> stepList = [
    'Data collection',
    'Data cleaning',
    'Feature selection',
    'Splitting data',
    'Standardization/Normalization',
    'Model initialization',
    'Model fitting',
    'Performance evaluation',
    'Hyperparameter tuning',
    'Prediction on new data',
    'Model deployment',
  ]..shuffle();

  final List<String> correctOrderList = [
    'Data collection',
    'Data cleaning',
    'Feature selection',
    'Splitting data',
    'Standardization/Normalization',
    'Model initialization',
    'Model fitting',
    'Performance evaluation',
    'Hyperparameter tuning',
    'Prediction on new data',
    'Model deployment',
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
          'Round 3',
        ),
        automaticallyImplyLeading: false,
        elevation: 20,
      ),
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final String item = stepList.removeAt(oldIndex);
            stepList.insert(newIndex, item);
          });
        },
        header: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Arrange the following steps in correct order of Machine Learning",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        children: stepList
            .map(
              (step) => Padding(
                key: ValueKey(step),
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
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
                  builder: (context) => CongratulationsPage(
                        message: 'Congratulations You won',
                        elapsedtime: timeTakenInSeconds,
                        time: temptime,
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
