import 'package:bike_go/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart' as image_picker; 
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Sample user data
  final String _userName = "John Doe"; // This name is used in the profile header
  final String _userEmail = "john.doe@example.com"; // This email is used in the account section
  final String _memberSince = "May 2023"; // This date is used in the profile header
  final int _totalRides = 47; // This value is used in the stats section
  final double _totalDistance = 152.8; // This value is used in the stats section
  final int _co2Saved = 38; // This value is used in the stats section
  
  // Toggle switches
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _darkModeEnabled = false;
  
  // Profile image
  File? _profileImage;
  final image_picker.ImagePicker _picker = image_picker.ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _loadProfileImage();
    
    // Initialize dark mode from ThemeProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _darkModeEnabled = Provider.of<ThemeProvider>(context, listen: false).isDarkMode; 
      });
    });
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _locationEnabled = prefs.getBool('location_enabled') ?? true;
      _darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', _notificationsEnabled);
    await prefs.setBool('location_enabled', _locationEnabled);
    await prefs.setBool('dark_mode_enabled', _darkModeEnabled);
  }

  Future<void> _loadProfileImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/profile_image.jpg';
    final file = File(imagePath);
    
    if (await file.exists()) {
      setState(() {
        _profileImage = file;
      });
    }
  }

  Future<void> _saveProfileImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/profile_image.jpg';
    
    // Copy the image to app documents directory
    await image.copy(imagePath);
    
    setState(() {
      _profileImage = File(imagePath);
    });
  }

  Future<void> _pickImage() async {
    final image_picker.XFile? image = await _picker.pickImage(source: image_picker.ImageSource.gallery);
    
    if (image != null) {
      await _saveProfileImage(File(image.path));
    }
  }

  Future<void> _takePhoto() async {
    final image_picker.XFile? photo = await _picker.pickImage(source: image_picker.ImageSource.camera);
    
    if (photo != null) {
      await _saveProfileImage(File(photo.path));
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF22C55E)),
                title: Text(
                  'Choose from Gallery',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF22C55E)),
                title: Text(
                  'Take a Photo',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              if (_profileImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Color(0xFFEF4444)),
                  title: Text(
                    'Remove Photo',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath = '${directory.path}/profile_image.jpg';
                    final file = File(imagePath);
                    
                    if (await file.exists()) {
                      await file.delete();
                    }
                    
                    setState(() {
                      _profileImage = null;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _toggleDarkMode(bool value) async {
    // Update the ThemeProvider
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
    
    setState(() {
      _darkModeEnabled = value;
    });
    
    await _savePreferences();
  }

  Future<void> _logout() async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Sign Out',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Sign Out',
              style: GoogleFonts.inter(),
            ),
          ),
        ],
      ),
    );
    
    if (shouldLogout == true) {
      // Clear user session
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_token'); // Remove auth token
      
      // Navigate to login screen
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context, 
          '/login', 
          (route) => false, // Clear all routes
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // App bar with profile header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF22C55E),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      // Profile picture
                      GestureDetector(
                        onTap: _showImagePickerOptions,
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                color: Colors.white,
                                image: _profileImage != null
                                    ? DecorationImage(
                                        image: FileImage(_profileImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: _profileImage == null
                                  ? Center(
                                      child: Text(
                                        _getInitials(_userName),
                                        style: GoogleFonts.inter(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF22C55E),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF22C55E),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 14,
                                  color: Color(0xFF22C55E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // User name
                      Text(
                        _userName,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Member since
                      Text(
                        'Member since $_memberSince',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withAlpha(230),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  // Navigate to edit profile
                },
              ),
            ],
          ),
          
          // Profile content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats cards
                  _buildStatsSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Account section
                  _buildSectionHeader('Account'),
                  _buildAccountSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Preferences section
                  _buildSectionHeader('Preferences'),
                  _buildPreferencesSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Support section
                  _buildSectionHeader('Support'),
                  _buildSupportSection(),
                  
                  const SizedBox(height: 24),
                  
                  // Sign out button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _logout,
                      icon: const Icon(
                        Icons.logout,
                        color: Color(0xFFEF4444),
                      ),
                      label: Text(
                        'Sign Out',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFEF4444), // Red color
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // App version
                  Center(
                    child: Text(
                      'Bike Go v1.0.0',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1F2937),
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6B7280),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF22C55E),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13), // 5% opacity
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSwitchItem(
            icon: Icons.notifications,
            title: 'Notifications',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              _savePreferences();
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSwitchItem(
            icon: Icons.location_on,
            title: 'Location Services',
            value: _locationEnabled,
            onChanged: (value) {
              setState(() {
                _locationEnabled = value;
              });
              _savePreferences();
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSwitchItem(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            value: _darkModeEnabled,
            onChanged: _toggleDarkMode,
          ),
          const Divider(height: 1, indent: 56),
          _buildSettingsItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English (US)',
            onTap: () {
              // Navigate to language settings
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13), // 5% opacity
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'FAQs and user guides',
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSettingsItem(
            icon: Icons.support_agent,
            title: 'Contact Support',
            subtitle: 'Get help with your account',
            onTap: () {
              // Navigate to contact support
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSettingsItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'How we handle your data',
            onTap: () {
              // Navigate to privacy policy
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF6B7280),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFFD1D5DB),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: _userEmail,
            onTap: () {
              // Email settings or verification
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSettingsItem(
            icon: Icons.lock_outline,
            title: 'Password',
            subtitle: 'Change your password',
            onTap: () {
              // Navigate to password change
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSettingsItem(
            icon: Icons.payment,
            title: 'Payment Methods',
            subtitle: 'Manage your payment options',
            onTap: () {
              Navigator.pushNamed(context, '/payment');
            },
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    if (nameParts.length > 1) {
      return nameParts[0][0] + nameParts[1][0];
    } else if (nameParts.length == 1 && nameParts[0].isNotEmpty) {
      return nameParts[0][0];
    }
    return '';
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            value: _totalRides.toString(),
            label: 'Rides',
            icon: Icons.pedal_bike,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            value: '${_totalDistance.toStringAsFixed(1)} km',
            label: 'Distance',
            icon: Icons.straighten,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            value: '$_co2Saved kg',
            label: 'CO₂ Saved',
            icon: Icons.eco,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF22C55E),
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}


