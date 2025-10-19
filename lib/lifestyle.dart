import 'package:flutter/material.dart';
import 'current_plan.dart';

class LifestyleScreen extends StatefulWidget {
  const LifestyleScreen({super.key});

  @override
  State<LifestyleScreen> createState() => _LifestyleScreenState();
}

class _LifestyleScreenState extends State<LifestyleScreen> {
  // Track selected lifestyle traits
  final Set<String> _selectedTraits = {
    'Car Accident',
    'Digital Lifestyle',
    'Ice Skating',
    'Work Life Balance',
    'Hand Impairment',
    'Glasses/Vision',
  };

  void _toggleTrait(String trait) async {
    // If trait is selected, show confirmation before removing
    if (_selectedTraits.contains(trait)) {
      final shouldRemove = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Trait'),
            content: Text('Are you sure you want to remove "$trait"?'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Remove'),
              ),
            ],
          );
        },
      );

      // If user confirmed, remove the trait
      if (shouldRemove == true) {
        setState(() {
          _selectedTraits.remove(trait);
        });
      }
    } else {
      // If not selected, just add it
      setState(() {
        _selectedTraits.add(trait);
      });
    }
  }

  void _generatePlan() {
    // Navigate to current plan screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CurrentPlanScreen()),
    );
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
                  height: 70,
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    // Analysis result text
                    const Text(
                      'Based on the analysis of your Instagram account, we have found that you might be interested in the following habits/traits:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, height: 1.5),
                    ),
                    const SizedBox(height: 40),

                    // Lifestyle traits chips
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildTraitChip('Car Accident'),
                        _buildTraitChip('Digital Lifestyle'),
                        _buildTraitChip('Ice Skating'),
                        _buildTraitChip('Work Life Balance'),
                        _buildTraitChip('Hand Impairment'),
                        _buildTraitChip('Glasses/Vision'),
                      ],
                    ),
                    const SizedBox(height: 60),

                    // Generate Plan button
                    ElevatedButton(
                      onPressed: _generatePlan,
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
                        'Generates New Plan',
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

  Widget _buildTraitChip(String trait) {
    final isSelected = _selectedTraits.contains(trait);

    return GestureDetector(
      onTap: () => _toggleTrait(trait),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFC9B5A8),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.close : Icons.check,
              size: 20,
              color: Colors.black87,
            ),
            const SizedBox(width: 12),
            Text(
              trait,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
