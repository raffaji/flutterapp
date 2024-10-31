import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
class HomePage  extends StatelessWidget{
   HomePage({super.key});

 final User ? user= Auth().currentuser;
 
 Future<void> signOut() async{
  await Auth().signOut();
}
 
 Widget _title(){
  return const Text('Firebase auth');

 }
 Widget _userid(){
  return Text( user?.email ?? 'USER EMAIL');
 }
 Widget _signOutButton(){
  return ElevatedButton(onPressed: signOut,
   child: const Text('Sign Out'));
 }
@override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: _title(),
     ),
     body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _userid(),
          _signOutButton(),
        ],
      ),
     ),
    );
}
}