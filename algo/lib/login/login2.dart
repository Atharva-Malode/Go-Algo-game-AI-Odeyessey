import 'package:flutter/material.dart';

import '../quiz/quiz2.dart';

class LoginPage2 extends StatefulWidget {
  final int elapsedtime;
  const LoginPage2({Key? key, required this.elapsedtime}) : super(key: key);
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _onLoginPressed() {
    if (_passwordController.text == '1999') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Quiz2(
                  time: widget.elapsedtime,
                )),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid password. Please try again.';
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Incorrect Password'),
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              'Time taken in Quiz1 ${widget.elapsedtime} seconds',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _onLoginPressed,
                  child: Text('Login'),
                ),
                SizedBox(height: 8.0),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
