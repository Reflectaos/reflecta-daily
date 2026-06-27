import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

enum AuthStatus { idle, loading, success, error }

class AuthNotifierState {
  final AuthStatus status;
  final String? error;
  const AuthNotifierState({this.status = AuthStatus.idle, this.error});
  AuthNotifierState copyWith({AuthStatus? status, String? error}) =>
    AuthNotifierState(status: status ?? this.status, error: error ?? this.error);
}

class AuthNotifier extends StateNotifier<AuthNotifierState> {
  final AuthService _auth;
  AuthNotifier(this._auth) : super(const AuthNotifierState());

  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _auth.signInWithGoogle();
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _auth.signInWithEmail(email, password);
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: _friendlyError(e.toString()));
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      await _auth.registerWithEmail(email, password);
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: _friendlyError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = const AuthNotifierState();
  }

  String _friendlyError(String e) {
    if (e.contains('user-not-found')) return 'No existe una cuenta con ese correo.';
    if (e.contains('wrong-password'))  return 'Contraseña incorrecta.';
    if (e.contains('email-already'))   return 'Este correo ya está registrado.';
    if (e.contains('weak-password'))   return 'La contraseña debe tener al menos 6 caracteres.';
    if (e.contains('invalid-email'))   return 'Correo inválido.';
    return 'Algo salió mal. Intenta de nuevo.';
  }
}

final authNotifierProvider =
  StateNotifierProvider<AuthNotifier, AuthNotifierState>((ref) {
    return AuthNotifier(ref.read(authServiceProvider));
  });
