import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_1/map_screen.dart';
import 'homepage.dart';


 void main()async {
  // Ensure Flutter initializes before loading the environment variables
  WidgetsFlutterBinding.ensureInitialized(); 
  // Load the .env file
  await dotenv.load(fileName: ".env");
 runApp(MyApp());
 }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
                title: Text('Weather'),
                onTap: () {
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
                tileColor: Theme.of(context).colorScheme.secondaryContainer,
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
          ],
        ));
  }
}
