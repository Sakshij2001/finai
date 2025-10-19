import 'package:finai_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'chat_screen.dart';
import 'analysis_screen.dart';
import 'current_plan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of screens for each tab
  final List<Widget> _screens = [
    const ChatScreenContent(), // Tab 0: Chat
    const AnalysisScreen(), // Tab 1: Analysis
    const CurrentPlanScreen(), // Tab 2: Current Plan
  ];

  Future<void> _signOut() async {
    try {
      // Clear chat session before signing out
      final chatService = ChatService();
      await chatService.clearSession();

      await Amplify.Auth.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } on AuthException catch (e) {
      safePrint('Error signing out: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: const Color(0xFF7A9B76),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            elevation: 0,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined, size: 28, color: Colors.white),
                activeIcon: Icon(Icons.chat, size: 28, color: Colors.white),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.analytics_outlined,
                  size: 28,
                  color: Colors.white,
                ),
                activeIcon: Icon(Icons.chat, size: 28, color: Colors.white),
                label: 'Analysis',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.description_outlined,
                  size: 28,
                  color: Colors.white,
                ),
                activeIcon: Icon(Icons.chat, size: 28, color: Colors.white),
                label: 'Current Plan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
