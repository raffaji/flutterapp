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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'my name is raffay',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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
