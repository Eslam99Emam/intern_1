import 'package:riverpod/legacy.dart';

final startAssessmentProvider = StateProvider<bool>((ref) => false);

class DurationNotifier extends StateNotifier<Duration> {
  DurationNotifier(super.state);

  bool isRunning = false;

  void startDuration() async {
    isRunning = true;
    while (state.inSeconds > 0 && isRunning) {
      state = state - Duration(seconds: 1);
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void stopDuration() {
    isRunning = false;
  }
}

final durationNotifierProvider =
    StateNotifierProvider.family<DurationNotifier, Duration, int>(
      (ref, durationInSeconds) =>
          DurationNotifier(Duration(seconds: durationInSeconds)),
    );
