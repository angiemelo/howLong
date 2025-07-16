import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_long/services/countdown_service.dart';
import 'package:how_long/screens/home_screen.dart';
import '../providers/countdown_provider.dart';
import '../util/functions.dart';
import '../widgets/countdown_display.dart';

class CountdownScreen extends ConsumerWidget {
  const CountdownScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdowns = ref.watch(countdownsProvider);

    // Sort countdowns by target date
    countdowns.sort((a, b) => a.targetDate.compareTo(b.targetDate));
 
    return Scaffold(
      appBar: AppBar(
        title: const Text("How Long?"),
        // [ HOME BUTTON ]
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // go home
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ), 
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // spacing
            const SizedBox(height: 16),

            // COUNTDOWN LIST
            Expanded(
              child: ListView.builder(
                itemCount: countdowns.length,
                itemBuilder: (context, index) {
                  if (index < countdowns.length) {
                    final countdown = countdowns[index];
                    return

                    // COUNTDOWN CARD
                    CountdownCard(
                      title: countdown.title,
                      description: CountdownService.showHowLong(
                        countdown.targetDate,
                      ),
                      onEdit:
                          () => Functions.editDate(context, countdown, ref, countdown.targetDate),
                      onDelete:
                          () => Functions.deleteCountdown(context, countdown, ref),
                    );
                  } else {
                    return const Center(child: Text('No Countdowns yet'));
                  }
                  }
            ),
        )],
        ),
      ),
      
      // FLOATING ACTION BUTTON
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () => Functions.addCountdown(context, ref),
          tooltip: 'Add Countdown',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
