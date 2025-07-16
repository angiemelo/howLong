import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  //final dob = await CountdownStorage.getDob();
  final List<Override> overrides = [];

  // if (dob != null) {
  //   overrides.add(dobProvider.overrideWith((ref) => dob));
  // }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(overrides: overrides, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'How Long?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        // useMaterial3: true, // Optional: enable Material 3 if you like
      ),
      home: const HomeScreen(),
    );
  }
}