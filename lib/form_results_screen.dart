import 'package:flutter/material.dart';
import 'current_plan.dart';

class FormResultsScreen extends StatefulWidget {
  final Map<int, String> formAnswers;

  const FormResultsScreen({super.key, required this.formAnswers});

  @override
  State<FormResultsScreen> createState() => _FormResultsScreenState();
}

class _FormResultsScreenState extends State<FormResultsScreen> {
  late List<String> _selectedTraits;

  @override
  void initState() {
    super.initState();
    _selectedTraits = _convertAnswersToTraits();
  }

  List<String> _convertAnswersToTraits() {
    List<String> traits = [];

    // Convert form answers to trait tags
    widget.formAnswers.forEach((questionId, answer) {
      switch (questionId) {
        case 1: // Do you smoke?
          if (answer == 'Yes') traits.add('Smoker');
          break;
        case 2: // How often?
          if (answer == 'Daily') traits.add('Daily Smoker');
          if (answer == 'Occasionally') traits.add('Occasional Smoker');
          break;
        case 3: // Alcohol?
          if (answer == 'Yes') traits.add('Alcohol Consumption');
          break;
        case 4: // How often?
          if (answer == 'Weekly') traits.add('Regular Drinker');
          break;
        case 5: // Health conditions?
          if (answer == 'Yes') traits.add('Pre-existing Condition');
          break;
        case 6: // Which condition?
          traits.add(answer); // Diabetes, Hypertension, etc.
          break;
        case 7: // Work type
          traits.add(answer);
          break;
        case 8: // Exercise?
          if (answer == 'Yes') {
            traits.add('Regular Exercise');
          } else {
            traits.add('Low Physical Activity');
          }
          break;
        case 9: // Fitness rewards?
          if (answer == 'Yes') traits.add('Fitness Conscious');
          break;
        case 10: // Wellness benefits?
          if (answer == 'Yes') traits.add('Wellness Interest');
          break;
        case 11: // Family coverage?
          if (answer == 'Yes') traits.add('Family Coverage Needed');
          break;
        case 12: // Who to include?
          traits.add('Include: $answer');
          break;
        case 13: // Accident coverage?
          if (answer == 'Yes') traits.add('Accident Insurance Interest');
          break;
        case 14: // Budget
          traits.add('Budget: $answer');
          break;
      }
    });

    return traits;
  }

  void _toggleTrait(String trait) {
    setState(() {
      if (_selectedTraits.contains(trait)) {
        _selectedTraits.remove(trait);
      } else {
        _selectedTraits.add(trait);
      }
    });
  }

  void _generatePlan() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CurrentPlanScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Your Selections',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF7A9B76),
      ),
      backgroundColor: const Color(0xFFF5F5DC),
      body: Column(
        children: [
          // Summary banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF7A9B76),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 40),
                const SizedBox(height: 12),
                const Text(
                  'Survey Complete!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'We\'ve identified ${_selectedTraits.length} traits from your responses',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),

          // Trait list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _selectedTraits.length,
              itemBuilder: (context, index) {
                final trait = _selectedTraits[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7A9B76).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF7A9B76),
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7A9B76),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      trait,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7A9B76),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => _toggleTrait(trait),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  '${_selectedTraits.length} traits selected',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _generatePlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A9B76),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Generate Personalized Plan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
