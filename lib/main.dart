// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/home_page.dart';
import 'screens/help_support_page.dart';
import 'screens/payment_methods_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const BikeGoApp());
}

class BikeGoApp extends StatelessWidget {
  const BikeGoApp({super.key});

  // Add the missing method to check if onboarding should be shown
  Future<bool> _shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    // Return false if onboarding has been completed before
    return !(prefs.getBool('onboarding_complete') ?? false);
  }

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
      
      home: FutureBuilder<bool>(
        future: _shouldShowOnboarding(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return  == true ? const OnboardingPage() : const LandingPage();
        },
      ),
      
      
      routes: {
        '/': (context) => const LandingPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/help': (context) => const HelpSupportPage(),
        '/payment': (context) => const PaymentMethodsPage(),
      },
    );
  }
}

class OnboardingPage {
  const OnboardingPage();
}


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
