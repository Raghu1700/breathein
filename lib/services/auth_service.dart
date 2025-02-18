import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService with ChangeNotifier {
  final supabase = Supabase.instance.client;
  
  User? get currentUser => supabase.auth.currentUser;
  String? get phoneNumber => currentUser?.phone;
  
  // Phone number authentication
  Future<void> signInWithPhone(String phone) async {
    try {
      await supabase.auth.signInWithOtp(
        phone: phone,
        shouldCreateUser: true,
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Verify OTP
  Future<bool> verifyOTP(String phone, String token) async {
    try {
      final AuthResponse response = await supabase.auth.verifyOTP(
        phone: phone,
        token: token,
        type: OtpType.sms,
      );
      if (response.session != null) {
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Google Sign In
  Future<bool> signInWithGoogle() async {
    try {
      if (!await supabase.auth.signInWithOAuth(
        Provider.google,
        redirectTo: kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      )) {
        return false;
      }
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  bool isLoggedIn() {
    return supabase.auth.currentUser != null;
  }

  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
}
