class Question {
  final int id;
  final String section;
  final String question;
  final String type;
  final List<String>? options;
  final Map<String, dynamic> nextQuestion;

  Question({
    required this.id,
    required this.section,
    required this.question,
    required this.type,
    this.options,
    required this.nextQuestion,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      section: json['section'],
      question: json['question'],
      type: json['type'],
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : null,
      nextQuestion: json['next_question'],
    );
  }
}

class QuestionSet {
  final List<Question> questions;

  QuestionSet({required this.questions});

  factory QuestionSet.fromJson(Map<String, dynamic> json) {
    return QuestionSet(
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}
