import 'package:flutter/material.dart';
import 'what_if.dart'; // Add this import

class CurrentPlanScreen extends StatefulWidget {
  const CurrentPlanScreen({super.key});

  @override
  State<CurrentPlanScreen> createState() => _CurrentPlanScreenState();
}

class _CurrentPlanScreenState extends State<CurrentPlanScreen> {
  // Traits covered by current plan
  final Set<String> _coveredTraits = {
    'Work Life Balance',
    'Car Accident',
    'Hand Impairment',
  };

  // Traits not covered by current plan
  final Set<String> _notCoveredTraits = {
    'Ice Skating',
    'Glasses/Vision',
    'Digital Lifestyle',
  };

  void _addToNewPlan() {
    // Navigate to What If screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WhatIfScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: Column(
          children: [
            // Top header section
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
                      Navigator.pop(context); // Go back to lifestyle screen
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    // Current Plan Covers Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A88C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Your Current Plan Covers',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Covered traits
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: _coveredTraits
                          .map((trait) => _buildTraitChip(trait, true))
                          .toList(),
                    ),
                    const SizedBox(height: 40),

                    // Current Plan Doesn't Cover Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A88C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Your Current Plan Doesn't Cover:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Not covered traits
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: _notCoveredTraits
                          .map((trait) => _buildTraitChip(trait, false))
                          .toList(),
                    ),
                    const SizedBox(height: 40),

                    // Add to New Plan button
                    ElevatedButton(
                      onPressed: _addToNewPlan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A9B76),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Add to New Plan:',
                        style: TextStyle(
                          fontSize: 20,
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
      // Bottom Navigation Bar
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
              switch (index) {
                case 0:
                  // Navigate to Home
                  Navigator.popUntil(context, (route) => route.isFirst);
                  break;
                case 1:
                  // Already on Analysis flow
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

  Widget _buildTraitChip(String trait, bool isCovered) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFC9B5A8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.close, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          Text(
            trait,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
