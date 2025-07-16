import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/countdown_service.dart';
import '../models/countdown.dart';

final dobProvider = StateProvider<DateTime?>((ref) => null);

final countdownProvider = StateProvider<String?>((ref) {
  final dob = ref.watch(dobProvider);
  if (dob == null) return null;

  return CountdownService.showHowLong(dob);
});

// Provider to manage a list of Countdown objects
final countdownsProvider =
    StateNotifierProvider<CountdownListNotifier, List<Countdown>>(
      // Create new instance when the provider is initialised
      (ref) => CountdownListNotifier(),
    );

// StateNotifier class that extends Riverpod's StateNotifier
class CountdownListNotifier extends StateNotifier<List<Countdown>> {
  // Initialise the notifier with an empty list of Countdown objects
  CountdownListNotifier() : super([]);

  // Add a new Countdown to the list
  void addCountdown(Countdown countdown) {
    // Create a new list with state and the new countdown
    if (!state.contains(countdown)) {
      state = [...state, countdown];
    }
  }

  // Remove a Countdown by its ID
  void removeCountdown(String id) {
    final index = state.indexWhere((c) => c.id == id);
    // Filter the list to exclude the countdown with the specified ID
    if (index != -1) {
      state = [...state.sublist(0, index), ...state.sublist(index + 1)];
    }
  }

  // Update Countdown
  void updateCountdown(Countdown updated) {
    final index = state.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      state = [
        ...state.sublist(0, index),
        updated,
        ...state.sublist(index + 1),
      ];
    }
  }
}
