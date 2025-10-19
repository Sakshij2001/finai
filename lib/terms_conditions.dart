import 'package:flutter/material.dart';
import 'ig_connection.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xFFD4D4A8)),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back
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
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Terms & Conditions Card
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC9B5A8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          // Title
                          const Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'serif',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),

                          // Terms text
                          const Text(
                            'We would like to inform you that this application will be going into the Instagram account you provide the username for and will be analyzing your data. This data includes posts, pictures, and highlighted stories. By clicking the "I Agree" button you agree to allow FinAI access your Instagram data.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, height: 1.6),
                          ),
                          const SizedBox(height: 40),

                          // Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Decline Button
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Go back
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB85C5C),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'Decline',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),

                              // I Agree Button
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to Instagram connection screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const IgConnectionScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7A9B76),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'I Agree',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
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
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar - Same as Analysis_screen.dart
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
                  // Navigate to Analysis
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
