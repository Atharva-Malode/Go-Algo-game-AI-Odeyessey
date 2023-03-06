import 'package:flutter/material.dart';

class Quiz3 extends StatefulWidget {
  Quiz3({Key? key}) : super(key: key);

  @override
  _Quiz3State createState() => _Quiz3State();
}

class _Quiz3State extends State<Quiz3> {
  List<String> stepList = [
    'Hyperparameter Tuning',
    'Test',
    'Deploy',
  ]..shuffle();

  final List<String> correctOrderList = ['Hyperparameter Tuning', 'Test', 'Deploy'];

  bool isOrderCorrect() {
    for (int i = 0; i < stepList.length; i++) {
      if (stepList[i] != correctOrderList[i]) {
        return false;
      }
    }
    return true;
  }

  @override
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
                padding: const EdgeInsets.symmetric(vertical: 10.0),
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
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final String item = stepList.removeAt(oldIndex);
            stepList.insert(newIndex, item);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isOrderCorrect()) {
            // Move to the next page
            //Navigator.push(
            //  context,
            //  MaterialPageRoute(builder: (context) => LoginPage2()),
            //);
            print('Order is correct, moving to next page...');
          } 
          else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Try Again'),
                  content: const Text('The sequence is incorrect. Please try again.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              }
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}