import 'package:flutter/material.dart';

class WhatIfScreen extends StatefulWidget {
  const WhatIfScreen({super.key});

  @override
  State<WhatIfScreen> createState() => _WhatIfScreenState();
}

class _WhatIfScreenState extends State<WhatIfScreen> {
  // Track selected options
  final Set<String> _selectedOptions = {'Long Term Disability'};

  final List<String> _options = [
    'Long Term Disability',
    'Empathy Beneficiary Services',
    'EmployeeConnect Program',
  ];

  void _toggleOption(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        _selectedOptions.add(option);
      }
    });
  }

  void _addToNewPlan() {
    // TODO: Navigate to final plan or process
    print('Adding selected options to new plan: $_selectedOptions');
  }

  void _skip() {
    // TODO: Skip and go to final plan
    print('Skipping What If options');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: Column(
          children: [
            // Replace the "Top header section" (lines 47-52) with this:

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
                      Navigator.pop(context); // Go back to current plan screen
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
                    // What If? Title
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A88C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'What If?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Options
                    ..._options.map(
                      (option) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildOptionChip(option),
                      ),
                    ),
                    const SizedBox(height: 60),

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
                        'Add to New Plan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Skip link
                    TextButton(
                      onPressed: _skip,
                      child: const Text(
                        'SKIP',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF4A90E2),
                          fontWeight: FontWeight.w600,
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

          // Replace the BottomNavigationBar widget (around lines 173-210) with this:
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
                icon: Icon(
                  Icons.analytics_outlined,
                  size: 28,
                ), // Changed from person_outline
                label: 'Analysis', // Changed from Profile
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                  size: 28,
                ), // Changed from favorite_outline
                label: 'Profile', // Changed from Benefits
              ),
            ],
            onTap: (index) {
              // Handle navigation
              switch (index) {
                case 0:
                  // Navigate to Home (back to chat)
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

  Widget _buildOptionChip(String option) {
    final isSelected = _selectedOptions.contains(option);

    return GestureDetector(
      onTap: () => _toggleOption(option),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFC9B5A8),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A90E2) : Colors.transparent,
            width: 3,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.close : Icons.close,
              size: 20,
              color: Colors.black87,
            ),
            const SizedBox(width: 12),
            Text(
              option,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
