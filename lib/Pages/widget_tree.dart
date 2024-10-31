import 'auth.dart';
import 'home_page.dart';
import 'login_register_pager.dart';
import 'package:flutter/material.dart';


class WidgetTree  extends StatefulWidget{
  const WidgetTree({super.key});
@override
  State<StatefulWidget> createState() => _WidgetTreeState();

}

class _WidgetTreeState extends State<WidgetTree>{

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Auth().authStatechanges, builder: (context,snapshot){
      if(snapshot.hasData){
        return HomePage();
      } else{
        return const  LoginPage();
      }
    });
  }
}