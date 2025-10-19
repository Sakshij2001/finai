import 'dart:convert';
import 'package:finai_app/form_results_screen.dart';
import 'package:flutter/material.dart';
import 'package:finai_app/data/benefit_questions.dart';

class BenefitFormScreen extends StatefulWidget {
  const BenefitFormScreen({super.key});

  @override
  State<BenefitFormScreen> createState() => _BenefitFormScreenState();
}

class _BenefitFormScreenState extends State<BenefitFormScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  Map<int, String> answers = {}; // Store answers by question ID
  List<int> questionHistory = []; // Track question navigation
  int currentQuestionId = 1;
  bool isAnimating = false;

  late Map<String, dynamic> questionsData;
  late Map<int, dynamic> questionsMap;
  int totalQuestions = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  void _loadQuestions() {
    questionsData = json.decode(benefitQuestionsJson);
    questionsMap = {};
    for (var q in questionsData['questions']) {
      questionsMap[q['id']] = q;
    }
    totalQuestions = questionsMap.length;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Map<String, dynamic>? get currentQuestion => questionsMap[currentQuestionId];

  int get questionNumber {
    return questionHistory.length + 1;
  }

  void _handleAnswer(String answer) async {
    if (isAnimating) return;

    setState(() {
      isAnimating = true;
      answers[currentQuestionId] = answer;
    });

    // Fade out
    await _animationController.reverse();

    // Determine next question
    final nextQuestionData = currentQuestion!['next_question'];
    dynamic nextId;

    if (currentQuestion!['type'] == 'yes_no') {
      nextId =
          nextQuestionData[answer.toLowerCase()] ?? nextQuestionData['default'];
    } else {
      nextId = nextQuestionData['default'];
    }
    // Handle completion
    if (nextId == 'show_recommendation' || nextId == 'end') {
      _showResults();
      return;
    }

    setState(() {
      questionHistory.add(currentQuestionId);
      currentQuestionId = nextId;
      isAnimating = false;
    });

    // Fade in
    await _animationController.forward();
  }

  void _goBack() async {
    if (questionHistory.isEmpty || isAnimating) return;

    setState(() => isAnimating = true);

    await _animationController.reverse();

    setState(() {
      currentQuestionId = questionHistory.removeLast();
      answers.remove(currentQuestionId);
      isAnimating = false;
    });

    await _animationController.forward();
  }

  void _showResults() {
    // Navigate to form results screen with answers
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FormResultsScreen(formAnswers: answers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: questionHistory.isEmpty
              ? () => Navigator.pop(context)
              : _goBack,
        ),
        title: Text(
          currentQuestion!['section'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Questions $questionNumber of $totalQuestions',
                      style: TextStyle(
                        color: Color(0xFF7A9B76),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: questionNumber / totalQuestions,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF7A9B76),
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Question content with fade animation
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question text
                    Text(
                      currentQuestion!['question'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Answer options
                    Expanded(
                      child: SingleChildScrollView(
                        child: _buildAnswerOptions(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions() {
    final type = currentQuestion!['type'];

    if (type == 'yes_no') {
      return Column(
        children: [
          _buildOptionButton('Yes'),
          const SizedBox(height: 16),
          _buildOptionButton('No'),
        ],
      );
    } else {
      // Dropdown options
      final options = currentQuestion!['options'] as List<dynamic>;
      return Column(
        children: options.map((option) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildOptionButton(option.toString()),
          );
        }).toList(),
      );
    }
  }

  Widget _buildOptionButton(String option) {
    final isSelected = answers[currentQuestionId] == option;

    return InkWell(
      onTap: () => _handleAnswer(option),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? Colors.lightGreen[50] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.lightGreen[600]! : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.lightGreen[700] : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.lightGreen[600],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}
