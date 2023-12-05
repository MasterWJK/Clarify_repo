import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _emailController =
      TextEditingController(text: 'clarify.aied@gmail.com');
  final _passwordController = TextEditingController(text: 'Test1234');

  Future<void> _signInWithEmailAndPassword() async {
    // Check if the input is valid before attempting to sign in
    if (!_validateInputs()) {
      return;
    }

    try {
      // Show a loading indicator to the user
      _showLoadingIndicator(context);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Check if the user is successfully signed in
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Differentiate error types
      _handleAuthException(e);
    } finally {
      // Hide the loading indicator
      _hideLoadingIndicator(context);
    }
  }

  bool _validateInputs() {
    // Implement input validation logic here
    // Return true if inputs are valid, false otherwise
    return true;
  }

  void _showLoadingIndicator(BuildContext context) {
    // Implement showing a loading indicator
  }

  void _hideLoadingIndicator(BuildContext context) {
    // Implement hiding the loading indicator
  }

  void _handleAuthException(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'The email address is not valid.';
        break;
      case 'user-disabled':
        errorMessage = 'This user has been disabled.';
        break;
      case 'user-not-found':
      case 'wrong-password':
        errorMessage = 'Incorrect email or password.';
        break;
      default:
        errorMessage = 'An unexpected error occurred.';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
