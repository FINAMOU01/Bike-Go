import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage("Veuillez remplir tous les champs.");
      return;
    }

    if (password != confirmPassword) {
      _showMessage("Les mots de passe ne correspondent pas.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/users'), // adapte à ton IP/port
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        _showMessage("Inscription réussie !");
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        _showMessage("Erreur : ${jsonDecode(response.body)['error'] ?? 'Échec de l’inscription'}");
      }
    } catch (e) {
      _showMessage("Erreur réseau : $e");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo + App Name
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFF22C55E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.directions_bike,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Bike Go',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Create an account',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Join Bike Go and start your eco-friendly journey',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 32),

                // Full Name
                _buildLabel('Full Name'),
                _buildTextField(_nameController, 'Enter your full name'),

                const SizedBox(height: 24),

                // Email
                _buildLabel('Email'),
                _buildTextField(_emailController, 'Enter your email', keyboardType: TextInputType.emailAddress),

                const SizedBox(height: 24),

                // Password
                _buildLabel('Password'),
                _buildPasswordField(_passwordController, _obscurePassword, () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                }),
                const SizedBox(height: 8),
                Text(
                  'Must be at least 8 characters',
                  style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF6B7280)),
                ),

                const SizedBox(height: 24),

                // Confirm Password
                _buildLabel('Confirm Password'),
                _buildPasswordField(_confirmPasswordController, _obscureConfirmPassword, () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                }),

                const SizedBox(height: 24),

                // Terms and conditions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF22C55E),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'By creating an account, you agree to our Terms of Service and Privacy Policy',
                        style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF6B7280), height: 1.4),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Sign up button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _agreeToTerms ? () {
                      _registerUser();
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      disabledBackgroundColor: const Color(0xFFAED6B9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Create Account',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF6B7280)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 4),
                      ),
                      child: Text(
                        'Log in',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF22C55E),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF374151),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        filled: true,
        fillColor: Colors.white,
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
          borderSide: const BorderSide(color: Color(0xFF22C55E), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, bool obscureText, VoidCallback toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        filled: true,
        fillColor: Colors.white,
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
          borderSide: const BorderSide(color: Color(0xFF22C55E), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF6B7280),
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }
}
