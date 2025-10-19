import 'package:flutter/material.dart';
import 'lifestyle.dart'; // Add this import

class IgConnectionScreen extends StatefulWidget {
  const IgConnectionScreen({super.key});

  @override
  State<IgConnectionScreen> createState() => _IgConnectionScreenState();
}

class _IgConnectionScreenState extends State<IgConnectionScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _submitUsername() {
    if (_usernameController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate processing delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Navigate to lifestyle screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LifestyleScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: Column(
          children: [
            // Top header section with back button
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xFFD4D4A8)),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to terms & conditions
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 28,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            ),

            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Instruction text
                    const Text(
                      'Please enter your Instagram Account Username below:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, height: 1.4),
                    ),
                    const SizedBox(height: 60),

                    // Username input field
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC9B5A8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // @ symbol
                          const Text(
                            '@',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Text field
                          Expanded(
                            child: TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'alexaAdams07',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                ),
                              ),
                              style: const TextStyle(fontSize: 20),
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _submitUsername(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Enter button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitUsername,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A9B76),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Enter',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar - matching chat_screen.dart exactly
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: 1,
            backgroundColor: const Color(0xFFB8A88A),
            selectedItemColor: const Color(0xFF7A9B76),
            unselectedItemColor: Colors.black54,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 28),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined, size: 28),
                label: 'Analysis',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 28),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              // Handle navigation
              switch (index) {
                case 0:
                  // Navigate to Home (back to chat)
                  Navigator.pop(context);
                  break;
                case 1:
                  // Already on Analysis
                  break;
                case 2:
                  // Navigate to Profile
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
