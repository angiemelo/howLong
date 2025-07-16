import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_long/screens/countdown_screen.dart';
import '../util/functions.dart';
import '../providers/countdown_provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dob = ref.watch(dobProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove back button
        title: const Text(
          "How Long?",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // welcome text
            Text(
              "Welcome to How Long?",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            // spacing
            const SizedBox(height: 24),

            // IF DOB NOT SET
            dob == null
                ? Column(
                  children: [
                    Text(
                      "What is your date of birth?",
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    // spacing
                    const SizedBox(height: 24),

                    // select DOB button
                    IconButton(
                      onPressed:
                          () => Functions.retirementCountdown(context, ref),
                      icon: const Icon(Icons.cake_rounded),
                    ),
                  ],
                )
                // IF DOB SET
                : Column(
                  children: [
                    Text("Tell me about your plans!"),
                    // spacing
                    const SizedBox(height: 24),

                    // [ add countdown ]
                    IconButton(
                      onPressed: () {
                        Functions.addCountdown(context, ref).then((_) {
                          // go to countdown screen
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CountdownScreen(),
                              ),
                            );
                          }
                        });
                      },
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                  ],
                ),
          ],
        ),
      ),

      // bottom corner floating button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SpeedDial(
          icon: Icons.timer_outlined,
          activeIcon: Icons.close,
          backgroundColor: Colors.teal,
          overlayColor: Colors.white,
          overlayOpacity: 0.5,
          onPress:
              // go to countdown screen
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CountdownScreen(),
                ),
              ),
        ),
      ),
    );
  }
}
