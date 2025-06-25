// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const BikeGoApp());
}

class BikeGoApp extends StatelessWidget {
  const BikeGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bike Go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF22C55E),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      // Set the landing page as the home screen
      home: const LandingPage(),
      
      // Or use named routes
      routes: {
        '/': (context) => const LandingPage(),
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

// Alternative: If you want to navigate to this page from another page
class NavigationExample extends StatelessWidget {
  const NavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Method 1: Direct navigation
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LandingPage(),
                  ),
                );
              },
              child: const Text('Go to Landing Page (Direct)'),
            ),
            
            const SizedBox(height: 20),
            
            // Method 2: Named route navigation
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/landing');
              },
              child: const Text('Go to Landing Page (Named Route)'),
            ),
          ],
        ),
      ),
    );
  }
}
