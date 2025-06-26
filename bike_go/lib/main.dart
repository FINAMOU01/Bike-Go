import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/home_page.dart';
import 'screens/help_support_page.dart';
// import 'screens/payment_methods_page.dart';
// import 'screens/forgot_password_page.dart'; // Ajoute-le si nécessaire
// import 'screens/map_page.dart'; // TA carte !

void main() {
  runApp(const BikeGoApp());
}

class BikeGoApp extends StatelessWidget {
  const BikeGoApp({super.key});

  Future<bool> _shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
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
          if (snapshot.hasData && snapshot.data == true) {
            return const OnboardingPage();
          } else {
            return const LandingPage();
          }
        },
      ),
      routes: {
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/help': (context) => const HelpSupportPage(),
        // '/payment': (context) => const PaymentMethodsPage(),
        // '/forgot': (context) => const ForgotPasswordPage(),
        // '/map': (context) => const MapPage(), // <- TA PAGE DE CARTE
      },
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Bike Go'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Bike Go!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Your bike sharing journey starts here'),
            SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('onboarding_complete', true);
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/landing');
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
