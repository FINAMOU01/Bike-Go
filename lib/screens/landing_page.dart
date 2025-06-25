 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FDF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Section
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.directions_bike,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Bike Go',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E3A59),
                        ),
                      ),
                    ],
                  ),
                  // Navigation Menu
                  Row(
                    children: [
                      _buildNavItem('Features'),
                      const SizedBox(width: 32),
                      _buildNavItem('How It Works'),
                      const SizedBox(width: 32),
                      _buildNavItem('Pricing'),
                      const SizedBox(width: 32),
                      // Login Button
                      OutlinedButton(
                        onPressed: () {
                          // Handle login
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF4CAF50)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Sign Up Button
                      ElevatedButton(
                        onPressed: () {
                          // Handle sign up
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 80),
            
            // Hero Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  // Main Heading
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Fast, Eco-Friendly\n',
                          style: GoogleFonts.poppins(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E3A59),
                            height: 1.1,
                          ),
                        ),
                        TextSpan(
                          text: 'Bike Transportation',
                          style: GoogleFonts.poppins(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4CAF50),
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Subtitle
                  Text(
                    'Book rides, send packages, and connect with nearby bike riders for affordable, green\ntransport in busy cities. Beat the traffic with Bike Go!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: const Color(0xFF6B7280),
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // CTA Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Book a Ride Button
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle book a ride
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Text(
                          'Book a Ride',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                      
                      const SizedBox(width: 24),
                      
                      // Become a Rider Button
                      OutlinedButton.icon(
                        onPressed: () {
                          // Handle become a rider
                        },
                        icon: const Icon(
                          Icons.directions_bike,
                          color: Color(0xFF4CAF50),
                          size: 20,
                        ),
                        label: Text(
                          'Become a Rider',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF4CAF50),
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 120),
            
            // Cloud Illustration Section
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF8FDF8),
                    Color(0xFFE3F2FD),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 15,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xFF64B5F6),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 25,
                        top: 10,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: const BoxDecoration(
                            color: Color(0xFF42A5F5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 45,
                        bottom: 15,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Color(0xFF90CAF9),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: const Color(0xFF6B7280),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}




  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),
            
            // Hero Section
            _buildHeroSection(context),
            
            // Features Section
            _buildFeaturesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.directions_bike,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Bike Go',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Navigation Menu (Desktop)
          if (MediaQuery.of(context).size.width > 768) ...[
            _buildNavItem('Features'),
            const SizedBox(width: 32),
            _buildNavItem('How It Works'),
            const SizedBox(width: 32),
            _buildNavItem('Pricing'),
            const SizedBox(width: 32),
            
            // Login Button
            TextButton(
              onPressed: () {
                // Navigate to login
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFF22C55E)),
                ),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF22C55E),
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Sign Up Button
            ElevatedButton(
              onPressed: () {
                // Navigate to sign up
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Sign Up',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ] else ...[
            // Mobile Menu Button
            IconButton(
              onPressed: () {
                // Show mobile menu
              },
              icon: const Icon(Icons.menu),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItem(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF6B7280),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 80),
          
          // Cloud Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.cloud,
              size: 60,
              color: Color(0xFF3B82F6),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Main Title
          Text(
            'Weather-Smart Matching',
            style: GoogleFonts.inter(
              fontSize: MediaQuery.of(context).size.width > 768 ? 48 : 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 24),
          
          // Subtitle
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Our unique weather detection system automatically matches you with riders equipped with umbrellas and protective gear during bad weather.',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          // Features Grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 768) {
                // Desktop Layout
                return Row(
                  children: [
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.shield_outlined,
                      iconColor: const Color(0xFF22C55E),
                      title: 'Protected Rides',
                      description: 'Stay dry and comfortable in any weather',
                    )),
                    const SizedBox(width: 32),
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.flash_on,
                      iconColor: const Color(0xFFF59E0B),
                      title: 'Smart Detection',
                      description: 'AI-powered weather monitoring',
                    )),
                    const SizedBox(width: 32),
                    Expanded(child: _buildFeatureCard(
                      icon: Icons.star_outline,
                      iconColor: const Color(0xFF3B82F6),
                      title: 'Premium Comfort',
                      description: 'Enhanced experience for challenging weather',
                    )),
                  ],
                );
              } else {
                // Mobile Layout
                return Column(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.shield_outlined,
                      iconColor: const Color(0xFF22C55E),
                      title: 'Protected Rides',
                      description: 'Stay dry and comfortable in any weather',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      icon: Icons.flash_on,
                      iconColor: const Color(0xFFF59E0B),
                      title: 'Smart Detection',
                      description: 'AI-powered weather monitoring',
                    ),
                    const SizedBox(height: 24),
                    _buildFeatureCard(
                      icon: Icons.star_outline,
                      iconColor: const Color(0xFF3B82F6),
                      title: 'Premium Comfort',
                      description: 'Enhanced experience for challenging weather',
                    ),
                  ],
                );
              }
            },
          ),
          
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 32,
              color: iconColor,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Title
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 12),
          
          // Description
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
