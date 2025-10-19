import 'package:finai_app/benefit_form_screen.dart';
import 'package:flutter/material.dart';
import 'terms_conditions.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Header Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF7A9B76),
                      const Color(0xFF7A9B76).withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.analytics_outlined,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Analysis',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'We will help analyze your current lifestyle choices and provide you a better benefits plan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Form Option Card
              _buildOptionCard(
                context: context,
                icon: Icons.edit_document,
                iconColor: const Color(0xFF4A90E2),
                title: 'Fill Form Method',
                description:
                    'Answer a quick questionnaire to help us understand your needs and create a personalized benefits plan',
                buttonText: 'Fill Form',
                buttonColor: const Color(0xFF4A90E2),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BenefitFormScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // OR Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey[400], thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey[400], thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Instagram Option Card
              _buildOptionCard(
                context: context,
                icon: Icons.camera_alt,
                iconColor: const Color(0xFF9B4D96),
                title: 'Instagram Analysis',
                description:
                    'Use our AI-powered Instagram feature to analyze your lifestyle through your posts and get personalized benefit recommendations',
                buttonText: 'Start Analysis',
                buttonColor: const Color(0xFF9B4D96),
                badge: 'NEW',
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: const TermsConditionsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required String buttonText,
    required Color buttonColor,
    required VoidCallback onPressed,
    String? badge,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Icon with badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, size: 48, color: iconColor),
                ),
                if (badge != null)
                  Positioned(
                    top: -8,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            // Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  shadowColor: buttonColor.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
