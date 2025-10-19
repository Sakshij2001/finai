import 'package:flutter/material.dart';
import 'lifestyle.dart';
import 'services/api_service.dart';

class IgConnectionScreen extends StatefulWidget {
  const IgConnectionScreen({super.key});

  @override
  State<IgConnectionScreen> createState() => _IgConnectionScreenState();
}

class _IgConnectionScreenState extends State<IgConnectionScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _submitUsername() async {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a username';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await ApiService.analyzeInstagram(username);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Navigate to lifestyle screen with the API response
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LifestyleScreen(analysisData: response),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to analyze account. Please try again.';
        });

        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Instagram Connection',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF7A9B76),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xFFF5F5DC),
      body: SafeArea(
        child: Expanded(
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
                      const Text(
                        '@',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _usernameController,
                          enabled: !_isLoading,
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

                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
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
      ),
    );
  }
}
