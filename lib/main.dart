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
import 'what_if.dart';
import 'current_plan.dart';

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

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
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
        '/home': (context) => const MyHomePage(title: 'Home'),
        '/chat': (context) => const ChatScreen(),
        '/analysis': (context) => const AnalysisScreen(),
        '/terms': (context) => const TermsConditionsScreen(),
        '/lifestyle': (context) => const LifestyleScreen(),
        '/ig_connection': (context) => const IgConnectionScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _signOut() async {
    try {
      await Amplify.Auth.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } on AuthException catch (e) {
      safePrint('Error signing out: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
