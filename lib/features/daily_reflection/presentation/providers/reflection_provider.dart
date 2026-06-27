import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/groq_service.dart';

final groqServiceProvider = Provider<GroqService>((ref) => GroqService());

// Estado de la reflexión
enum ReflectionStatus { idle, loading, success, error }

class ReflectionState {
  final ReflectionStatus status;
  final Map<String, dynamic>? data;
  final String? error;

  const ReflectionState({
    this.status = ReflectionStatus.idle,
    this.data,
    this.error,
  });

  ReflectionState copyWith({
    ReflectionStatus? status,
    Map<String, dynamic>? data,
    String? error,
  }) => ReflectionState(
    status: status ?? this.status,
    data: data ?? this.data,
    error: error ?? this.error,
  );
}

class ReflectionNotifier extends StateNotifier<ReflectionState> {
  final GroqService _groq;
  ReflectionNotifier(this._groq) : super(const ReflectionState());

  Future<void> generate(String userInput) async {
    state = state.copyWith(status: ReflectionStatus.loading);
    try {
      final data = await _groq.generateReflection(userInput);
      state = state.copyWith(status: ReflectionStatus.success, data: data);
    } catch (e) {
      state = state.copyWith(status: ReflectionStatus.error, error: e.toString());
    }
  }

  void reset() => state = const ReflectionState();
}

final reflectionProvider =
    StateNotifierProvider<ReflectionNotifier, ReflectionState>((ref) {
  return ReflectionNotifier(ref.read(groqServiceProvider));
});
