import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'emergency_contacts_screen.dart';
import 'mental_health_screen.dart';
import 'chat_screen.dart';
import 'relax_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[300]!,
              Colors.purple[200]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Lottie.asset(
                'assets/animations/welcome.json',
                height: 150,
                repeat: true,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Welcome to\nMental Health Support',
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: [
                      Colors.white,
                      Colors.blue,
                      Colors.purple,
                      Colors.white,
                    ],
                    textAlign: TextAlign.center,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: AnimationLimiter(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        _buildMenuItem(
                          context,
                          'Mental Health Check',
                          'Track your mental well-being',
                          Icons.favorite,
                          const Color(0xFFFF7171),
                          'assets/images/mental_health.jpg',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MentalHealthScreen(),
                            ),
                          ),
                        ),
                        _buildMenuItem(
                          context,
                          'Emergency Contacts',
                          'Quick access to help',
                          Icons.phone,
                          const Color(0xFF4CAF50),
                          'assets/images/emergency.jpg',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmergencyContactsScreen(),
                            ),
                          ),
                        ),
                        _buildMenuItem(
                          context,
                          'Chat with AI',
                          'Get support anytime',
                          Icons.chat,
                          const Color(0xFF2196F3),
                          'assets/images/chat.jpg',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChatScreen(),
                            ),
                          ),
                        ),
                        _buildMenuItem(
                          context,
                          'Relax Yourself',
                          'Music and games for peace',
                          Icons.spa,
                          const Color(0xFF9C27B0),
                          'assets/images/relax.jpg',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RelaxScreen(),
                            ),
                          ),
                        ),
                        _buildMenuItem(
                          context,
                          'Settings',
                          'Customize your experience',
                          Icons.settings,
                          const Color(0xFF607D8B),
                          'assets/images/settings.jpg',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
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
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String imagePath,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withOpacity(0.7),
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
