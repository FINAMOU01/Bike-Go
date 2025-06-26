// // main.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'screens/landing_page.dart';
// import 'screens/login_page.dart';
// import 'screens/signup_page.dart';
// import 'screens/home_page.dart';
// import 'screens/help_support_page.dart';
// import 'screens/payment_methods_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const BikeGoApp());
// }

// class BikeGoApp extends StatelessWidget {
//   const BikeGoApp({super.key});

//   // Add the missing method to check if onboarding should be shown
//   Future<bool> _shouldShowOnboarding() async {
//     final prefs = await SharedPreferences.getInstance();
//     // Return false if onboarding has been completed before
//     return !(prefs.getBool('onboarding_complete') ?? false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bike Go',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         primaryColor: const Color(0xFF22C55E),
//         scaffoldBackgroundColor: const Color(0xFFF8F9FA),
//         textTheme: GoogleFonts.interTextTheme(),
//         useMaterial3: true,
//       ),
      
//       home: FutureBuilder<bool>(
//         future: _shouldShowOnboarding(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//         },
//       ),*/

//       routes: {
//         '/': (context) => const LandingPage(),
//         '/login': (context) => const LoginPage(),
//         '/signup': (context) => const SignupPage(),
//         '/home': (context) => const HomePage(),
//         '/help': (context) => const HelpSupportPage(),
//         '/payment': (context) => const PaymentMethodsPage(),
//       },
//     );
//   }
// }

// class OnboardingPage {
//   const OnboardingPage();
// }


// class NavigationExample extends StatelessWidget {
//   const NavigationExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Navigation Example')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
            
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const LandingPage(),
//                   ),
//                 );
//               },
//               child: const Text('Go to Landing Page (Direct)'),
//             ),
            
//             const SizedBox(height: 20),
            
//             // Method 2: Named route navigation
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/landing');
//               },
//               child: const Text('Go to Landing Page (Named Route)'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




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

  // Method to check if onboarding should be shown
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
      
      // Fix: Complete the FutureBuilder implementation
      home: FutureBuilder<bool>(
        future: _shouldShowOnboarding(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // Fix: Add the missing logic for onboarding
          if (snapshot.hasData && snapshot.data == true) {
            return const OnboardingPage(); // Show onboarding if needed
          } else {
            return const LandingPage(); // Show landing page if onboarding is complete
          }
        },
      ),
      
      // Fix: Remove the commented out routes section and implement properly
      routes: {
        '/landing': (context) => const LandingPage(), // Fix: Added missing '/landing' route
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/help': (context) => const HelpSupportPage(),
        '/payment': (context) => const PaymentMethodsPage(),
      },
    );
  }
}

// Fix: Implement the OnboardingPage class properly
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
            Text(
              'Welcome to Bike Go!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Your bike sharing journey starts here'),
            SizedBox(height: 40),
            // Add onboarding content here
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Mark onboarding as complete
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('onboarding_complete', true);
          
          // Navigate to landing page
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/landing');
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
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