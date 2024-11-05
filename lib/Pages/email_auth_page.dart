import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; // To store email locally

class EmailAuthPage extends StatefulWidget {
  const EmailAuthPage({super.key});

  @override
  State<EmailAuthPage> createState() => _EmailAuthPageState();
 
}

class _EmailAuthPageState extends State<EmailAuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  

  Future<void> sendSignInLink() async {
    String emailAuth = _email;

   var acs = ActionCodeSettings(
      url: 'https://sample-weather-ai-app.firebaseapp.com',
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.example.android',
      androidInstallApp: true,
      androidMinimumVersion: '12',
    );

    try {
      await _auth.sendSignInLinkToEmail(email: emailAuth, actionCodeSettings: acs);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailAuth);
      print('Email link sent to $emailAuth');
    } catch (e) {
      print('Error sending email link: $e');
    }
  }

  Future<void> signInWithEmailLink(String emailLink) async {
    final prefs = await SharedPreferences.getInstance();
    String emailAuth = prefs.getString('email') ?? '';

    if (_auth.isSignInWithEmailLink(emailLink)) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailLink(email: emailAuth, emailLink: emailLink);
        print('Successfully signed in: ${userCredential.user?.email}');
      } catch (e) {
        print('Error signing in: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email Link Authentication')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) => _email = value,
              decoration: InputDecoration(labelText: 'Enter your email'),
            ),
            ),
            ElevatedButton(
              onPressed: sendSignInLink,
              child: Text('Send Sign-In Link'),
            ),
          ],
        ),
      ),
    );
  }
}
