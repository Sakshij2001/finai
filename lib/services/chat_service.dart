import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatService {
  static const String baseUrl =
      'https://finai-api-209447809417.us-central1.run.app';

  String? _sessionId;

  String? get sessionId => _sessionId;

  // Initialize new session
  void startNewSession() {
    _sessionId = const Uuid().v4();
  }

  // Clear session
  Future<void> clearSession() async {
    if (_sessionId != null) {
      try {
        await http.delete(Uri.parse('$baseUrl/chat/clear/$_sessionId'));
      } catch (e) {
        debugPrint('Error clearing session: $e');
      }
      _sessionId = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('chat_session_id');
    }
  }

  // Save session
  Future<void> saveSession() async {
    if (_sessionId != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('chat_session_id', _sessionId!);
    }
  }

  // Load session
  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _sessionId = prefs.getString('chat_session_id');
  }

  // Send message and get response
  Future<ChatResponse> sendMessage({
    required String question,
    required UserPlanData userPlan,
  }) async {
    try {
      // Create session if doesn't exist
      if (_sessionId == null) {
        startNewSession();
      }

      final response = await http
          .post(
            Uri.parse('$baseUrl/chat'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'session_id': _sessionId,
              'question': question,
              'user_plan': userPlan.toJson(),
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _sessionId = data['session_id'];
        await saveSession();
        return ChatResponse.fromJson(data);
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  // Get conversation history
  Future<List<ChatMessage>> getHistory() async {
    if (_sessionId == null) return [];

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/chat/history/$_sessionId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final history = data['history'] as List;
        return history.map((msg) => ChatMessage.fromJson(msg)).toList();
      } else if (response.statusCode == 404) {
        // Session expired/not found - clear it
        debugPrint('Session not found on server, clearing local session');
        _sessionId = null;
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('chat_session_id');
        return [];
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Error getting history: $e');
      return [];
    }
  }
}

// Model for user plan data
class UserPlanData {
  final String name;
  final String coverageLevel;
  final String monthlyCost;
  final List<BenefitItem> included;

  UserPlanData({
    required this.name,
    required this.coverageLevel,
    required this.monthlyCost,
    required this.included,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'coverage_level': coverageLevel,
    'monthly_cost': monthlyCost,
    'included': included.map((b) => b.toJson()).toList(),
  };
}

class BenefitItem {
  final String name;
  final String summary;

  BenefitItem({required this.name, required this.summary});

  Map<String, dynamic> toJson() => {'name': name, 'summary': summary};
}

// Response model
class ChatResponse {
  final bool success;
  final String sessionId;
  final String question;
  final String answer;
  final int conversationLength;

  ChatResponse({
    required this.success,
    required this.sessionId,
    required this.question,
    required this.answer,
    required this.conversationLength,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      success: json['success'] ?? true,
      sessionId: json['session_id'],
      question: json['question'],
      answer: json['answer'],
      conversationLength: json['conversation_length'],
    );
  }
}

// Chat message model
class ChatMessage {
  final String role; // "user" or "model"
  final String content;
  final bool isTyping;

  ChatMessage({
    required this.role,
    required this.content,
    this.isTyping = false,
  });

  bool get isUser => role == 'user';

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(role: json['role'], content: json['content']);
  }
}
