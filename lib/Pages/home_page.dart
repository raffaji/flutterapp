import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:test_1/Pages/auth.dart';
import 'package:test_1/Pages/email_auth_page.dart';
import 'package:test_1/main.dart';

class HomeScreen extends StatelessWidget {
  final Auth _authService = Auth();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Auth')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                User? user = await _authService.signInWithEmail(
                  _emailController.text,
                  _passwordController.text,
                );
                if (user != null) {
                  // Save user email to shared preferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('email', _emailController.text);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherPage()), // Replace with your target screen
                  );
                }
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = await _authService.registerWithEmail(
                  _emailController.text,
                  _passwordController.text,
                );
                if (user != null) {
                  // Save user email to shared preferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('email', _emailController.text);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherPage()), // Replace with your target screen
                  );
                }
              },
              child: Text('Sign up'),
            ),
            SizedBox(height: 20),
            // Button to navigate to EmailAuthPage
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailAuthPage()),
                );
              },
              child: Text('Use Email Link Authentication'),
            ),
          ],
        ),
      ),
    );
  }
}
        

