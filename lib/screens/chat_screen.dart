import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[100]!,
              Colors.purple[50]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  'Chat with AI',
                  style: TextStyle(color: Colors.black87),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              if (_messages.isEmpty)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/animations/chat_animation.json',
                        height: 200,
                        repeat: true,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'How are you feeling today?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Start chatting with me, I\'m here to help',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: _buildMessage(_messages[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              if (_isTyping)
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('AI is typing...'),
                      ),
                    ],
                  ),
                ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    final isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[400] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isUser) _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.psychology,
        color: Colors.purple,
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => _handleSubmitted(_controller.text),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    _controller.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isTyping = true;
    });

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(ChatMessage(
            text: _getDefaultResponse(text),
            isUser: false,
          ));
        });
      }
    });
  }

  String _getDefaultResponse(String message) {
    message = message.toLowerCase();
    
    // Check for concerning words first
    if (_containsConcerningWords(message)) {
      return "I understand you're going through a difficult time. Remember that you're not alone, and there are people who care about you. Would you like to talk about what's troubling you? I'm here to listen and help.";
    }
    
    // Greetings
    if (message.contains('hello') || message.contains('hi')) {
      return "Hello! How are you feeling today? I'm here to chat and support you.";
    }

    // Feelings and emotions
    if (message.contains('sad') || message.contains('unhappy') || message.contains('depressed')) {
      return "I'm sorry to hear that you're feeling down. Would you like to talk about what's making you feel this way? Sometimes sharing our feelings can help lighten the burden.";
    }

    if (message.contains('angry') || message.contains('frustrated') || message.contains('mad')) {
      return "It's okay to feel angry sometimes. Would you like to tell me more about what's frustrating you? We can work through these feelings together.";
    }

    if (message.contains('happy') || message.contains('good') || message.contains('great')) {
      return "I'm so glad to hear that! What's making you feel good today? It's wonderful to celebrate positive moments.";
    }

    if (message.contains('tired') || message.contains('exhausted') || message.contains('sleepy')) {
      return "Being tired can really affect our mood and thoughts. Have you been getting enough rest? We can talk about ways to improve your sleep routine.";
    }

    // Questions about feelings
    if (message.contains('how') && message.contains('feel')) {
      return "I'm here to listen and support you. How are YOU feeling? I'd love to hear more about your day.";
    }

    // Help-seeking
    if (message.contains('help') || message.contains('need advice')) {
      return "I'm here to help. Can you tell me more specifically what kind of support you're looking for? We can work through this together.";
    }

    // Stress and anxiety
    if (message.contains('stress') || message.contains('anxious') || message.contains('worry')) {
      return "Stress and anxiety can be overwhelming. Would you like to try some simple breathing exercises? Or we can talk about what's causing your anxiety.";
    }

    // Life situations
    if (message.contains('work') || message.contains('job') || message.contains('career')) {
      return "Work-related stress can be challenging. Would you like to discuss specific situations that are bothering you at work?";
    }

    if (message.contains('family') || message.contains('parent') || message.contains('child')) {
      return "Family relationships can be complex. Would you like to talk more about what's happening with your family?";
    }

    if (message.contains('friend') || message.contains('relationship')) {
      return "Relationships play a big part in our emotional well-being. Would you like to share more about what's going on?";
    }

    // General response for unmatched patterns
    return "I hear you. Would you like to tell me more about how you're feeling? I'm here to listen and support you through whatever you're experiencing.";
  }

  bool _containsConcerningWords(String message) {
    final concerningWords = [
      'suicide',
      'kill',
      'die',
      'end it',
      'give up',
      'harmful',
      'hurt myself',
    ];

    message = message.toLowerCase();
    return concerningWords.any((word) => message.contains(word));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}
