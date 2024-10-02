

import 'package:flutter/material.dart';
import 'package:test_1/map_screen.dart';

import 'homepage.dart';


 void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 59, 163, 255)),
       useMaterial3: true,
      ),
      home:DefaultTabController(
        length: 2, // Number of tabs
      child: Home(),    
      ),
    );
  }
  }
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Map'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          HomePage(), // Your existing HomePage
          MapScreen(), // Your existing MapScreen
        ],
      ),
    );
  }
}
  


  