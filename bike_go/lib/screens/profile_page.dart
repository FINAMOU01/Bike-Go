import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';
  String _userEmail = '';
  String _memberSince = 'June 2025'; // Optionnel ou calculable
  int _totalRides = 12; // Valeur fictive
  double _totalDistance = 87.5; // Valeur fictive
  int _co2Saved = 20; // Valeur fictive

  // Nouvelles variables pour les préférences utilisateur
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? 'User';
      _userEmail = prefs.getString('user_email') ?? 'example@example.com';
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _locationEnabled = prefs.getBool('location_enabled') ?? true;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF22C55E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF22C55E),
              child: Text(
                _userName.isNotEmpty ? _userName[0].toUpperCase() : '',
                style: const TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _userName,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _userEmail,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Member since $_memberSince',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 32),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Rides', _totalRides.toString()),
                _buildStatCard('Distance', '${_totalDistance.toStringAsFixed(1)} km'),
                _buildStatCard('CO₂ Saved', '$_co2Saved kg'),
              ],
            ),
            const SizedBox(height: 32),

            // Preferences section
            _buildPreferenceSwitch(
              'Enable Notifications',
              _notificationsEnabled,
              (value) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('notifications_enabled', value);
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildPreferenceSwitch(
              'Enable Location',
              _locationEnabled,
              (value) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('location_enabled', value);
                setState(() {
                  _locationEnabled = value;
                });
              },
            ),
            const SizedBox(height: 32),

            // Logout button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: GoogleFonts.inter(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildPreferenceSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: const Color(0xFF1F2937),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF22C55E),
        ),
      ],
    );
  }
}
