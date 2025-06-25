import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  // Track expanded FAQ items
  final List<bool> _expandedItems = List.generate(5, (_) => false);
  
  // Selected support category
  String _selectedCategory = 'General';
  
  // Form controllers
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Help & Support',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6B7280)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Support options
              _buildSupportOptions(),
              
              const SizedBox(height: 24),
              
              // FAQs section
              _buildSectionHeader('Frequently Asked Questions'),
              _buildFaqSection(),
              
              const SizedBox(height: 24),
              
              // Contact support section
              _buildSectionHeader('Contact Support'),
              _buildContactForm(),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
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

  Widget _buildSupportOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
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
          _buildSupportOption(
            icon: Icons.book_outlined,
            title: 'User Guide',
            subtitle: 'Learn how to use the app',
            onTap: () {
              // Navigate to user guide
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSupportOption(
            icon: Icons.live_help_outlined,
            title: 'Live Chat',
            subtitle: 'Chat with our support team',
            onTap: () {
              // Open live chat
            },
          ),
          const Divider(height: 1, indent: 56),
          _buildSupportOption(
            icon: Icons.phone_outlined,
            title: 'Call Support',
            subtitle: 'Available 24/7',
            onTap: () {
              // Make a call
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
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
                color: const Color(0xFF22C55E),
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

  Widget _buildFaqSection() {
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
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        dividerColor: const Color(0xFFE5E7EB),
        expansionCallback: (index, isExpanded) {
          setState(() {
            _expandedItems[index] = !isExpanded;
          });
        },
        children: [
          _buildFaqItem(
            0, 
            'How do I rent a bike?',
            'To rent a bike, locate a nearby bike on the map, scan its QR code using the app\'s scanner, and follow the on-screen instructions to unlock it. Your rental will begin immediately after unlocking.'
          ),
          _buildFaqItem(
            1, 
            'How do I end my ride?',
            'To end your ride, park the bike in a designated parking zone shown on the map, lock the bike manually, and tap "End Ride" in the app. You\'ll receive a ride summary and receipt.'
          ),
          _buildFaqItem(
            2, 
            'What if the bike is damaged?',
            'If you notice a bike is damaged before renting, report it through the app and choose another bike. If damage occurs during your ride, contact support immediately through the app.'
          ),
          _buildFaqItem(
            3, 
            'How is the fare calculated?',
            'Fares are calculated based on the duration of your ride. The base fare includes the first 20 minutes, with additional charges per minute thereafter. Premium bikes may have different rates.'
          ),
          _buildFaqItem(
            4, 
            'Can I pause my ride?',
            'Yes, you can pause your ride for up to 30 minutes by tapping the "Pause Ride" button in the app and locking the bike. The bike will remain reserved for you, but a small holding fee may apply.'
          ),
        ],
      ),
    );
  }

  ExpansionPanel _buildFaqItem(int index, String question, String answer) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return ListTile(
          title: Text(
            question,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
        );
      },
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Text(
          answer,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
      ),
      isExpanded: _expandedItems[index],
      canTapOnHeader: true,
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category selector
          Text(
            'Category',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                borderRadius: BorderRadius.circular(8),
                items: ['General', 'Technical Issue', 'Billing', 'Damaged Bike', 'Lost Item']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Subject field
          Text(
            'Subject',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _subjectController,
            decoration: InputDecoration(
              hintText: 'Enter subject',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF22C55E)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Message field
          Text(
            'Message',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _messageController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Describe your issue',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF22C55E)),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Attachment option
          OutlinedButton.icon(
            onPressed: () {
              // Add attachment logic
            },
            icon: const Icon(
              Icons.attach_file,
              size: 18,
              color: Color(0xFF6B7280),
            ),
            label: Text(
              'Add Attachment',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF6B7280),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE5E7EB)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitSupportRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Submit Request',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitSupportRequest() {
    // Validate form
    if (_subjectController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Your request has been submitted',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: const Color(0xFF22C55E),
        duration: const Duration(seconds: 3),
      ),
    );
    
    // Clear form
    _subjectController.clear();
    _messageController.clear();
    setState(() {
      _selectedCategory = 'General';
    });
  }
}