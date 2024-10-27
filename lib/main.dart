import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_1/map_screen.dart';
import 'package:test_1/theme_cubit.dart';
import 'package:test_1/weather/ui/weather_ui.dart';
import 'package:test_1/weatherui.dart';

void main() async {
  /// For firebase
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(), // Initialize ThemeCubit
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: theme, // Use the current theme provided by ThemeCubit
            home: DefaultTabController(
              length: 2, // Number of tabs
              child: WeatherPage(),
            ),
          );
        },
      ),
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeCubit>().toggletheme();
            },
            icon: Icon(
              context.watch<ThemeCubit>().state.brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              trailing: Icon(Icons.adaptive.arrow_forward_outlined),
              leading: const Icon(Icons.cloud),
              subtitle: const Text('Tap to open weather forecast'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Platform.isIOS
                  ? CupertinoColors.secondarySystemFill
                  : Theme.of(context).colorScheme.secondaryContainer,
              title: const Text('Weather'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage()),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Platform.isIOS
                  ? CupertinoColors.secondarySystemFill
                  : Theme.of(context).colorScheme.secondaryContainer,
              leading: const Icon(Icons.map),
              title: const Text('Map'),
              subtitle: const Text('Tap to open the Map screen'),
              trailing: Icon(Icons.adaptive.arrow_forward_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MapScreen()), 
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Platform.isIOS
                  ? CupertinoColors.secondarySystemFill
                  : Theme.of(context).colorScheme.secondaryContainer,
              leading: const Icon(Icons.thermostat_outlined),
              title: const Text('Weather Cubit Example'),
              subtitle: const Text('Tap to open the weather cubit screen'),
              trailing: Icon(Icons.adaptive.arrow_forward_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WeatherUI()), 
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
