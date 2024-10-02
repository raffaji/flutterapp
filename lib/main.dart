import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_1/map_screen.dart';
import 'package:test_1/weather/ui/weather_ui.dart';
import 'homepage.dart';

void main() async {
  // Ensure Flutter initializes before loading the environment variables
  WidgetsFlutterBinding.ensureInitialized();
  // Load the .env file
  try {
    await dotenv.load(fileName: ".env");
  } catch (e, stackTrace) {
    debugPrint("${e.toString()} $stackTrace");
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///TODO add a dark mode button on the app with cubit
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.tealAccent,
        ),
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.tealAccent,
        ),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Home(
          toggleDarkMode: toggleDarkMode,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.toggleDarkMode});

  final void Function()? toggleDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
          actions: [
            IconButton(
              onPressed: () {
                toggleDarkMode!();
              },
              icon: Icon(Icons.light_mode),
            ),
          ],
        ),
        body: Column(
          children: [
            ///TODO: Add a Icons and description for each ListTile
            Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
                title: Text('Weather'),
                onTap: () {
                  ///TODO: rename HomePage to WeatherPage and homepage.dart to weather_page.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                ///TODO: use Platform.isIOS to set the tileColor
                tileColor: Platform.isIOS
                    ? CupertinoColors.secondarySystemFill
                    : Theme.of(context).colorScheme.secondaryContainer,
                leading: Icon(Icons.map),
                title: Text('Map'),
                subtitle: Text('Tap to open the Map screen'),
                // trailing: Icon(Icons.arrow_forward_ios),
                trailing: Icon(Icons.adaptive.arrow_forward_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
                leading: Icon(Icons.thermostat_outlined),
                title: Text('Weather Cubit Example'),
                subtitle: Text('Tap to open the Map screen'),
                // trailing: Icon(Icons.arrow_forward_ios),
                trailing: Icon(Icons.adaptive.arrow_forward_outlined),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherUI()),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
