import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_long/services/countdown_service.dart';
import 'package:how_long/storage/countdown_storage.dart';
import '../providers/countdown_provider.dart';
import '../models/countdown.dart';

class Functions {
  static void editDate(
    BuildContext context,
    Countdown countdown,
    WidgetRef ref,
    DateTime? date,
  ) async {
    // get stored date and current date
    final now = DateTime.now();

    // show date picker with current date or default
    showDatePicker(
      context: context,
      initialDate: date ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 70),
    )
    // store date in provider
    .then((picked) {
      if (picked != null) {
        final updatedCountdown = Countdown(
          id: countdown.id,
          title: countdown.title,
          targetDate: picked,
          imagePath: countdown.imagePath,
        );
        ref.read(countdownsProvider.notifier).updateCountdown(updatedCountdown);
      }
    });
  }

  static void deleteCountdown(
    BuildContext context,
    Countdown countdown,
    WidgetRef ref,
  ) async {
    // confirm decision
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text(
            'This will erase your countdown, do you want to proceed?',
          ),

          // BUTTONS
          actions: [
            // [ no ]
            ElevatedButton(
              onPressed: () {
                // no action - close dialog
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),

            // [ yes ]
            ElevatedButton(
              onPressed: () async {
                // clear countdown, inform provider and exit dialog
                await CountdownStorage.clearCountdown(countdown.id);
                ref
                    .read(countdownsProvider.notifier)
                    .removeCountdown(countdown.id);

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> addCountdown(BuildContext context, WidgetRef ref) async {
    // controller for title input and selected date
    final titleController = TextEditingController();
    DateTime? pickedDate;

    // dialog to input countdown
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("New Countdown"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TITLE
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                  const SizedBox(height: 8),

                  // DATE PICKER
                  ElevatedButton(
                    onPressed: () async {
                      // get current date
                      final now = DateTime.now();
                      // show date picker
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: now,
                        lastDate: DateTime(now.year + 50),
                      );
                      // update the date if a date is selected
                      if (selectedDate != null) {
                        setState(() {
                          pickedDate = selectedDate;
                        });
                      }
                    },
                    // [ DATE BUTTON TEXT ]
                    child: Text(
                      pickedDate == null
                          ? "Select Date"
                          : "Selected: ${pickedDate!.toLocal().toString().split(' ')[0]}",
                    ),
                  ),
                ],
              ),
              actions: [
                // BUTTONS
                TextButton(
                  // [ cancel ]
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                // [ add ]
                ElevatedButton(
                  onPressed: () {
                    // get title
                    final title = titleController.text.trim();
                    // if it is valid...
                    if (title.isNotEmpty && pickedDate != null) {
                      // ...create new countdown
                      final newCountdown = Countdown(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: title,
                        targetDate: pickedDate!,
                        imagePath: null,
                      );
                      // add countdown to the provider
                      ref
                          .read(countdownsProvider.notifier)
                          .addCountdown(newCountdown);
                      // close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void retirementCountdown(BuildContext context, WidgetRef ref) async {
    // get current date
    final dob = ref.read(dobProvider);

    // show date picker with current DOB as initial date or default
    showDatePicker(
      context: context,
      initialDate: dob ?? DateTime(1991),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    )
    // store DOB in provider
    .then((picked) {
      if (picked != null) {
        ref.read(dobProvider.notifier).state = picked;
        // add countdown to the provider
        ref
            .read(countdownsProvider.notifier)
            .addCountdown(
              Countdown(
                id: 'retirement',
                title: 'Retirement',
                targetDate: RetirementCalculator.getRetirementDate(picked),
              ),
            );
      }
    });
  }

  static void editRetirementDate(BuildContext context, WidgetRef ref) async {
    // get stored date and current date
    final dob = ref.read(dobProvider);
    final retirementDate = RetirementCalculator.getRetirementDate(dob!);

    // show date picker with current date or default
    showDatePicker(
      context: context,
      initialDate: retirementDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    )
    // store date in provider
    .then((picked) {
      if (picked != null) {
        // update the retirement date in the provider
        ref.read(dobProvider.notifier).state = picked;
      }
    });
  }
}
