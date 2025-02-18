import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isLoading = false;
  bool _showOtpField = false;
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Mental Health Support',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                enabled: !_showOtpField,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number with country code',
                  border: OutlineInputBorder(),
                ),
              ),
              if (_showOtpField) ...[
                const SizedBox(height: 20),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'OTP',
                    hintText: 'Enter the OTP sent to your phone',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _handlePhoneAuth,
                  child: Text(_showOtpField ? 'Verify OTP' : 'Send OTP'),
                ),
              if (!_showOtpField) ...[
                const SizedBox(height: 20),
                const Text('OR', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _handleGoogleSignIn,
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePhoneAuth() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    try {
      if (!_showOtpField) {
        // Send OTP
        if (_phoneController.text.isEmpty) {
          _showError('Please enter a phone number');
          return;
        }

        _phoneNumber = _phoneController.text;
        await context.read<AuthService>().signInWithPhone(_phoneNumber!);
        setState(() => _showOtpField = true);
        _showMessage('OTP sent successfully!');
      } else {
        // Verify OTP
        if (_otpController.text.isEmpty) {
          _showError('Please enter the OTP');
          return;
        }

        final success = await context.read<AuthService>().verifyOTP(
          _phoneNumber!,
          _otpController.text,
        );

        if (success && mounted) {
          _navigateToHome();
        } else if (mounted) {
          _showError('Invalid OTP. Please try again.');
        }
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    try {
      final success = await context.read<AuthService>().signInWithGoogle();
      if (success && mounted) {
        _navigateToHome();
      } else if (mounted) {
        _showError('Google sign in failed. Please try again.');
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
