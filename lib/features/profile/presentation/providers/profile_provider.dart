import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/profile_service.dart';

final profileServiceProvider = Provider<ProfileService>((ref) => ProfileService());

final streakProvider = FutureProvider<int>((ref) async {
  return ref.watch(profileServiceProvider).calculateStreak();
});

final profileProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  return ref.watch(profileServiceProvider).getProfile();
});

class ProfileNotifierState {
  final bool loading;
  final bool saved;
  final String? error;
  const ProfileNotifierState({this.loading=false, this.saved=false, this.error});
  ProfileNotifierState copyWith({bool? loading, bool? saved, String? error}) =>
    ProfileNotifierState(loading: loading??this.loading, saved: saved??this.saved, error: error??this.error);
}

class ProfileNotifier extends StateNotifier<ProfileNotifierState> {
  final ProfileService _svc;
  ProfileNotifier(this._svc) : super(const ProfileNotifierState());

  Future<void> save(String name) async {
    state = state.copyWith(loading: true);
    try {
      await _svc.saveProfile(name);
      state = state.copyWith(loading: false, saved: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final profileNotifierProvider =
  StateNotifierProvider<ProfileNotifier, ProfileNotifierState>((ref) =>
    ProfileNotifier(ref.read(profileServiceProvider)));
