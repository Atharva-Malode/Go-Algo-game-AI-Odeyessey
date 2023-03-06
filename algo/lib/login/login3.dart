import 'package:flutter/material.dart';

import '../quiz/quiz3.dart';

class LoginPage3 extends StatefulWidget {
  const LoginPage3({Key? key}) : super(key: key);

  @override
  _LoginPage3State createState() => _LoginPage3State();
}

class _LoginPage3State extends State<LoginPage3> {
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _onLoginPressed() {
    if (_passwordController.text == '12345') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Quiz3()),
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
          }
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
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
    );
  }
}
