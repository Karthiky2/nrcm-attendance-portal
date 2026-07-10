import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'year_branch_section_screen.dart';

/// STEP 1: Updated Login page designed like the college website.
///
/// References the design shown in image_0.png.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 500)); // fake network delay

    // TODO: Replace with your real authentication check.
    final id = _idController.text.trim();
    final pass = _passwordController.text.trim();
    final isValid = id.isNotEmpty && pass.isNotEmpty;

    setState(() => _loading = false);

    if (isValid) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const YearBranchSectionScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Faculty ID and Password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine colors
    final Color primaryMaroon = AppTheme.primary; // Use AppTheme's primary maroon color
    const Color inputTextColor = Colors.black87;
    const Color inputLabelColor = Colors.black54;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Full-screen Background Campus Image (from image_0.png)
          Positioned.fill(
            child: Image.asset(
              'assets/images/college_campus.jpg', // Placeholder, needs actual image asset
              fit: BoxFit.cover,
            ),
          ),

          // 2. Content Column over the image
          Column(
            children: [
              // a. The White Logo & Accreditation Header
              _buildHeaderSection(primaryMaroon),

              // b. Translucent Login Card (The main focus)
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                    child: _buildLoginCard(primaryMaroon, inputTextColor, inputLabelColor),
                  ),
                ),
              ),

              // c. The Maroon Footer with Copyright
              _buildFooterSection(primaryMaroon),
            ],
          ),

          // d. "Get in touch" ribbon element (above footer)
          Positioned(
            bottom: 60, // Above the footer
            left: 10,
            child: _buildGetInTouchButton(primaryMaroon),
          ),
        ],
      ),
    );
  }

  // -- Widget Building Helpers --

  // 1. Header Section with Logos and Text
  Widget _buildHeaderSection(Color maroon) {
    return Container(
      color: Colors.white.withOpacity(0.95), // Slight opacity for a glass look
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // College Logo and Title Column
          Row(
            children: [
              // Can add the specific NRC-M logo here from assets
              Container(
                width: 60,
                height: 60,
                color: maroon, // Placeholder
                child: const Icon(Icons.school_outlined, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NARSHIMA REDDY',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: maroon,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'ENGINEERING COLLEGE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: maroon,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'An Autonomous Institution | Affiliated to JNTUH | Approved by AICTE\nAccredited by NBA & NAAC with \'A\' Grade',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Accreditation Logos Row (Simplify from image_0.png)
          Row(
            children: [
              // Placeholder icons for accreditation
              _accreditationIcon(Icons.verified),
              _accreditationIcon(Icons.gavel),
              _accreditationIcon(Icons.thumb_up),
              _accreditationIcon(Icons.insert_chart),
              const SizedBox(width: 8),
              const Text(
                'RANKED\nTOP',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Simplified helper for small accreditation icons
  Widget _accreditationIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        child: Icon(icon, color: Colors.black54, size: 20),
      ),
    );
  }

  // 2. The main Translucent Login Card
  Widget _buildLoginCard(Color maroon, Color inputTextColor, Color labelColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85), // Translucent card background
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // a. Solid Maroon Header with Text
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: maroon,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const Text(
                'EMPLOYEE LOGIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // b. Login Form Content (Inputs and Button)
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Styled with borderless line style from image_0.png
                  _buildLineTextField(
                    controller: _idController,
                    label: 'Employee ID',
                    icon: Icons.person_outline,
                    maroon: maroon,
                    textColor: inputTextColor,
                    labelColor: labelColor,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter ID' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildLineTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    maroon: maroon,
                    textColor: inputTextColor,
                    labelColor: labelColor,
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter Password' : null,
                  ),
                  const SizedBox(height: 20),

                  // c. Remember me & Forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            activeColor: maroon,
                            onChanged: (v) => setState(() => _rememberMe = v!),
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {}, // TODO: Handle forgot password
                        child: Text(
                          'Forgot password ?',
                          style: TextStyle(color: maroon, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // d. Maroon Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maroon,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                      ),
                      child: _loading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ),
                  ),

                  // e. Admin Helper Text and Button
                  const SizedBox(height: 28),
                  Column(
                    children: [
                      Text(
                        'Are you an Admin Staff?',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      // Small Maroon Button
                      SizedBox(
                        width: 140,
                        height: 36,
                        child: ElevatedButton(
                          onPressed: () {}, // TODO: Handle Admin login
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maroon,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          ),
                          child: const Text('Click here', style: TextStyle(fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for borderless line-style text field
  Widget _buildLineTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    required Color maroon,
    required Color textColor,
    required Color labelColor,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && _obscure,
      style: TextStyle(color: textColor, fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labelColor, fontSize: 15),
        floatingLabelStyle: TextStyle(color: maroon, fontSize: 13),
        prefixIcon: Icon(icon, color: maroon.withOpacity(0.7)),
        // Line-style border (borderless)
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]!)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]!)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: maroon, width: 2)),
        // Optional suffix icon for password visibility
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
          onPressed: () => setState(() => _obscure = !_obscure),
        )
            : null,
      ),
      validator: validator,
    );
  }

  // 3. The Maroon Footer with Copyright
  Widget _buildFooterSection(Color maroon) {
    return Container(
      color: maroon,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: const Text(
        'Copy rights @ 2024 | Crafted and Developed by D Srinivas',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Colors.white70),
      ),
    );
  }

  // 4. "Get in touch" Floating-like button
  Widget _buildGetInTouchButton(Color maroon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: maroon,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4, offset: const Offset(2, 2)),
        ],
      ),
      child: const Text(
        'Get in touch',
        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }
}