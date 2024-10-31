
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

@override
  State<StatefulWidget> createState() => _LoginPageState();

}
class _LoginPageState extends State<LoginPage>{
  String? errorMessage= '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();


Future<void> signInWithEmailAndPassword() async{
  try{
    await Auth().signInWithEmailAndPassword(email: _controllerEmail.text,
     password:_controllerPassword.text,
    );
  } 
  on FirebaseAuthException catch(e){
    setState(() {
      errorMessage = e.message;
    });
  }
  }
  Future<void> createUserWithEmailAndPassword() async{
  try{
    await Auth().createUserWithEmailAndPassword(email: _controllerEmail.text,
     password:_controllerPassword.text,
    );
  } 
  on FirebaseAuthException catch(e){
    setState(() {
      errorMessage = e.message;
    });
  }
  }

Widget _title(){
  return const Text('firebase auth');
}

Widget _entryfield(
  String tile,
  TextEditingController controller,
){
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: '',
    ),
  );
}

Widget _errorMessage (){
  return Text(errorMessage == ''? '': ' humm ? $errorMessage');
}
Widget _submitButton(){
  return ElevatedButton(onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
   child: Text( isLogin? 'login': 'Register' ),
   );
}

Widget _loginOrRegistrationButton(){
  return TextButton(onPressed: (){
    setState(() {
      isLogin = !isLogin;
    });

  }, child: Text(isLogin? 'Register intead': 'Login instead'),
  );
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
          _entryfield('email', _controllerEmail),
          _entryfield('password', _controllerPassword),
          _errorMessage(),
          _submitButton(),
          _loginOrRegistrationButton(),
        ],
      ),
     ),
    );
}
  }




