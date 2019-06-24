import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //usernameController.addListener(printSomeValues);
  }

  printSomeValues() {
    print('controller values ${usernameController.text}');
  }

  @override
  void dispose() {
    super.dispose();
    //usernameController.removeListener(printSomeValues);
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'New Username',
                border: InputBorder.none,
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'New Password',
                border: InputBorder.none,
                labelText: 'Password',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'New Email Address',
                border: InputBorder.none,
                labelText: 'Email',
              ),
            ),
            Text(usernameController.text),
            Text(passwordController.text),
            FlatButton(
              child: Container(
                child: Text('Sign Up'),
              ),
              onPressed: () => {print('signing up')},
            ),
          ],
        ),
      ),
    );
  }
}
