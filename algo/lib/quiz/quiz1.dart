import 'package:flutter/material.dart';
import '../login/login2.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> stepList = [
    'Mean',
    'Deviation',
    'Variance',
    'Covariance',
    'Coefficients',
    'Applying Regression',
    'Predict Values',
  ]..shuffle();

  final List<String> correctOrderList = [
    'Mean',
    'Deviation',
    'Variance',
    'Covariance',
    'Coefficients',
    'Applying Regression',
    'Predict Values',
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
          'Round 1',
        ),
        automaticallyImplyLeading: false,
        elevation: 20,
      ),
      body: ReorderableListView(
        children: stepList
            .map(
              (step) => Padding(
                key: ValueKey(step),
                padding: const EdgeInsets.symmetric(vertical: 05.0),
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
            "Arrange the following steps in correct order of linear regression",
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
            // Move to the next page
            Navigator.push(
                context,
                CustomPageRoute(
                    page: LoginPage2(
                  elapsedtime: timeTakenInSeconds,
                )));
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

class CustomPageRoute extends PageRouteBuilder {
  final Widget page;

  CustomPageRoute({required this.page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = TweenSequence([
              TweenSequenceItem(
                tween: Tween(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
                    .chain(CurveTween(curve: Curves.easeOut)),
                weight: 1.0,
              ),
              TweenSequenceItem(
                tween: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .chain(CurveTween(curve: Curves.easeIn)),
                weight: 1.0,
              ),
            ]);
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
