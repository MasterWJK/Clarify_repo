import 'package:clarify_app/main_pages/AITraining.dart';
import 'package:clarify_app/main_pages/profile/OwnProfile.dart';
import 'package:clarify_app/start_flow/login/LoginSecond.dart';
import 'package:clarify_app/start_flow/login/LoginStart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'backend/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'main_pages/Home.dart';
import 'main_pages/AiChat.dart';
import 'main_pages/ProgressPage.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart' show rootBundle;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  await dotenv.load(fileName: "assets/.env");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[800], // Use blue[800] as the primary color
    );
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;
    print("FirebasAuth: " + user.toString());

    // Return either the Home or Login screen
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirebaseAuth.instance.currentUser != null
            ? LoginStart()
            : const HomePage(),
        '/login2': (context) => LoginSecond(),
        '/progress': (context) => ProgressPage(),
        '/daily_ai': (context) => FutureBuilder<String>(
              future: rootBundle.loadString('assets/.env'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return AiChat(env: snapshot.data!);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
        '/AITraining': (context) => AITraining(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    FutureBuilder<String>(
      future: rootBundle.loadString('assets/.env'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return AiChat(env: snapshot.data!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ),
    ProgressPage(),
    const OwnProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspaces), // Robot icon
            label: 'Daily AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer_rounded), // Challenge icon
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Profile icon
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF8A2BE2),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
