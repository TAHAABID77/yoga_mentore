import 'package:flutter/material.dart';
import 'main_layout.dart';

/// Screen handling both Login and Sign-up functionality
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Toggle between Login and Sign-up forms
  bool isLogin = true;

  // Global keys for form validation
  final _loginKey = GlobalKey<FormState>();
  final _signupKey = GlobalKey<FormState>();

  // Visibility states for password fields
  bool _loginObscure = true;
  bool _signupObscure = true;
  bool _confirmObscure = true;

  // Controllers for text input fields
  final TextEditingController _loginEmail = TextEditingController();
  final TextEditingController _signupName = TextEditingController();
  final TextEditingController _signupPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Main background gradient for the auth screen
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF102213), Color(0xFF19331E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: const Color(0xFF162D1B),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Yoga Mentor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Conditionally show either Login or Signup form
                  isLogin ? _loginForm() : _signupForm(),
                  const SizedBox(height: 20),
                  // Toggle button to switch between Login and Signup
                  GestureDetector(
                    onTap: () {
                      setState(() => isLogin = !isLogin);
                    },
                    child: Text(
                      isLogin
                          ? "Don’t have an account? Sign Up"
                          : "Already have an account? Sign In",
                      style: const TextStyle(
                        color: Color(0xFF13ec37),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- LOGIN FORM ----------------
  Widget _loginForm() {
    return Form(
      key: _loginKey,
      child: Column(
        children: [
          _field(
            hint: "Email Address",
            icon: Icons.email,
            controller: _loginEmail,
            validator: (v) =>
                v == null || !v.contains("@") ? "Enter valid email" : null,
          ),
          const SizedBox(height: 16),
          _field(
            hint: "Password",
            icon: Icons.lock,
            obscure: _loginObscure,
            toggle: () => setState(() => _loginObscure = !_loginObscure),
            validator: (v) =>
                v == null || v.length < 6 ? "Minimum 6 characters" : null,
          ),
          const SizedBox(height: 24),
          _mainButton("Login", () {
            // Basic validation check before navigation
            if (_loginKey.currentState!.validate()) {
              final name = _loginEmail.text.split('@')[0];
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MainLayout(userName: name)),
              );
            }
          }),
          _divider(),
          _googleAppleButtons(),
        ],
      ),
    );
  }

  // ---------------- SIGN UP FORM ----------------
  Widget _signupForm() {
    return Form(
      key: _signupKey,
      child: Column(
        children: [
          _field(
            hint: "Full Name",
            icon: Icons.person,
            controller: _signupName,
            validator: (v) => v == null || v.isEmpty ? "Enter your name" : null,
          ),
          const SizedBox(height: 16),
          _field(
            hint: "Email Address",
            icon: Icons.email,
            validator: (v) =>
                v == null || !v.contains("@") ? "Enter valid email" : null,
          ),
          const SizedBox(height: 16),
          _field(
            hint: "Password",
            icon: Icons.lock,
            controller: _signupPass,
            obscure: _signupObscure,
            toggle: () => setState(() => _signupObscure = !_signupObscure),
            validator: (v) =>
                v == null || v.length < 6 ? "Minimum 6 characters" : null,
          ),
          const SizedBox(height: 16),
          _field(
            hint: "Confirm Password",
            icon: Icons.lock_outline,
            obscure: _confirmObscure,
            toggle: () => setState(() => _confirmObscure = !_confirmObscure),
            validator: (v) =>
                v != _signupPass.text ? "Password not match" : null,
          ),
          const SizedBox(height: 24),
          _mainButton("Create Account", () {
            // Validate sign-up details
            if (_signupKey.currentState!.validate()) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MainLayout(userName: _signupName.text),
                ),
              );
            }
          }),
          _divider(),
          _googleAppleButtons(),
        ],
      ),
    );
  }

  // ---------------- UI UTILITIES ----------------
  
  /// Reusable primary button component
  Widget _mainButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF13ec37),
          foregroundColor: const Color(0xFF102213),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  /// Divider with 'OR' text for alternative login methods
  Widget _divider() {
    return const Column(
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.white24)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("OR", style: TextStyle(color: Colors.white54)),
            ),
            Expanded(child: Divider(color: Colors.white24)),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  /// Social authentication buttons (currently Google only)
  Widget _googleAppleButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF13ec37)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              // Social login placeholder
            },
            icon: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/512px-Google_2015_logo.svg.png",
              height: 20,
            ),
            label: const Text("Continue with Google"),
          ),
        ),
      ],
    );
  }

  /// Reusable text input field with validation and styling
  Widget _field({
    required String hint,
    required IconData icon,
    TextEditingController? controller,
    bool obscure = false,
    VoidCallback? toggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF13ec37)),
        suffixIcon: toggle != null
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white54,
                ),
                onPressed: toggle,
              )
            : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF19331E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Color(0xFF13ec37)),
      ),
    );
  }
}
