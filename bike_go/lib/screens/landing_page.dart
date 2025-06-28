import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';
import 'signup_page.dart';
// import 'about_us.dart';           // Pour Features
import 'help_support_page.dart'; // Pour How It Works
import 'payment_methods_page.dart';    // Pour Pricing

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FDF8),
      drawer: isMobile ? _buildDrawer(context) : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: isMobile,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.directions_bike, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              'Bike Go',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E3A59),
              ),
            ),
          ],
        ),
        actions: isMobile
            ? null
            : [
                _buildNavItem(context, 'About Us'),
                const SizedBox(width: 24),
                _buildNavItem(context, 'Help'),
                const SizedBox(width: 24),
                _buildNavItem(context, 'Payment method'),
                const SizedBox(width: 24),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF4CAF50)),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(width: 16),
              ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight - kToolbarHeight),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildHeroSection(context, isMobile),
                    const SizedBox(height: 60),
                    _buildFeaturesSection(context, isMobile),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Widget? page;
        switch (title) {
          case 'About Us':
            // page = const AboutUs();
            break;
          case 'Help':
            page = const HelpSupportPage();
            break;
          case 'Payment method':
            page = const PaymentMethodsPage();
            break;
          default:
            page = null;
        }

        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page!),
          );
        }
      },
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF4CAF50),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF4CAF50)),
            child: Text(
              'Bike Go Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.featured_play_list),
          //   title: const Text('About Us'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   //   Navigator.push(context,
          //   //       // MaterialPageRoute(builder: (_) => const AboutUs()));
          //   // },
          // ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Help'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HelpSupportPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Payment method'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PaymentMethodsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Sign Up'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Column(
      children: [
        Text(
          'Fast, Eco-Friendly',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 32 : 56,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2E3A59),
          ),
        ),
        Text(
          'Bike Transportation',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 32 : 56,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Book rides, send packages, and connect with riders\nfor affordable, green transport in busy cities.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 16 : 20,
            color: const Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(Icons.person, color: Colors.white),
              label: Text(
                'Book a Ride',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(BuildContext context, bool isMobile) {
    return Column(
      children: [
        Text(
          'Why Choose Bike Go?',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2E3A59),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            _buildFeatureItem(Icons.shield_outlined, 'Protected Rides', 'Stay dry and comfortable in any weather'),
            const SizedBox(height: 16),
            _buildFeatureItem(Icons.star_outline, 'Premium Comfort', 'Enhanced experience during harsh conditions'),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF4CAF50)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: const Color(0xFF2E3A59),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


 }
