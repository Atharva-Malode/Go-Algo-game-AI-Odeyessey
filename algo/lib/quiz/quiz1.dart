import 'package:flutter/material.dart';
import '../login/login2.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> stepList = [
    'Train',
    'Test',
    'Deploy',
  ]..shuffle();

  final List<String> correctOrderList = ['Train', 'Test', 'Deploy'];

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
                  width: 200,
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
            Navigator.push(
              context,
              CustomPageRoute(page: const LoginPage2())
            );
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