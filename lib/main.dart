import 'package:finai_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';
import 'login_screen.dart';
import 'chat_screen.dart';
import 'Analysis_screen.dart';
import 'terms_conditions.dart';
import 'lifestyle.dart';
import 'ig_connection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _checkAndSignOut() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        // User is already signed in, either auto-navigate or sign them out
        await Amplify.Auth.signOut();
        safePrint('Existing session cleared on login screen');
      }
    } catch (e) {
      safePrint('Session check error: $e');
    }
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
      await _checkAndSignOut();
      safePrint('Successfully configured Amplify');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A9B76)),
        useMaterial3: true,
      ),
      home: _amplifyConfigured
          ? const LoginScreen()
          : const Scaffold(body: Center(child: CircularProgressIndicator())),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/chat': (context) => const ChatScreenContent(),
        '/analysis': (context) => const AnalysisScreen(),
        '/terms': (context) => const TermsConditionsScreen(),
        '/lifestyle': (context) => const LifestyleScreen(),
        '/ig_connection': (context) => const IgConnectionScreen(),
      },
    );
  }
}
