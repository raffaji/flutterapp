import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/Pages/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_1/Pages/home_page.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_1/map_screen.dart';
import 'package:test_1/theme_cubit.dart';
import 'package:test_1/weather/ui/weather_ui.dart';
import 'package:test_1/weatherui.dart';
import 'package:test_1/UI/bloc_ui.dart';

void main() async {
  // Ensure Flutter initializes before loading Firebase and environment variables
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   //Load the .env file
 try {
  await dotenv.load(fileName: "/Users/raffayhassan/Documents/test_1/.env");
   } catch (e, stackTrace) {
     debugPrint("Error loading .env file: ${e.toString()} $stackTrace");
   }

  // Initialize shared preferences
  try {
    // ignore: unused_local_variable
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Optionally, you could set a default value or check if user data exists here
    // Example: prefs.setString('defaultKey', 'defaultValue');
  } catch (e) {
    debugPrint("Error initializing shared preferences: ${e.toString()}");
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
            home: StreamBuilder<User?>(
              stream: Auth().authStatechanges, // Listen to the authentication state changes
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Show loading indicator while waiting
                }

                if (snapshot.hasData) {
                  // User is signed in
                  return WeatherPage(); // Navigate to your authenticated home page
                } else {
                  // User is not signed in
                  return HomeScreen(); // Replace with your login/register page
                }
              },
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
       IconButton(
          onPressed: ()  {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>HomeScreen ()),
            );
          },
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
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
                  MaterialPageRoute(builder: (context) => WeatherUI()),
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
              leading: const Icon(Icons.cloud_circle),
              title: const Text('Weather Bloc Example'),
              subtitle: const Text('Tap to open the weather bloc screen'),
              trailing: Icon(Icons.adaptive.arrow_forward_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>BlocTile()),
                );
              },
            ),
          ), 
        ],
      ),
    );
  }
}
          