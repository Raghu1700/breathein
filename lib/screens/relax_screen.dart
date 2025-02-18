import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RelaxScreen extends StatelessWidget {
  const RelaxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal[300]!,
              Colors.blue[200]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Relax Yourself',
                      textStyle: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      colors: [
                        Colors.white,
                        Colors.blue,
                        Colors.purple,
                        Colors.white,
                      ],
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ),
              Expanded(
                child: AnimationLimiter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 600),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          _buildSection(
                            context,
                            'Relaxing Music',
                            Icons.music_note,
                            Colors.purple,
                            () => _showMusicList(context),
                          ),
                          const SizedBox(height: 20),
                          _buildSection(
                            context,
                            'Games',
                            Icons.games,
                            Colors.orange,
                            () => _showGamesList(context),
                          ),
                        ],
                      ),
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

  Widget _buildSection(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 180,
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
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap to explore',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMusicList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: AnimationLimiter(
          child: ListView(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Relaxing Music',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                _buildMusicListTile(
                  'Peaceful Piano',
                  'Relaxing piano music for meditation',
                  'https://open.spotify.com/playlist/37i9dQZF1DX4sWSpwq3LiO',
                ),
                _buildMusicListTile(
                  'Nature Sounds',
                  'Calming nature sounds for relaxation',
                  'https://open.spotify.com/playlist/37i9dQZF1DX4PP3DA4J0N8',
                ),
                _buildMusicListTile(
                  'Deep Focus',
                  'Instrumental concentration music',
                  'https://open.spotify.com/playlist/37i9dQZF1DX3PFzdbtx1Us',
                ),
                _buildMusicListTile(
                  'Sleep',
                  'Soothing music for better sleep',
                  'https://open.spotify.com/playlist/37i9dQZF1DWZd79rJ6a7lp',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showGamesList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: AnimationLimiter(
          child: ListView(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Relaxing Games',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                _buildGameListTile(
                  'Zen Garden',
                  'Create your own peaceful garden',
                  'https://play.google.com/store/apps/details?id=com.dustflux.zengarden',
                ),
                _buildGameListTile(
                  'Color Therapy',
                  'Relaxing coloring book for adults',
                  'https://play.google.com/store/apps/details?id=com.colortherapy',
                ),
                _buildGameListTile(
                  'Flow Free',
                  'Calming puzzle game',
                  'https://play.google.com/store/apps/details?id=com.bigduckgames.flow',
                ),
                _buildGameListTile(
                  'Alto\'s Adventure',
                  'Serene endless runner game',
                  'https://play.google.com/store/apps/details?id=com.noodlecake.altosadventure',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMusicListTile(String title, String subtitle, String url) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.music_note,
          color: Colors.purple,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(
        Icons.play_arrow,
        color: Colors.purple,
      ),
      onTap: () => _launchURL(url),
    );
  }

  Widget _buildGameListTile(String title, String subtitle, String url) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.games,
          color: Colors.orange,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(
        Icons.arrow_forward,
        color: Colors.orange,
      ),
      onTap: () => _launchURL(url),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }
}
