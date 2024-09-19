import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyOneWidgetStateful(),
    );
  }
}

class MyOneWidgetStateless extends StatelessWidget {
  const MyOneWidgetStateless({super.key});

  @override
  Widget build(BuildContext context) {
    int a = 0;
    a++;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HAHAHHA'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('raffay hassan $a'),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          a++;
          print('value $a');
        },
        child: const Text('+'),
      ),
    );
  }
}

class MyOneWidgetStateful extends StatefulWidget {
  const MyOneWidgetStateful({super.key});

  @override
  State<MyOneWidgetStateful> createState() => _MyOneWidgetStatefulState();
}

class _MyOneWidgetStatefulState extends State<MyOneWidgetStateful> {
  int a = 0;
  @override
  Widget build(BuildContext context) {
    a++;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HAHAHHA'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('raffay hassan $a'),
            Text('raffay hassan $a'),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          setState(() {
            a++;
          });

          print('value $a');
        },
        child: const Text('+'),
      ),
    );
  }
}
