import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  
  final List<TeamMember> teamMembers = [
    TeamMember(
      id: 1,
      name: "FINAMOU ABDOUL",
      role: "Scrum Mistress",
      bio: "Tech Enthusiast passionate about sustainable transportation and building communities .",
      imagePath: "assets/images/finamou.jpg", 
    ),
    TeamMember(
      id: 2,
      name: "PRECIOUS MALOBA",
      role: "Product Owner",
      bio: "Tech enthusiast focused on creating seamless user experiences for urban mobility.",
      imagePath: "assets/images/precious.jpg", 
    ),
    TeamMember(
      id: 3,
      name: "Cheriviane Kaina",
      role: "Front/Backend Developper",
      bio: "Tech Enthusiast ensuring smooth rides and reliable service across all our partner cities.",
      imagePath: "assets/images/cheriviane.jpg",
    ),
  ];

  final List<CompanyValue> values = [
    CompanyValue(
      icon: Icons.track_changes,
      title: "Sustainability First",
      description: "We're committed to reducing urban carbon footprints through accessible bike transportation.",
    ),
    CompanyValue(
      icon: Icons.people,
      title: "Community Driven",
      description: "Building connections between riders and creating stronger, more connected cities.",
    ),
    CompanyValue(
      icon: Icons.favorite,
      title: "Health & Wellness",
      description: "Promoting active lifestyles while providing convenient transportation solutions.",
    ),
    CompanyValue(
      icon: Icons.directions_bike,
      title: "Innovation",
      description: "Continuously improving our platform to deliver the best riding experience.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            _buildHeader(context),
            
            // Hero Section
            _buildHeroSection(),
            
            // Our Story Section
            _buildOurStorySection(),
            
            // Our Values Section
            _buildValuesSection(),
            
            // Meet Our Team Section
            _buildTeamSection(),
            
            // Call to Action Section
            _buildCallToActionSection(),
            
            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.directions_bike,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Bike Go',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            
            if (MediaQuery.of(context).size.width > 600)
              Row(
                children: [
                  _buildNavItem('How It Works'),
                  _buildNavItem('Pricing'),
                  _buildNavItem('About Us', isActive: true),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.green[500] : Colors.grey[600],
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              children: [
                const TextSpan(text: 'About '),
                TextSpan(
                  text: 'Bike Go',
                  style: TextStyle(color: Colors.green[500]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "We're revolutionizing urban transportation by connecting communities through fast, eco-friendly bike sharing. Our mission is to make cities more livable, sustainable, and connected—one ride at a time.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOurStorySection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text(
            'Our Story',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Founded in Cameroon by a group of level two students from ICT University, Bike Go started with a simple idea: what if getting around the city could be faster, cleaner, and more fun?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "We're building a platform that connects riders for shared journeys and package delivery, making urban transportation more sustainable and community-driven.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text(
            'Our Values',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'The principles that guide everything we do',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
              if (constraints.maxWidth < 600) crossAxisCount = 1;
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: values.length,
                itemBuilder: (context, index) {
                  return _buildValueCard(values[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(CompanyValue value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              value.icon,
              size: 32,
              color: Colors.green[500],
            ),
            const SizedBox(height: 16),
            Text(
              value.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamSection() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text(
            'Meet Our Team',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'The passionate people making Bike Go possible',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 900 ? 3 : 1;
              if (constraints.maxWidth > 600 && constraints.maxWidth <= 900) {
                crossAxisCount = 2;
              }
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.7,
                ),
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  return _buildTeamMemberCard(teamMembers[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(TeamMember member) {
    return Card(
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: _buildMemberImage(member),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              member.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              member.role,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.green[600],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              member.bio,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberImage(TeamMember member) {
    // For placeholder, show initials. Replace with actual image when available
    String initials = member.name.split(' ').map((name) => name[0]).join('');
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[300]!, Colors.green[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
    
    // To use actual images, uncomment below and comment above:
    /*
    return Image.asset(
      member.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.green[500],
          child: Center(
            child: Text(
              initials,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
    */
  }

  Widget _buildCallToActionSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[500]!, Colors.green[600]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text(
            'Ready to Join the Movement?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Experience the future of urban transportation. Book your first ride today!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Handle book ride action
            },
            icon: const Text('📱'),
            label: const Text('Book a Ride'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green[600],
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.directions_bike,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Bike Go',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '© 2025 Bike Go. All rights reserved. | Making cities more connected, one ride at a time.',
            style: TextStyle(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Data Models
class TeamMember {
  final int id;
  final String name;
  final String role;
  final String bio;
  final String imagePath;

  TeamMember({
    required this.id,
    required this.name,
    required this.role,
    required this.bio,
    required this.imagePath,
  });
}

class CompanyValue {
  final IconData icon;
  final String title;
  final String description;

  CompanyValue({
    required this.icon,
    required this.title,
    required this.description,
  });
}